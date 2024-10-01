<?php

namespace App\Http\Controllers\Stockiest;

use App\Http\Controllers\Controller;
use App\Models\BalanceSheet;
use App\Models\TotalBonusPoint;
use Auth;
use DB;
use Illuminate\Http\Request;

class BalanceController extends Controller
{
    function balance()
    {
        $user = Auth::guard('stockiest')->user();
        $total_point = TotalBonusPoint::where('user_id', $user->id)->first();
        $total_balance = BalanceSheet::where('user_id', $user->id)->first()->amount ?? 0;

        $stockiest_withdraw = $total_point->stockiest_withdraw ?? 0;
        $stockiest_bonus = $total_point->stockiest_bonus ?? 0;
        $stockiest_refer_bonus = $total_point->stockiest_refer_bonus ?? 0;
        $house_rent = $total_point->house_rent ?? 0;
        $currier_cost = $total_point->currier_cost ?? 0;


        return view('stockiest.pages.balance.point_list', compact('user', 'total_balance', 'stockiest_withdraw', 'stockiest_bonus', 'stockiest_refer_bonus', 'house_rent', 'currier_cost'));
    }

    
    public function add_to_balance(Request $request)
    {
        // Validate the incoming request data
        $request->validate([
            'amount' => 'required|numeric|min:20',
            'type' => 'required',
        ]);

        // Get the authenticated user's ID
        $user_id = Auth::guard('stockiest')->user()->id;

        // Retrieve the total points for the user
        $total_point = TotalBonusPoint::where('user_id', $user_id)->first();

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
                        'user_type' => 'stockiest',
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
