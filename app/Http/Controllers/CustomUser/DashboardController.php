<?php

namespace App\Http\Controllers\CustomUser;

use App\Http\Controllers\Controller;
use App\Models\BalanceSheet;
use App\Models\CaptainshipBonus;
use App\Models\EqualBonus;
use App\Models\GuardianshipBonus;
use App\Models\Notice;
use App\Models\Redeem_Beneficiary;
use App\Models\TotalBonusPoint;
use App\Models\WithdrawRequest;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use App\Helpers\Helper;


class DashboardController extends Controller
{


    function dashboard()
    {
        $user = Auth::guard('customUser')->user();
        $total_income_all = Redeem_Beneficiary::where('rp_beneficiary_id', $user->id)
            ->where('benifit_by', 'user');

        $total_income1 = $total_income_all->where(function ($query) {
            $query->where('beneficiary_type', 'Purchase Bonus')
                ->orWhere('beneficiary_type', 'Creating Bonus')
                ->orWhere('beneficiary_type', 'Refer Bonus')
                ->orWhere('beneficiary_type', 'Stockiest Refer Bonus');
        })->sum('amount');


        $captainship_bonus = CaptainshipBonus::where('user_id', $user->id)->sum('total');
        $guardianship_bonus = GuardianshipBonus::where('user_id', $user->id)->sum('total');
        $total_equal_bonus = EqualBonus::where('user_id', $user->id)->sum('bonus_amount');

        $total_income = $total_income1 + $captainship_bonus * 05 + $guardianship_bonus * 03 + $total_equal_bonus;

        $total_point = TotalBonusPoint::where('user_id', $user->id)->first();
        $total_balance = BalanceSheet::where('user_id', $user->id)->first()->amount ?? 0;
        $all_user_list = collect(Helper::getAllNodesUnder($user->id));
        $all_user = $all_user_list->count();
        $activeUsersCount = $all_user_list->where('is_IpActive', 1)->count();

        $purchase_bonus = $total_point->purchase_bonus ?? 0;
        $creating_bonus = $total_point->creating_bonus ?? 0;
        $re_creating_bonus = $total_point->re_creating_bonus ?? 0;
        $rank_reward_bonus = $total_point->rank_reward_bonus ?? 0;
        $stockiest_refer_bonus = $total_point->stockiest_refer_bonus ?? 0;
        $ada = $total_point->after_death_allowance ?? 0;
        $cps = $total_point->company_profit_share ?? 0;
        $cf = $total_point->company_fund ?? 0;
        $cb = $total_point->captainship_bonus ?? 0;
        $gb = $total_point->guardianship_bonus ?? 0;

        $all_withdraw = WithdrawRequest::where('user_id', auth()->guard('customUser')->user()->id)->sum('amount') ?? 0;
        $complete_withdraw = WithdrawRequest::where('user_id', auth()->guard('customUser')->user()->id)->where('status', 'paid')->sum('amount') ?? 0;
        $pending_withdraw = WithdrawRequest::where('user_id', auth()->guard('customUser')->user()->id)->where('status', 'pending')->sum('amount') ?? 0;

        $today = Carbon::today();
        $notice = Notice::whereJsonContains('notice_for', 'user')
            ->whereDate('start_from', '<=', $today)
            ->whereDate('end_to', '>=', $today)
            ->get();

        return view('dashboard', compact(
            'user',
            'all_user',
            'activeUsersCount',
            'total_income',
            'total_balance',
            'purchase_bonus',
            'creating_bonus',
            're_creating_bonus',
            'rank_reward_bonus',
            'stockiest_refer_bonus',
            'total_equal_bonus',
            'ada',
            'cps',
            'cf',
            'cb',
            'gb',
            'all_withdraw',
            'complete_withdraw',
            'pending_withdraw',
            'notice'
        ));
    }

}
