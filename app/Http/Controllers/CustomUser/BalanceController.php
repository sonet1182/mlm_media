<?php

namespace App\Http\Controllers\CustomUser;

use App\Http\Controllers\Controller;
use App\Models\BalanceSheet;
use App\Models\Redeem_Beneficiary;
use App\Models\TotalBonusPoint;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class BalanceController extends Controller
{
    function balance()
    {
        $user = Auth::guard('customUser')->user();
        $total_point = TotalBonusPoint::where('user_id', $user->id)->where('benefit_by', 'user')->first();
        $total_balance = BalanceSheet::where('user_id', $user->id)->where('user_type', 'user')->first()->amount ?? 0;

        $purchase_bonus = $total_point->purchase_bonus ?? 0;
        $creating_bonus = $total_point->creating_bonus ?? 0;
        $re_creating_bonus = $total_point->re_creating_bonus ?? 0;
        $rank_reward_bonus = $total_point->rank_reward_bonus ?? 0;
        $ada = $total_point->after_death_allowance ?? 0;
        $cps = $total_point->company_profit_share ?? 0;
        $cf = $total_point->company_fund ?? 0;
        $cb = $total_point->captainship_bonus ?? 0;
        $gb = $total_point->guardianship_bonus ?? 0;
        $sto_ref_bonus = $total_point->stockiest_refer_bonus ?? 0;
        $equal_bonus = $total_point->equal_bonus ?? 0;

        return view('custom_user.pages.balance.point_list', compact('user', 'total_balance', 'purchase_bonus', 'creating_bonus', 're_creating_bonus', 'rank_reward_bonus', 'ada', 'cps', 'cf', 'cb', 'gb', 'sto_ref_bonus', 'equal_bonus'));
    }

    public function add_to_balance(Request $request)
    {
        // Validate the incoming request data
        $request->validate([
            'amount' => 'required|numeric|min:20',
            'type' => 'required',
        ]);

        // Get the authenticated user's ID
        $user_id = Auth::guard('customUser')->user()->id;

        // Retrieve the total points for the user
        $total_point = TotalBonusPoint::where('user_id', $user_id)->where('benefit_by', 'user')->first();

        // Get the maximum amount available for the specified bonus type
        $max_amount = $total_point->{$request->type}; // Correctly access the property using {}

        // Check if the requested amount is less than or equal to the available amount
        if ($max_amount >= $request->amount) {
            DB::beginTransaction(); // Start the transaction
            try {
                // Update the user's total bonus points, adding the requested amount
                DB::table('balance_sheets')->updateOrInsert(
                    ['user_id' => $user_id], // Match by user ID
                    [
                        'amount' => DB::raw('amount + ' . $request->amount),
                        'user_type' => 'user',
                    ]
                );

                // Deduct the requested amount from the specific bonus type
                $total_point->update([
                    $request->type => $total_point->{$request->type} - $request->amount,
                ]);

                DB::commit(); // Commit the transaction

                return redirect()->back()->with('success', 'Balance added successfully.');

            } catch (\Exception $e) {
                DB::rollBack(); // Rollback the transaction in case of error
                return redirect()->back()->with('error', 'An error occurred: ' . $e->getMessage());
            }
        } else {
            return redirect()->back()->with('error', 'Insufficient balance for this operation.');
        }
    }


}
