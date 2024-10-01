<?php

namespace App\Http\Controllers\Admin;

use App\Helpers\Helper;
use App\Http\Controllers\Controller;
use App\Models\BalanceSheet;
use App\Models\CustomUser;
use App\Models\WithdrawRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class WithdrawRequestController extends Controller
{
    public function index()
    {
        $withdraws = WithdrawRequest::with('user')->get();
        return view("admin.pages.withdraw.index", compact("withdraws"));
    }

    public function edit($id)
    {
        $data = WithdrawRequest::findOrFail($id);

        if ($data)
            return view('admin.pages.withdraw.edit', compact('data'));
        else
            return 'Data Not Found!';
    }

    public function update(Request $request, $id)
    {
        // Start the transaction
        DB::beginTransaction();

        try {
            // Find the withdrawal request
            $data = WithdrawRequest::findOrFail($id);

            // Update the status and note
            $data->status = $request->status;
            $data->note = $request->note;
            $data->update();

            if ($request->status == 'paid') {
                // Update the user's balance sheet
                $user = BalanceSheet::where('user_type', 'user')->where('user_id', $data->user_id)->first();
                $user->amount = $user->amount - $data->amount;
                $user->update();

                if($user)
                {
                    $customer = CustomUser::findOrFail($data->user_id);

                    $sms1 = Helper::sendSms(
                        '+88' . $customer->customer_contact_number,
                        "Dear " . $customer->customer_name . "\nYou have received Taka ". $data->payable_amount ." TXN Id: ". $request->note ."\nThanks, \nITR Group",
                    );
                }
            }

            // Commit the transaction
            DB::commit();

            // Redirect back with success message
            return redirect()->back()->with('success', 'Status Updated.');
        } catch (\Exception $e) {
            // Rollback the transaction in case of error
            DB::rollBack();

            // Handle the error, for example, by logging it and returning an error response
            return redirect()->back()->with('error', 'Something went wrong. Please try again.');
        }
    }
}
