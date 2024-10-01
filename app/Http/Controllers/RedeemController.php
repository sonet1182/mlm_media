<?php

namespace App\Http\Controllers;

use App\Helpers\Helper;
use App\Models\CaptainshipBonus;
use App\Models\CustomUser;
use App\Models\EqualBonus;
use App\Models\GardianshipBonus;
use App\Models\Redeem_Beneficiary;
use App\Models\rp_redeemed_c_user;
use App\Models\Transaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class RedeemController extends Controller
{
    function redeem()
    {
        return view('Redeem.redeem');
    }


    function depo_xyz()
    {
        return view('Redeem.depo_xyz');
    }
    function stockiest_xyz()
    {
        return view('Redeem.xyz_stockiest');
    }


    function transaction_action(Request $request)
    {
        $transactions = Transaction::where('invoice_no', $request->invoice_no)
            ->where('total_before_tax', $request->total_before_tax)
            ->where('rp_earned', $request->rp_redeemed_amount)
            ->first();

        if ($transactions) {
            if ($transactions->transaction_type == 0) {

                $data = Helper::process($transactions, $request->customer_id);
                
                if ($data == 1) {
                    // Helper::recordSale($request->customer_id, $request->rp_redeemed_amount);
                    return back()->with('transactions', 'This transaction setup successfully and Ip Activated.');
                } else {
                    return back()->with('transactions', 'This transaction setup successfully');
                }

            } else {
                return back()->with('transaction', 'This transaction alreay used');
            }
        } else {
            return back()->with('transaction', 'Oops! This transaction does not exists');
        }
    }


    function ipActiveSuccess($c_user_id, $transaction_id)
    {
        $user = CustomUser::where('id', 'c_user_id')->first();
        $rp_redeemed = rp_redeemed_c_user::where('transaction_id', $transaction_id)->with('beneficiary', 'transactions')->first();
        return view('ip_active_success', compact('user', 'rp_redeemed'));
    }

    public function redeem_list(Request $request)
    {
        $query = rp_redeemed_c_user::with('users', 'transactions');

        // If date range is provided, filter the query
        if ($request->has('start_date') && $request->has('end_date')) {
            $start_date = $request->start_date;
            $end_date = Carbon::parse($request->end_date)->endOfDay(); // sets time to 23:59:59
            
            $query->whereBetween('created_at', [$start_date, $end_date]);
        }

        $redeemList = $query->get();

        // Calculate the total price value and total points
        $total_price_value = $redeemList->sum('price_value');
        $total_point = $redeemList->sum('point');

        // If it's an AJAX request, return the table rows and totals
        if ($request->ajax()) {
            return response()->json([
                'html' => view('Redeem.partials.redeemListTable', compact('redeemList'))->render(),
                'total_price_value' => $total_price_value,
                'total_point' => $total_point,
            ]);
        }

        // Otherwise, return the full view
        return view('Redeem.redeemList', compact('redeemList', 'total_price_value', 'total_point'));
    }


    function redeem_list_details($id)
    {
        $purchase = rp_redeemed_c_user::findOrFail($id);
        $redeems = Redeem_Beneficiary::where('rp_redeemed_id', $id)->with('custom_user', 'stockiest')->get();
        return view('admin.pages.redeem.list', compact('redeems', 'purchase'));
    }

    function process()
    {

        // for($i=1;$i>63;$i++){
        //     echo $i .'<br>';
        // }
        $td = 1000;
        for ($i = 1; $i <= 63; $i++) {
            // echo (string)$i;
            // echo number_format($i, 2, ',','.') .'<br>';
            if ($i < 10) {
                // echo ($td+$i).' - '. ('test00'.$i).'<br/>';
                $transaction = Transaction::where('invoice_no', ($td + $i))->first();
                $user = CustomUser::where('user_id', ('test00' . $i))->first();
            } else {
                // echo  ($td+$i).' - '. ('test0'.$i).'<br/>';
                $transaction = Transaction::where('invoice_no', ($td + $i))->first();
                $user = CustomUser::where('user_id', ('test0' . $i))->first();
            }
            // $transaction=Transaction::where('invoice_no', '1001')->first();
            // $user=CustomUser::where('user_id', 'test001')->first();
            $data = Helper::process($transaction, $user->id);
        }
        // $transaction=Transaction::where('invoice_no', '1001')->first();
        // $user=CustomUser::where('user_id', 'test001')->first();

        return 'done';
    }

    public function equal_process()
    {

        $c_users = CustomUser::all();
        // echo '<pre>';

        foreach ($c_users as $c_user) {
            $l1a = 0;
            $l1b = 0;
            $l2a = 0;
            $l2b = 0;
            $l3a = 0;
            $l3b = 0;
            $l4a = 0;
            $l4b = 0;
            $l5a = 0;
            $l5b = 0;

            //level 1
            $l1auser = CustomUser::where('place_user_id', $c_user->id)->where('placement_side', 'A')->first();
            $l1buser = CustomUser::where('place_user_id', $c_user->id)->where('placement_side', 'B')->first();
            // dd($l1auser);
            // foreach ($l1users as $l1user) {
            if ($l1auser) {
                $redeem_dtl1a = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l1auser->id)->where('type', 'activate')->first();
                if ($redeem_dtl1a) {
                    $l1a = $redeem_dtl1a->transactions->rp_earned;
                }


                $l2_AA_user = CustomUser::where('place_user_id', $l1auser->id)->where('placement_side', 'A')->first();
                $l2_AB_user = CustomUser::where('place_user_id', $l1auser->id)->where('placement_side', 'B')->first();
                // dd($l1auser,$l1auser->id,$redeem_dtl1a);
                if ($l2_AA_user && $l2_AB_user) {
                    $redeem_dtl2_AA = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l2_AA_user->id)->where('type', 'activate')->first();
                    if ($redeem_dtl2_AA) {
                        $l2a += $redeem_dtl2_AA->transactions->rp_earned;
                    }
                    $redeem_dtl2_AB = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l2_AB_user->id)->where('type', 'activate')->first();
                    if ($redeem_dtl2_AB) {
                        $l2a += $redeem_dtl2_AB->transactions->rp_earned;
                    }

                    //level 3 left
                    $l3_AAA_user = CustomUser::where('place_user_id', $l2_AA_user->id)->where('placement_side', 'A')->first();
                    $l3_AAB_user = CustomUser::where('place_user_id', $l2_AA_user->id)->where('placement_side', 'B')->first();
                    $l3_ABA_user = CustomUser::where('place_user_id', $l2_AB_user->id)->where('placement_side', 'A')->first();
                    $l3_ABB_user = CustomUser::where('place_user_id', $l2_AB_user->id)->where('placement_side', 'B')->first();
                    // dd($l1auser,$l1auser->id,$redeem_dtl1a);
                    if ($l3_AAA_user && $l3_AAB_user && $l3_ABA_user && $l3_ABB_user) {
                        $redeem_dtl3_AAA = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_AAA_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_AAA) {
                            $l3a += $redeem_dtl3_AAA->transactions->rp_earned;
                        }
                        $redeem_dtl3_AAB = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_AAB_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_AAB) {
                            $l3a += $redeem_dtl3_AAB->transactions->rp_earned;
                        }
                        $redeem_dtl3_ABA = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_ABA_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_ABA) {
                            $l3a += $redeem_dtl3_ABA->transactions->rp_earned;
                        }
                        $redeem_dtl3_ABB = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_ABB_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_ABB) {
                            $l3a += $redeem_dtl3_ABB->transactions->rp_earned;
                        }
                        // echo $l2_AAA_user->id .' - '. $l2_AAB_user->id .' - '. $l2_ABA_user->id .' - '. $l2_ABB_user->id. '  - '. $l3a .'<br/>';
                    }


                }
            }
            if ($l1buser) {
                $redeem_dtl1b = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l1buser->id)->where('type', 'activate')->first();
                if ($redeem_dtl1b) {
                    $l1b = $redeem_dtl1b->transactions->rp_earned;
                }

                $l2_BA_user = CustomUser::where('place_user_id', $l1buser->id)->where('placement_side', 'A')->first();
                $l2_BB_user = CustomUser::where('place_user_id', $l1buser->id)->where('placement_side', 'B')->first();

                if ($l2_BA_user && $l2_BB_user) {
                    $redeem_dtl2_BA = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l2_BA_user->id)->where('type', 'activate')->first();
                    if ($redeem_dtl2_BA) {
                        $l2b += $redeem_dtl2_BA->transactions->rp_earned;
                    }
                    $redeem_dtl2_BB = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l2_BB_user->id)->where('type', 'activate')->first();
                    if ($redeem_dtl2_BB) {
                        $l2b += $redeem_dtl2_BB->transactions->rp_earned;
                    }

                    //level 3 Right
                    $l3_BAA_user = CustomUser::where('place_user_id', $l2_BA_user->id)->where('placement_side', 'A')->first();
                    $l3_BAB_user = CustomUser::where('place_user_id', $l2_BA_user->id)->where('placement_side', 'B')->first();
                    $l3_BBA_user = CustomUser::where('place_user_id', $l2_BB_user->id)->where('placement_side', 'A')->first();
                    $l3_BBB_user = CustomUser::where('place_user_id', $l2_BB_user->id)->where('placement_side', 'B')->first();
                    // dd($l1auser,$l1auser->id,$redeem_dtl1a);
                    if ($l3_BAA_user && $l3_BAB_user && $l3_BBA_user && $l3_BBB_user) {
                        $redeem_dtl3_BAA = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_BAA_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_BAA) {
                            $l3b += $redeem_dtl3_BAA->transactions->rp_earned;
                        }
                        $redeem_dtl3_BAB = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_BAB_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_BAB) {
                            $l3b += $redeem_dtl3_BAB->transactions->rp_earned;
                        }
                        $redeem_dtl3_BBA = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_BBA_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_BBA) {
                            $l3b += $redeem_dtl3_BBA->transactions->rp_earned;
                        }
                        $redeem_dtl3_BBB = rp_redeemed_c_user::with('transactions')->where('c_user_id', $l3_BBB_user->id)->where('type', 'activate')->first();
                        if ($redeem_dtl3_BBB) {
                            $l3b += $redeem_dtl3_BBB->transactions->rp_earned;
                        }
                        echo $l3_BAA_user->id . ' - ' . $l3_BAB_user->id . ' - ' . $l3_BBA_user->id . ' - ' . $l3_BBB_user->id . '  - ' . $l3b . '<br/>';
                    }

                }

                echo $l1auser->id . ' - ' . $l1buser->id . ' - L1A: ' . $l1a . ' - L1B: ' . $l1b . ' - L2A: ' . $l2a . ' - L2B: ' . $l2b . ' - L3A: ' . $l3a . ' - L3B: ' . $l3b . ' - L4A: ' . $l4a . ' - L4B: ' . $l4b . ' - L5A: ' . $l5a . ' - L5B: ' . $l5b . '<br>';
                $total = $l1a + $l1b + $l2a + $l2b + $l3a + $l3b + $l4a + $l4b + $l5a + $l5b;
                // dd($l1a, $l1b, $l2a, $l2b, $l3a, $l3b, $l4a, $l4b, $l5a, $l5b);
                if ($l1a > 0) {
                    if ($l5a > 0) {
                        EqualBonus::updateOrCreate(
                            ['c_user_id' => $c_user->id],
                            [
                                'l1a' => $l1a,
                                'l1b' => $l1b,
                                'l2a' => $l2a,
                                'l2b' => $l2b,
                                'l3a' => $l3a,
                                'l3b' => $l3b,
                                'l4a' => $l4a,
                                'l4b' => $l4b,
                                'l5a' => $l5a,
                                'l5b' => $l5b,
                                'total' => $total,
                                'status' => 'complete'
                            ]
                        );
                    } else {
                        EqualBonus::updateOrCreate(
                            ['c_user_id' => $c_user->id],
                            [
                                'l1a' => $l1a,
                                'l1b' => $l1b,
                                'l2a' => $l2a,
                                'l2b' => $l2b,
                                'l3a' => $l3a,
                                'l3b' => $l3b,
                                'l4a' => $l4a,
                                'l4b' => $l4b,
                                'l5a' => $l5a,
                                'l5b' => $l5b,
                                'total' => $total,
                                'status' => 'progress'
                            ]
                        );
                    }

                }
            }


            // }
        }

        die('hello');
    }

    function monthly_guardian_captainship_process()
    {
        $redeemed_users = rp_redeemed_c_user::all();
        $date = \Carbon\Carbon::now();
        $cmonth = $date->format('F');
        // dd($redeemed_users);
        foreach ($redeemed_users as $redeemed_user) {
            GardianshipBonus::updateOrCreate([
                'c_user_id' => $redeemed_user->c_user_id,
                'month' => $cmonth
            ]);

            CaptainshipBonus::updateOrCreate([
                'c_user_id' => $redeemed_user->c_user_id,
                'month' => $cmonth
            ]);
        }
        return 'done';
    }


    public function process1()
    {
        $redeemed_users = rp_redeemed_c_user::all();
        foreach ($redeemed_users as $redeemed_user) {
            $c_user = CustomUser::find($redeemed_user->c_user_id);
            $c_user->is_IpActive = 1;
            $c_user->save();
        }
        return 'done';
    }

    public function dist_equal_bonus()
    {
        Helper::distributeDailyBonuses();

        return 'Equal Bonus Distributed';
    }

}
