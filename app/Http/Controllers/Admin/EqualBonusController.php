<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\CustomUser;
use App\Models\EqualBonus;
use App\Models\rp_redeemed_c_user;
use Carbon\Carbon;
use DB;
use Illuminate\Http\Request;
use App\Helpers\Helper;

class EqualBonusController extends Controller
{
    public function tree($id)
    {
        return view('tree-view', compact('id'));
    }

    public function tree_row($id)
    {
        $nodes = $this->getRowOrStemGrouped($id);

        return $nodes;
    }


    public function getRowOrStemGrouped($nodeId)
    {
        // Find the node in the database
        $node = CustomUser::where('id', $nodeId)->first();

        if (!$node) {
            return response()->json(['error' => 'Node not found'], 404);
        }

        // Find the parent of the node
        $parentNode = CustomUser::where('id', $node->parent_id)->first();

        if (!$parentNode) {
            return response()->json(['error' => 'Parent node not found'], 404);
        }

        // Check if the parent node has a parent (i.e., check for grandparent)
        $grandParentNode = CustomUser::where('id', $parentNode->parent_id)->first();

        if (!$grandParentNode) {
            // If there is no grandparent, return all children of the root (i.e., all siblings of the parent)
            $rowNodes = CustomUser::where('parent_id', $parentNode->id)->get();
        } else {
            // Get all children of the grandparent, which are the parents of the row/stem nodes
            $parentsInRow = CustomUser::where('parent_id', $grandParentNode->id)->get();

            // Collect all nodes that are children of these parents (this forms the row)
            $rowNodes = collect();

            foreach ($parentsInRow as $parent) {
                $children = CustomUser::where('parent_id', $parent->id)->get();
                $rowNodes = $rowNodes->merge($children);
            }
        }

        // return $rowNodes;

        // Initialize the array to group nodes by parent_id
        $groupedNodes = [];

        // Iterate over each node in the rowNodes array
        foreach ($rowNodes as $rowNode) {
            // Get the parent_id of the current node
            $parentId = $rowNode->parent_id;

            // Initialize the group for this parent_id if it doesn't exist
            if (!isset($groupedNodes[$parentId])) {
                $groupedNodes[$parentId] = [];
            }

            // Add the node to the corresponding parent_id group
            $groupedNodes[$parentId][] = $rowNode;
        }

        return $groupedNodes;
    }



    public function getNthGenerationParent($nodeId, $generation)
    {
        // Find the node by its ID
        $node = CustomUser::find($nodeId);

        // If the node doesn't exist, return null
        if (!$node) {
            return null;
        }

        // Initialize the current generation level
        $currentGeneration = 1;

        // Traverse up the hierarchy until we reach the nth generation
        while ($node && $currentGeneration < $generation) {
            $node = CustomUser::find($node->parent_id);
            $currentGeneration++;
        }

        // Return the parent_id of the nth generation ancestor, or null if not found
        return $node ? $node->customer_name : null;
    }


    public function sumNodeSides($nodeId)
    {
        return $value = Helper::getNodeSums($nodeId);
    }

    public function getSumsForGenerations($nodeId, $maxGeneration = 5)
    {
        $sumsList = [];
        $currentNodeId = $nodeId;
        $currentGeneration = 1;

        while ($currentGeneration <= $maxGeneration) {
            // Get the sums for the current node
            $sums = $this->sumNodeSides($currentNodeId);

            // Add the sums to the list with the generation number
            $sumsList[] = [
                'generation' => $currentGeneration,
                'node_id' => $currentNodeId,
                'leftSum' => $sums['leftSum'],
                'rightSum' => $sums['rightSum'],
                'diff' => $sums['diff'],
                'side' => $sums['side'],
            ];

            // Move to the parent node for the next generation
            $parentNode = $this->getNthGenerationParent($currentNodeId, 2); // Getting immediate parent (next level)

            if (!$parentNode) {
                break;
            }

            // Update the current node ID to the parent's ID for the next loop
            $currentNodeId = CustomUser::where('customer_name', $parentNode)->first()->id;
            $currentGeneration++;
        }

        return $sumsList;
    }



    public function distributeDailyBonuses()
    {
        // Fetch all sales from the previous day
        $yesterdaySales = rp_redeemed_c_user::where('type', 'activate')->whereDate('created_at', Carbon::yesterday())->get();


        foreach ($yesterdaySales as $sale) {
            $this->saveEqualBonuses($sale->c_user_id);
        }
    }





