<?php

namespace App\Http\Controllers\Stockiest;

use App\Http\Controllers\Controller;
use App\Models\Redeem_Beneficiary;
use Auth;

class BonusController extends Controller
{
    public function bonus_list2(){
        $bonus = Redeem_Beneficiary::where("rp_beneficiary_id", Auth::guard('stockiest')->user()->id)->with('redeem_c_user')->latest()->get();
        return view('stockiest.pages.refer_bonus.list', compact('bonus'));
    }

    function bonus_list($type)
    {
        $user = Auth::guard('stockiest')->user();

        $redeemed = Redeem_Beneficiary::where('rp_beneficiary_id', $user->id)->where('benifit_by', 'stockiest');


        if ($type == 'stockiest_bonus') {
            $bonus_type = 'Stockiest Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'house_rent') {
            $bonus_type = 'House Rent';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'currier_cost') {
            $bonus_type = 'Currier Cost';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }

        return view('stockiest.pages.bonus.list', compact('bonus_type', 'rp_redeemed'));
    }
}
