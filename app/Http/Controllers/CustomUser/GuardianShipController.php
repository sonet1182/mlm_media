<?php

namespace App\Http\Controllers\CustomUser;

use App\Http\Controllers\Controller;
use App\Models\CustomUser;
use App\Models\Redeem_Beneficiary;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class GuardianShipController extends Controller
{
    function guardian_ship()
    {
        $my_user_id = Auth::guard('customUser')->user()->referrer_id;
        $captainships = CustomUser::where('id', $my_user_id)->get();

        return view('custom_user.pages.guardianship.list', compact('captainships'));
    }



    function guardian_ship_points($id, $month = null, $year = null)
    {
        // Retrieve month and year from query parameters, default to current if not provided
        $month = request('month', Carbon::now()->month);
        $year = request('year', Carbon::now()->year);

        $user = CustomUser::findOrFail($id);
        $redeems = Redeem_Beneficiary::where('rp_beneficiary_id', $id)
            ->whereMonth('created_at', $month)
            ->whereYear('created_at', $year)
            ->where('gb_distribute', 1)
            ->get();

        $total_purchase_bonus = $redeems->where('beneficiary_type', 'Purchase Bonus')->count();
        $total_creating_bonus = $redeems->where('beneficiary_type', 'Creating Bonus')->count();
        $total_refer_bonus = $redeems->where('beneficiary_type', 'Refer Bonus')->count();
        $total_rank_reward_bonus = $redeems->where('beneficiary_type', 'Rank Reward Bonus')->count();
        $total_ada_bonus = $redeems->where('beneficiary_type', 'After Death Allowance')->count();
        $total_cps_bonus = $redeems->where('beneficiary_type', 'Company Profit Share')->count();
        $total_stockiest_ref_bonus = $redeems->where('beneficiary_type', 'Stockiest Refer Bonus')->count();
        $total_cf_bonus = $redeems->where('beneficiary_type', 'Company Fund')->count();

        $total = $total_purchase_bonus + $total_creating_bonus + $total_refer_bonus + $total_rank_reward_bonus + $total_ada_bonus + $total_cps_bonus + $total_stockiest_ref_bonus + $total_cf_bonus;

        return view(
            'custom_user.pages.guardianship.points',
            compact(
                'user',
                'total_purchase_bonus',
                'total_creating_bonus',
                'total_refer_bonus',
                'total_rank_reward_bonus',
                'total_ada_bonus',
                'total_cps_bonus',
                'total_stockiest_ref_bonus',
                'total_cf_bonus',
                'month',  // Pass the selected month to the view
                'year',    // Pass the selected year to the view
                'total'
            )
        );
    }


}