    public function saveEqualBonuses($id)
    {
        $equalBonusesData = $this->equal_bonus($id); // Get the bonuses data
        $today = now()->format('Y-m-d'); // Get today's date in 'Y-m-d' format

        foreach ($equalBonusesData as $bonus) {
            if ($bonus['equal_bonus'] > 0) {
                // Check if the record already exists for the same user and date
                $existingBonus = EqualBonus::where('user_id', $bonus['id'])
                    ->whereDate('date', $today)
                    ->first();

                if (!$existingBonus) {
                    // Create a new entry in the equal_bonuses table
                    EqualBonus::create([
                        'user_id' => $bonus['id'], // Assuming 'id' refers to the user
                        'bonus_amount' => $bonus['equal_bonus'],
                        'left_sum' => $bonus['leftSum'],
                        'right_sum' => $bonus['rightSum'],
                        'carry' => $bonus['carry'],
                        'carry_side' => $bonus['side'],
                        'date' => $today, // Save today's date
                    ]);

                    DB::table('total_bonus_points')->updateOrInsert(
                        ['user_id' => $bonus['id']], // Match by user ID
                        [
                            'equal_bonus' => DB::raw('equal_bonus + ' . $bonus['equal_bonus']),
                            'benefit_by' => 'user'
                        ],
                    );
                }
            }
        }
    }


    public function equal_bonus($id)
    {
        $array = [];
        $user = CustomUser::findOrFail($id);

        $currentUser = $user;
        $generationCount = 0; // Initialize a counter

        // Loop through the parent hierarchy with a generation limit
        while ($currentUser && $generationCount < 6) {
            // Get purchase sums for the current user
            $data = $this->getNodePurhaseSums($currentUser->id);
            array_push($array, $data);

            // Move to the parent user
            $currentUser = $currentUser->parent;

            // Increment the generation counter
            $generationCount++;
        }

        return $array; // Return the array with purchase sums
    }




    //Equal Bonus

    public static function getNodePurhaseSums($nodeId)
    {
        $node = CustomUser::find($nodeId);
        if (!$node)
            return null;

        $leftSum = 0;
        $rightSum = 0;

        // Sum left side nodes
        if ($node->placement_a) {
            $leftChild = CustomUser::find($node->placement_a);
            self::sumTree($leftChild, $leftSum, $rightSum, 'left');
        }

        // Sum right side nodes
        if ($node->placement_b) {
            $rightChild = CustomUser::find($node->placement_b);
            self::sumTree($rightChild, $leftSum, $rightSum, 'right');
        }

        $diff = $rightSum - $leftSum;
        $side = null;

        if ($diff < 0) {
            $side = 'left';
        } elseif ($diff > 0) {
            $side = 'right';
        }

        return [
            'id' => $nodeId,
            'leftSum' => $leftSum,
            'rightSum' => $rightSum,
            'point' => min($leftSum, $rightSum),
            'carry' => max($leftSum, $rightSum) - min($leftSum, $rightSum),
            'side' => $side,
            'equal_bonus' => min($leftSum, $rightSum) * 0.05,
        ];
    }


    public static function sumTree($node, &$leftSum, &$rightSum, $side)
    {
        if (!$node)
            return;

        // Sum the price_value from the purchase relationship
        $purchaseSum = $node->active_purchase()->sum('point');


        if ($side === 'left') {
            $leftSum += $purchaseSum; // Replace 'some_value' with the actual field you are summing
        } else if ($side === 'right') {
            $rightSum += $purchaseSum; // Replace 'some_value' with the actual field you are summing
        }

        if ($node->placement_a) {
            $childNode = CustomUser::find($node->placement_a);
            self::sumTree($childNode, $leftSum, $rightSum, $side);
        }

        if ($node->placement_b) {
            $childNode = CustomUser::find($node->placement_b);
            self::sumTree($childNode, $leftSum, $rightSum, $side);
        }
    }


    public static function findNodeSide($rootNode, $targetNodeId)
    {
        $rootNode = CustomUser::find($rootNode);

        // Check if the root node is the target node
        if ($rootNode->id == $targetNodeId) {
            return null; // It's the root itself
        }

        // Check the left side
        if ($rootNode->placement_a) {
            $leftChild = CustomUser::find($rootNode->placement_a);
            if (self::isNodeInTree($leftChild, $targetNodeId)) {
                return 'left';
            }
        }

        // Check the right side
        if ($rootNode->placement_b) {
            $rightChild = CustomUser::find($rootNode->placement_b);
            if (self::isNodeInTree($rightChild, $targetNodeId)) {
                return 'right';
            }
        }

        // If node is not found
        return null;
    }

    public static function isNodeInTree($node, $targetNodeId)
    {
        if (!$node) {
            return false;
        }

        // If the node matches the target ID, return true
        if ($node->id == $targetNodeId) {
            return true;
        }

        // Recursively check both left and right children
        return self::isNodeInTree(CustomUser::find($node->placement_a), $targetNodeId) ||
            self::isNodeInTree(CustomUser::find($node->placement_b), $targetNodeId);
    }
}
