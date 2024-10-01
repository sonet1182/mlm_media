<?php

namespace App\Http\Controllers\Stockiest;

use App\Http\Controllers\Controller;
use App\Models\BalanceSheet;
use App\Models\Redeem_Beneficiary;
use App\Models\StockiestWithdrawBalance;
use App\Models\WithdrawRequest;
use Auth;
use DB;
use Illuminate\Http\Request;

class StockiestWithdrawController extends Controller
{
    public function index(Request $request)
    {
        $type = $request->query('type');

        $withdraws = WithdrawRequest::with('user')
            ->where('request_to', 'stockiest')
            ->where('stockiest_id', Auth::guard('stockiest')->user()->id);

        if ($type === 'pending') {
            $withdraws->where('status', 'pending');
        } elseif ($type === 'paid') {
            $withdraws->where('status', 'paid');
        }

        $withdraws = $withdraws->get();

        return view('stockiest.pages.withdraw.index', compact('withdraws', 'type'));
    }

    public function edit($id)
    {
        $data = WithdrawRequest::where("id", $id)->where('request_to', 'stockiest')->where('stockiest_id', Auth::guard('stockiest')->user()->id)->first();

        if ($data)
            return view('stockiest.pages.withdraw.edit', compact('data'));
        else
            return 'Data Not Found!';
    }

    public function update(Request $request, $id)
    {
        DB::beginTransaction();

        try {
            $data = WithdrawRequest::findOrFail($id);
            $data->status = $request->status;
            $data->note = $request->note;
            $data->paid_by = Auth::guard('stockiest')->user()->stockiest_user_id;
            $data->update();


            if ($request->status == 'paid') {
                $user = BalanceSheet::where('user_type', 'user')->where('user_id', $data->user_id)->first();
                $user->amount = $user->amount - $data->amount;
                $user->update();


                DB::table('total_bonus_points')->updateOrInsert(
                    [
                        'user_id' => Auth::guard('stockiest')->user()->id,
                        'benefit_by' => 'stockiest' // Match by user ID and benefit_by
                    ],
                    [
                        'stockiest_withdraw' => DB::raw('stockiest_withdraw + ' . $data->amount),
                    ]
                );
            }


            DB::commit();

            return redirect()->back()->with('success', 'Status Updated.');
        } catch (\Exception $e) {
            DB::rollBack();

            return redirect()->back()->with('error', 'Something went wrong. Please try again.');
        }
    }
}
