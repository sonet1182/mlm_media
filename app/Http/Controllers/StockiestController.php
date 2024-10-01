<?php

namespace App\Http\Controllers;

use App\Models\BalanceSheet;
use App\Models\CustomUser;
use App\Models\Notice;
use App\Models\Redeem_Beneficiary;
use App\Models\Stockiest;
use App\Models\TotalBonusPoint;
use App\Models\WithdrawRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\Depo;
use Illuminate\Support\Carbon;

class StockiestController extends Controller
{
    public function dashboard()
    {
        $total_balance = BalanceSheet::where('user_id', Auth::guard('stockiest')->user()->id)->where('user_type', 'stockiest')->first()->amount ?? 0;
        $users = CustomUser::where('stockiest_id', Auth::guard('stockiest')->user()->id)->count();
        $active_users = CustomUser::where('stockiest_id', Auth::guard('stockiest')->user()->id)->where('is_IpActive', 1)->count();
        $user_withdraw_all = WithdrawRequest::where('request_to', 'stockiest')
            ->where('stockiest_id', Auth::guard('stockiest')->user()->id);
        $user_withdraw = $user_withdraw_all->sum('amount');
        $user_withdraw_pending = WithdrawRequest::where('request_to', 'stockiest')
            ->where('stockiest_id', Auth::guard('stockiest')->user()->id)->where('status', 'pending')->sum('amount');
        $user_withdraw_paid = WithdrawRequest::where('request_to', 'stockiest')
            ->where('stockiest_id', Auth::guard('stockiest')->user()->id)->where('status', 'paid')->sum('amount');

        $my_withdraw_all = WithdrawRequest::where('user_id', Auth::guard('stockiest')->user()->id)
            ->where('user_type', 'stockiest');
        $my_withdraw = $my_withdraw_all->sum('amount');
        $my_withdraw_pending = $my_withdraw_all->where('status', 'pending')->sum('amount');
        $my_withdraw_paid = $my_withdraw_all->where('status', 'paid')->sum('amount');

        $total_point = TotalBonusPoint::where('user_id', Auth::guard('stockiest')->user()->id)->first();
        $house_rent = $total_point->house_rent ?? 0;
        $currier_cost = $total_point->currier_cost ?? 0;
        $stockiest_bonus = $total_point->stockiest_bonus ?? 0;

        $total_income_all = Redeem_Beneficiary::where('rp_beneficiary_id', Auth::guard('stockiest')->user()->id)
            ->where('benifit_by', 'stockiest');
        $total_income = $total_income_all->where(function ($query) {
            $query->where('beneficiary_type', 'Stockiest Bonus')
                ->orWhere('beneficiary_type', 'House Rent')
                ->orWhere('beneficiary_type', 'Currier Cost');
        })->sum('amount');

        $today = Carbon::today();
        $notice = Notice::whereJsonContains('notice_for', 'user')
            ->whereDate('start_from', '<=', $today)
            ->whereDate('end_to', '>=', $today)
            ->get();

        return view('dashboard.stockist', compact(
            'total_balance',
            'users',
            'active_users',
            'user_withdraw',
            'user_withdraw_pending',
            'user_withdraw_paid',
            'my_withdraw',
            'my_withdraw_pending',
            'my_withdraw_paid',
            'house_rent',
            'currier_cost',
            'stockiest_bonus',
            'total_income',
            'notice'
        ));
    }




    public function stockiest_user_logout()
    {
        Auth::guard('stockiest')->logout();
        return redirect()->route('welcome');
    }
    function stockiest_user_login(Request $request)
    {
        if (Stockiest::where('stockiest_user_id', $request->stockiest_id)->exists()) {
            if (Auth::guard('stockiest')->attempt(['stockiest_user_id' => $request->stockiest_id, 'password' => $request->password])) {
                return redirect()->route('stockiest.dashboard');

            } else {
                return back()->with('error', 'Password Does Not Exists');
            }
        } else {
            return back()->with('error', 'User Id Does Not Exists');
        }
    }

    function stockiest_depo_list()
    {
        $depos = Depo::all();
        return view('custom_depo_auth.stockiest_depo_customer', [
            'depos' => $depos,
        ]);
    }
    function stockiest_depo_add()
    {
        return view('custom_depo_auth.stockiest_depo_add');
    }
    function stockiest_depo_add_post(Request $request)
    {
        // $num = 0+1;
        // $incr = ++$num;

        //  $sum = 1 + $incr;
        $count = 0;
        $count += 1;
        $ids = Str::lower(str_replace(' ', '-', 'DEPO-ITRHCL-000')) . random_int(1, 100);
        $count = Depo::count() + 1;
        $id = 'depo-itrhcl-000' . $count;



        $depo_id = 'DEPO-ITRHCL-000' . uniqid();
        Depo::insert([

            'depo_name' => $request->depo_name,
            'contact_person_name' => $request->depo_contact_personal_name,
            'contact_number' => $request->depo_contact_number,
            'depo_email_id' => $request->depo_email_id,
            'depo_address' => $request->depo_address,
            'depo_arya' => $request->depo_arya,
            'depo_user_id' => $id,


            'password' => Hash::make($request->depo_user_password)



        ]);
        return redirect()->route('stockiest.depo.list');

    }

    function stockiest_custom_add()
    {
        return view('custom_user.stockiest_custom_add');
    }
    function stockiest_custom_add_post(Request $request)
    {
        $user_ref_id = $ids = Str::lower(str_replace(' ', '-', 'STOCKIST-ISP-000')) . random_int(1, 100) . '.' . uniqid();
        $count = CustomUser::count() + 1;
        $id = 'ITRHCL-000' . $count;

        CustomUser::insert([
            'customer_name' => $request->customer_name,
            'customer_contact_number' => $request->customer_contact_number,
            'customer_email' => $request->customer_email,
            'customer_address' => $request->customer_address,
            'stockiest_id' => $request->stockiest_id,
            'user_ref_id' => $request->user_ref_id,
            'place_user_id' => $request->place_user_id,
            'user_id' => $id,
            'placement_side' => $request->place_side,
            'password' => Hash::make($request->user_password),
            'created_at' => Carbon::now(),

        ]);
        return redirect()->route('stockiest.customer.list');

    }
}
