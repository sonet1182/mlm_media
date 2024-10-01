<?php

namespace App\Http\Controllers;

use App\Models\rp_redeemed_c_user;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class XyzController extends Controller
{
    function xyz(){
        return view('Redeem.xyz');
    }
    function depo_xyz(){
        return view('Redeem.depo_xyz');
    }
    function stockiest_xyz(){
        return view('Redeem.xyz_stockiest');
    }
    function transaction_action(Request $request){

        // $transactions=DB::table('transactions')->where('invoice_no', $request->invoice_no)->first();
        $transactions=DB::table('transactions')->where('invoice_no',$request->invoice_no)->where('total_before_tax',$request->total_before_tax)->where('rp_earned',$request->rp_redeemed_amount)->first();
        // dd($transactions, $request->all());

        if($transactions){
            if($transactions->transaction_type==0){
                Transaction::find($transactions->id)->update([
                    'transaction_type'=>1

                ]);
                rp_redeemed_c_user::create([
                    'c_user_id'=>$request->customer_id,
                    'transaction_id'=>$transactions->id,
                ]);

                return back()->with('transactions','This transaction setup successfully');

            }
            else{
                return back()->with('transaction','This transaction alreay used');

            }


        }
        else{
            return back()->with('transaction','Oops! This Transaction does not exists
            ');
        }




    }
}
