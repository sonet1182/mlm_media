<?php

namespace App\Helpers;

use App\Models\CaptainshipBonus;
use App\Models\CbDistributeList;
use App\Models\CustomUser;
use App\Models\EqualBonus;
use App\Models\GuardianshipBonus;
use App\Models\MlmVolume;
use App\Models\Redeem_Beneficiary;
use App\Models\Stockiest;
use App\Models\TotalBonusPoint;
use Carbon\Carbon;
use DateTime;
use App\Models\rp_redeemed_c_user;
use App\Models\Transaction;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Laravolt\Avatar\Avatar;

class Helper
{
    public static function formatDate($dateString, $format = 'Y-m-d')
    {
        $date = new DateTime($dateString);
        return $date->format($format);
    }


    public static function process($transactions, $c_user_id)
    {
        DB::beginTransaction(); // Start the transaction
        try {
            // Update the transaction type
            $txn = Transaction::find($transactions->id);
            $txn->update([
                'transaction_type' => 1
            ]);

            $user = CustomUser::where('id', $c_user_id)->first();
            $ref_u_id = $user->referrer_id;
            $ref_u_a = $ref_u_id == 'null' ? null : $ref_u_id;
            $ref_u_b = $ref_u_c = $ref_u_d = $ref_u_e = $ref_u_f = $ref_u_g = $ref_u_h = $ref_u_i = $ref_u_j = null;
            $status = '';

            $user_b = CustomUser::where('id', $ref_u_id)->first();
            if ($user_b) {
                $ref_u_b = $user_b->referrer_id;
                $user_c = CustomUser::where('id', $ref_u_b)->first();
                if ($user_c) {
                    $ref_u_c = $user_c->referrer_id;
                    $user_d = CustomUser::where('id', $ref_u_c)->first();
                    if ($user_d) {
                        $ref_u_d = $user_d->referrer_id;
                        $user_e = CustomUser::where('id', $ref_u_d)->first();
                        if ($user_e) {
                            $ref_u_e = $user_e->referrer_id;
                            $user_f = CustomUser::where('id', $ref_u_e)->first();
                            if ($user_f) {
                                $ref_u_f = $user_f->referrer_id;
                                $user_g = CustomUser::where('id', $ref_u_f)->first();
                                if ($user_g) {
                                    $ref_u_g = $user_g->referrer_id;
                                    $user_h = CustomUser::where('id', $ref_u_g)->first();
                                    if ($user_h) {
                                        $ref_u_h = $user_h->referrer_id;
                                        $user_i = CustomUser::where('id', $ref_u_h)->first();
                                        if ($user_i) {
                                            $ref_u_i = $user_i->referrer_id;
                                            $user_j = CustomUser::where('id', $ref_u_i)->first();
                                            if ($user_j) {
                                                $ref_u_j = $user_j->referrer_id;
                                                // Now you've reached the 10th generation
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }


            // Bonuses and rewards
            $p_bonus_ac = 10;
            $p_bonus_rp = 30;
            $c_bonus = 10;
            $c_bonus_rp = 20;

            // for repurchase
            $rep_re_c_bonus_a = 1;
            $rep_re_c_bonus_b = 4;
            $rep_re_c_bonus_c = 3;
            $rep_re_c_bonus_d = 3;
            $rep_re_c_bonus_e = 2;
            $rep_re_c_bonus_f = 2;
            $rep_re_c_bonus_g = 1;
            $rep_re_c_bonus_h = 1;
            $rep_re_c_bonus_i = 0.5;
            $rep_re_c_bonus_j = 0.5;

            // for purchase
            $re_c_bonus_a = 1;
            $re_c_bonus_b = 3;
            $re_c_bonus_c = 2;
            $re_c_bonus_d = 2;
            $re_c_bonus_e = 1;
            $re_c_bonus_f = 0.5;
            $re_c_bonus_g = 0.5;



            $rank_bonus = 10;
            // $captainship_bonus = 0; //5
            // $guardianship_bonus = 0; //3
            $after_death_allowance = 2;
            $company_profit_share = 5;
            $stockiest_bonus = 7;
            $stockiest_refer_bonus = 2;
            $depo_bonus = 4;
            $marketing_cost = 5;
            $house_rent = 5;
            $currier_cost = 2;
            $company_fund = 7;

            $pre_reedeemd_data = rp_redeemed_c_user::where('c_user_id', $c_user_id)->first();

            $referral_levels = [
                'ref_u_a' => 1, // Adjust these values as needed
                'ref_u_b' => 2,
                'ref_u_c' => 3,
                'ref_u_d' => 4,
                'ref_u_e' => 5,
                'ref_u_f' => 6,
                'ref_u_g' => 7,
                'ref_u_h' => 8,
                'ref_u_i' => 9,
                'ref_u_j' => 10,
            ];

            // Repurchase
            if ($pre_reedeemd_data) {
                $status = 2;
                $rp_redeemed_data = rp_redeemed_c_user::create([
                    'c_user_id' => $c_user_id,
                    'transaction_id' => $transactions->id,
                    'price_value' => $transactions->total_before_tax,
                    'point' => $transactions->rp_earned,
                    'created_by' => Auth::guard('stockiest')->check() ? Auth::guard('stockiest')->user()->id : null,
                    'created_by_type' => Auth::guard('stockiest')->check() ? 'stockiest' : null,
                    'type' => 'repurchase',
                ]);

                self::createRedeemBeneficiary($rp_redeemed_data->id, $c_user_id, 'Purchase Bonus', $transactions->rp_earned * ($p_bonus_rp / 100), 'user', 'repurchase');
                if ($user->referrer_id) {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $user->referrer_id, 'Creating Bonus', $transactions->rp_earned * ($c_bonus_rp / 100), 'user', 'repurchase');
                }

                self::createRedeemBeneficiariesForReferral(
                    $rp_redeemed_data->id,
                    $transactions->rp_earned,
                    [
                        'ref_u_a' => $ref_u_a,
                        'ref_u_b' => $ref_u_b,
                        'ref_u_c' => $ref_u_c,
                        'ref_u_d' => $ref_u_d,
                        'ref_u_e' => $ref_u_e,
                        'ref_u_f' => $ref_u_f,
                        'ref_u_g' => $ref_u_g,
                        'ref_u_h' => $ref_u_h,
                        'ref_u_i' => $ref_u_i,
                        'ref_u_j' => $ref_u_j,
                    ],
                    [
                        $rep_re_c_bonus_a,
                        $rep_re_c_bonus_b,
                        $rep_re_c_bonus_c,
                        $rep_re_c_bonus_d,
                        $rep_re_c_bonus_e,
                        $rep_re_c_bonus_f,
                        $rep_re_c_bonus_g,
                        $rep_re_c_bonus_h,
                        $rep_re_c_bonus_i,
                        $rep_re_c_bonus_j,
                    ],
                    'repurchase',
                    $referral_levels
                );

                if (Auth::guard('stockiest')->check()) {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, Auth::guard('stockiest')->user()->id, 'Stockiest Bonus', $transactions->rp_earned * ($stockiest_bonus / 100), 'stockiest', 'repurchase');
                    $stock_ref = Stockiest::find(Auth::guard('stockiest')->user()->id);

                    self::createRedeemBeneficiary($rp_redeemed_data->id, $stock_ref->id, 'House Rent', $transactions->rp_earned * ($house_rent / 100), 'stockiest', 'repurchase');
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $stock_ref->id, 'Currier Cost', $transactions->rp_earned * ($currier_cost / 100), 'stockiest', 'repurchase');
                } else {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $user->stockiest_id, 'Stockiest Bonus', $transactions->rp_earned * ($stockiest_bonus / 100), 'stockiest', 'repurchase');
                    $stock_ref = Stockiest::find($user->stockiest_id);

                    self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'House Rent', $transactions->rp_earned * ($house_rent / 100), 'admin', 'repurchase');
                    self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Currier Cost', $transactions->rp_earned * ($currier_cost / 100), 'admin', 'repurchase');
                }


                if ($stock_ref) {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $stock_ref->stockiest_ref_id, 'Stockiest Refer Bonus', $transactions->rp_earned * ($stockiest_refer_bonus / 100), $stock_ref->stockiest_ref_id_type, 'repurchase');
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $stock_ref->depo_id, 'Depo Bonus', $transactions->rp_earned * ($depo_bonus / 100), 'depo', 'repurchase');
                }


                self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Marketing Cost', $transactions->rp_earned * ($marketing_cost / 100), 'admin', 'repurchase');
                self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Company Fund', $transactions->rp_earned * ($company_fund / 100), 'admin', 'repurchase');
            } else {
                $status = 1;
                $user->is_IpActive = 1;
                $user->save();

                $rp_redeemed_data = rp_redeemed_c_user::create([
                    'c_user_id' => $c_user_id,
                    'transaction_id' => $transactions->id,
                    'price_value' => $transactions->total_before_tax,
                    'point' => $transactions->rp_earned,
                    'created_by' => Auth::guard('stockiest')->check() ? Auth::guard('stockiest')->user()->id : null,
                    'created_by_type' => Auth::guard('stockiest')->check() ? 'stockiest' : null,
                    'type' => 'activate',
                ]);

                self::createRedeemBeneficiary($rp_redeemed_data->id, $c_user_id, 'Purchase Bonus', $transactions->rp_earned * ($p_bonus_ac / 100), 'user', 'active');
                if ($user->referrer_id) {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $user->referrer_id, 'Creating Bonus', $transactions->rp_earned * ($c_bonus / 100), 'user', 'active');
                }
                self::createRedeemBeneficiariesForReferral(
                    $rp_redeemed_data->id,
                    $transactions->rp_earned,
                    [
                        'ref_u_a' => $ref_u_a,
                        'ref_u_b' => $ref_u_b,
                        'ref_u_c' => $ref_u_c,
                        'ref_u_d' => $ref_u_d,
                        'ref_u_e' => $ref_u_e,
                        'ref_u_f' => $ref_u_f,
                        'ref_u_g' => $ref_u_g,
                    ],
                    [
                        $re_c_bonus_a,
                        $re_c_bonus_b,
                        $re_c_bonus_c,
                        $re_c_bonus_d,
                        $re_c_bonus_e,
                        $re_c_bonus_f,
                        $re_c_bonus_g
                    ],
                    'active',
                    $referral_levels
                );


                self::createRedeemBeneficiary($rp_redeemed_data->id, $c_user_id, 'Rank Reward Bonus', $transactions->rp_earned * ($rank_bonus / 100), 'user', 'active');
                // self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Captainship Bonus', $transactions->rp_earned * ($captainship_bonus / 100), 'admin', 'active');
                // self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Guardianship Bonus', $transactions->rp_earned * ($guardianship_bonus / 100), 'admin', 'active');
                self::createRedeemBeneficiary($rp_redeemed_data->id, $c_user_id, 'After Death Allowance', $transactions->rp_earned * ($after_death_allowance / 100), 'user', 'active');
                self::createRedeemBeneficiary($rp_redeemed_data->id, $c_user_id, 'Company Profit Share', $transactions->rp_earned * ($company_profit_share / 100), 'user', 'active');

                if (Auth::guard('stockiest')->check()) {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, Auth::guard('stockiest')->user()->id, 'Stockiest Bonus', $transactions->rp_earned * ($stockiest_bonus / 100), 'stockiest', 'active');
                    $stock_ref = Stockiest::find(Auth::guard('stockiest')->user()->id);
                } else {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $user->stockiest_id, 'Stockiest Bonus', $transactions->rp_earned * ($stockiest_bonus / 100), 'stockiest', 'active');
                    $stock_ref = Stockiest::find($user->stockiest_id);
                }

                if ($stock_ref) {
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $stock_ref->stockiest_ref_id, 'Stockiest Refer Bonus', $transactions->rp_earned * ($stockiest_refer_bonus / 100), $stock_ref->stockiest_ref_id_type, 'active');
                    self::createRedeemBeneficiary($rp_redeemed_data->id, $stock_ref->depo_id, 'Depo Bonus', $transactions->rp_earned * ($depo_bonus / 100), 'depo', 'active');
                }



                self::createRedeemBeneficiary($rp_redeemed_data->id, $c_user_id, 'Company Fund', $transactions->rp_earned * ($company_fund / 100), 'admin', 'active');
                // self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Marketing Cost', $transactions->rp_earned * ($marketing_cost / 100), 'admin', 'active');
                // self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'House Rent', $transactions->rp_earned * ($house_rent / 100), 'admin', 'active');
                // self::createRedeemBeneficiary($rp_redeemed_data->id, 0, 'Currier Cost', $transactions->rp_earned * ($currier_cost / 100), 'admin', 'active');

                $sms1 = Helper::sendSms(
                    '+88' . $user->customer_contact_number,
                    "Dear " . $user->customer_name . "\nYou have successfully IP Active registered. Total Product Purchase " . $transactions->total_before_tax . "Taka.  Then IP Active Successfully & Redeem Point " . $transactions->rp_earned . "PV."
                );
            }
            DB::commit(); // Commit the transaction if everything is successful

            return $status;
        } catch (\Exception $e) {
            DB::rollBack(); // Roll back the transaction if there is an error
            throw $e; // Optionally rethrow the exception so it can be handled by the caller
        }
    }


    // Helper function to create a Redeem_Beneficiary
    protected static function createRedeemBeneficiary($redeemed_id, $user_id, $name, $amount, $type, $redeem_type, $level = NULL)
    {
        Redeem_Beneficiary::create([
            'rp_redeemed_id' => $redeemed_id,
            'rp_beneficiary_id' => $user_id,
            'beneficiary_type' => $name,
            'amount' => $amount,
            'benifit_by' => $type,
            'activate_type' => $redeem_type,
            'ref_level' => $level,
        ]);

        if ($name == 'Purchase Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'purchase_bonus' => DB::raw('purchase_bonus + ' . $amount),
                    'benefit_by' => $type
                ]
            );
        }

        if ($name == 'Creating Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'creating_bonus' => DB::raw('creating_bonus + ' . $amount),
                    'benefit_by' => $type
                ],
            );
        }
        if ($name == 'Rank Reward Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'rank_reward_bonus' => DB::raw('rank_reward_bonus + ' . $amount),
                    'benefit_by' => $type
                ],
            );
        }
        if ($name == 'Captainship Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'captainship_bonus' => DB::raw('captainship_bonus + ' . $amount),
                    'benefit_by' => $type
                ],
            );
        }
        if ($name == 'After Death Allowance') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'after_death_allowance' => DB::raw('after_death_allowance + ' . $amount),
                    'benefit_by' => $type
                ],
            );
        }
        if ($name == 'Company Profit Share') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'company_profit_share' => DB::raw('company_profit_share + ' . $amount),
                    'benefit_by' => $type
                ],
            );
        }
        if ($name == 'Refer Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    're_creating_bonus' => DB::raw('re_creating_bonus + ' . $amount),
                    'benefit_by' => $type
                ]
            );
        }
        if ($name == 'Stockiest Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'stockiest_bonus' => DB::raw('stockiest_bonus + ' . $amount),
                    'benefit_by' => $type
                ]
            );
        }
        if ($name == 'Stockiest Refer Bonus') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'stockiest_refer_bonus' => DB::raw('stockiest_refer_bonus + ' . $amount),
                    'benefit_by' => $type
                ]
            );
        }
        if ($name == 'House Rent') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'house_rent' => DB::raw('house_rent + ' . $amount),
                    'benefit_by' => $type
                ]
            );
        }
        if ($name == 'Currier Cost') {
            DB::table('total_bonus_points')->updateOrInsert(
                ['user_id' => $user_id], // Match by user ID
                [
                    'currier_cost' => DB::raw('currier_cost + ' . $amount),
                    'benefit_by' => $type
                ]
            );
        }
    }

    // Helper function to create Redeem_Beneficiaries for referrals
    protected static function createRedeemBeneficiariesForReferral($redeemed_id, $earned, $referral_ids, $bonuses, $redeem_type, $levels)
    {
        foreach ($referral_ids as $key => $referral_id) {
            if ($referral_id) {
                // Use the same key to access the corresponding bonus and level
                $bonus = $bonuses[array_search($key, array_keys($referral_ids))];
                $level = $levels[$key] ?? null; // Get the referral level, default to null if not found
                self::createRedeemBeneficiary($redeemed_id, $referral_id, 'Refer Bonus', $earned * ($bonus / 100), 'user', $redeem_type, $level);
            }
        }
    }


    public static function captain_ship_points($id, $month, $year)
    {
        // Start a database transaction
        DB::beginTransaction();

        try {
            // Retrieve redeem records for the user in the specified month and year
            $redeems = Redeem_Beneficiary::where('rp_beneficiary_id', $id)
                ->where('activate_type', 'active')
                ->whereMonth('created_at', $month)
                ->whereYear('created_at', $year)
                ->get();

            $equal_bonus_points = EqualBonus::where('user_id', $id)
                ->whereMonth('created_at', $month)
                ->whereYear('created_at', $year)
                ->get();

            // Update 'cb_distribute' to 1 for the retrieved records
            $redeems->each(function ($redeem) {
                $redeem->update(['cb_distribute' => 1]);
            });


            // Calculate totals for each bonus type
            $total_purchase_bonus = $redeems->where('beneficiary_type', 'Purchase Bonus')->sum('amount');
            $total_creating_bonus = $redeems->where('beneficiary_type', 'Creating Bonus')->sum('amount');
            $total_refer_bonus = $redeems->where('beneficiary_type', 'Refer Bonus')->sum('amount');
            $total_rank_reward_bonus = $redeems->where('beneficiary_type', 'Rank Reward Bonus')->sum('amount');
            $total_ada_bonus = $redeems->where('beneficiary_type', 'After Death Allowance')->sum('amount');
            $total_cps_bonus = $redeems->where('beneficiary_type', 'Company Profit Share')->sum('amount');
            $total_stockiest_ref_bonus = $redeems->where('beneficiary_type', 'Stockiest Refer Bonus')->sum('amount');
            $total_equal_bonus = $equal_bonus_points->sum('bonus_amount');

            // Calculate the total bonus
            $total_bonus = $total_purchase_bonus + $total_creating_bonus + $total_refer_bonus +
                $total_rank_reward_bonus + $total_ada_bonus + $total_cps_bonus +
                $total_stockiest_ref_bonus + $total_equal_bonus;

            CaptainshipBonus::create([
                'user_id' => $id,
                'month' => $month . '-' . $year,
                'total' => $total_bonus,
            ]);

            // Commit the transaction
            DB::commit();
        } catch (\Exception $e) {
            // Rollback the transaction if there is an exception
            DB::rollBack();

            // Optionally, rethrow the exception or handle it according to your needs
            throw $e;
        }
    }


    public static function guardian_ship_points($id, $month, $year, $user_id)
    {
        // Start a database transaction
        DB::beginTransaction();

        try {
            $redeems = Redeem_Beneficiary::where('rp_beneficiary_id', $id)
                ->where('activate_type', 'active')
                ->whereMonth('created_at', $month)
                ->whereYear('created_at', $year)
                ->get();

            $equal_bonus_points = EqualBonus::where('user_id', $id)
                ->whereMonth('created_at', $month)
                ->whereYear('created_at', $year)
                ->get();

            // Update 'gb_distribute' to 1 for the retrieved records
            $redeems->each(function ($redeem) {
                $redeem->update(['gb_distribute' => 1]);
            });

            $total_purchase_bonus = $redeems->where('beneficiary_type', 'Purchase Bonus')->sum('amount');
            $total_creating_bonus = $redeems->where('beneficiary_type', 'Creating Bonus')->sum('amount');
            $total_refer_bonus = $redeems->where('beneficiary_type', 'Refer Bonus')->sum('amount');
            $total_rank_reward_bonus = $redeems->where('beneficiary_type', 'Rank Reward Bonus')->sum('amount');
            $total_ada_bonus = $redeems->where('beneficiary_type', 'After Death Allowance')->sum('amount');
            $total_cps_bonus = $redeems->where('beneficiary_type', 'Company Profit Share')->sum('amount');
            $total_stockiest_ref_bonus = $redeems->where('beneficiary_type', 'Stockiest Refer Bonus')->sum('amount');
            $total_equal_bonus = $equal_bonus_points->sum('bonus_amount');

            $total_bonus = $total_purchase_bonus + $total_creating_bonus + $total_refer_bonus + $total_rank_reward_bonus + $total_ada_bonus + $total_cps_bonus + $total_stockiest_ref_bonus + $total_equal_bonus;

            // Calculate 3% of the total bonus
            $guardianship_bonus_increment = $total_bonus * 0.03;

            // Update the guardianship_bonus column for the user
            TotalBonusPoint::where('user_id', $user_id)->increment('guardianship_bonus', $guardianship_bonus_increment);

            GuardianshipBonus::create([
                'user_id' => $user_id,
                'month' => $month . '-' . $year,
                'total' => $total_bonus,
            ]);

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }


    public static function renderTree($user, $depth = 0, $maxDepth = 3)
    {
        if (!$user || $depth >= $maxDepth)
            return;

        // Fetch additional information for tooltip
        $downlineA = CustomUser::find($user->placement_a);
        $downlineB = CustomUser::find($user->placement_b);

        // Get node sums
        $nodeSums = self::getNodeSums($user->id);
        $leftSum = $nodeSums ? $nodeSums['leftSum'] : 0;
        $rightSum = $nodeSums ? $nodeSums['rightSum'] : 0;
        $leftActiveIp = $nodeSums ? $nodeSums['leftActiveIp'] : 0;
        $rightActiveIp = $nodeSums ? $nodeSums['rightActiveIp'] : 0;
        $leftNonActiveIp = $nodeSums ? $nodeSums['leftNonActiveIp'] : 0;
        $rightNonActiveIp = $nodeSums ? $nodeSums['rightNonActiveIp'] : 0;

        // Tooltip content
        $tooltipContent1 = '<table>
                            <tr><th>Full Name:</th><td>' . htmlspecialchars($user->customer_name) . $user->id . '</td></tr>
                            <tr><th>Creating By:</th><td>' . htmlspecialchars($user->referredBy ? $user->referredBy->user_id : '') . '</td></tr>
                            <tr><th>Designation:</th><td>' . htmlspecialchars($user->is_IpActive == 1 ? 'IP' : 'Custom User') . '</td></tr>
                        </table>';

        $tooltipContent2 = '<table>
                            <tr>
                                <th>Side</th>
                                <th>Team A</th>
                                <th>Team B</th>
                            </tr>

                            <tr>
                                <th>Team Sales</th>
                                <th>' . htmlspecialchars($leftSum) . '</th>
                                <th>' . htmlspecialchars($rightSum) . '</th>
                            </tr>

                            <tr>
                                <th>Team Carry</th>
                                <th>--</th>
                                <th>--</th>
                            </tr>

                            <tr>
                                <th>Team Active Id</th>
                                <th>' . htmlspecialchars($leftActiveIp) . '</th>
                                <th>' . htmlspecialchars($rightActiveIp) . '</th>
                            </tr>

                            <tr>
                                <th>Team Free Id</th>
                                <th>' . htmlspecialchars($leftNonActiveIp) . '</th>
                                <th>' . htmlspecialchars($rightNonActiveIp) . '</th>
                            </tr>
                        </table>';

        $tooltipContent = $tooltipContent1 . $tooltipContent2;



        echo '<li>';
        if (auth()->guard('customUser')->check()) {
            echo '<a href="' . url('user/sales_team/genealogy_tree/' . $user->id) . '">';
        } elseif (auth()->guard('stockiest')->check()) {
            echo '<a href="' . url('stockiest/placement/tree/' . $user->id) . '">';
        } else {
            echo '<a href="' . url('admin/placement/tree/' . $user->id) . '">';
        }

        echo '<div class="member-view-box" data-tooltip="' . htmlspecialchars($tooltipContent) . '">';

        // Create an instance of Avatar
        $avatar = new Avatar();

        if ($user->photo == null) {
            $avatarImage = asset('img/pro_pic.jpg');
            echo '<div class="member-image"><img src="' . $avatarImage . '"
            style="width: 50px; height: 50px; border-radius: 50%;"
            alt="User Image"/></div>';
        } else {
            $imagePath = asset($user->photo);
            echo '<div class="member-image"><img src="' . $imagePath . '"
            style="width: 50px; height: 50px; border-radius: 50%;"
            alt="User Image" /></div>';
        }

        echo '<div class="member-footer">';
        echo '<div class="name"><span>' . htmlspecialchars($user->user_id) . '</span></div>';

        // Calculate and display downline info
        $downlineCountA = $downlineA ? 1 : 0;
        $downlineCountB = $downlineB ? 1 : 0;
        echo '<div class="downline"><span>' . $downlineCountA . ' | ' . $downlineCountB . '</span></div>';
        echo '</div></div></a>';

        if ($downlineA || $downlineB) {
            echo '<ul>';
            self::renderTree($downlineA, $depth + 1, $maxDepth);
            self::renderTree($downlineB, $depth + 1, $maxDepth);
            echo '</ul>';
        }

        echo '</li>';
    }



    public static function sumTree($node, &$leftSum, &$rightSum, &$leftActiveIp, &$rightActiveIp, &$leftNonActiveIp, &$rightNonActiveIp, $side)
    {
        if (!$node)
            return;

        // Sum the price_value from the purchase relationship
        $purchaseSum = $node->purchase()->sum('price_value');


        if ($side === 'left') {
            $leftSum += $purchaseSum; // Replace 'some_value' with the actual field you are summing
            if ($node->is_IpActive == 1) {
                $leftActiveIp++;
            } else {
                $leftNonActiveIp++;
            }
        } else if ($side === 'right') {
            $rightSum += $purchaseSum; // Replace 'some_value' with the actual field you are summing
            if ($node->is_IpActive == 1) {
                $rightActiveIp++;
            } else {
                $rightNonActiveIp++;
            }
        }

        if ($node->placement_a) {
            $childNode = CustomUser::find($node->placement_a);
            self::sumTree($childNode, $leftSum, $rightSum, $leftActiveIp, $rightActiveIp, $leftNonActiveIp, $rightNonActiveIp, $side);
        }

        if ($node->placement_b) {
            $childNode = CustomUser::find($node->placement_b);
            self::sumTree($childNode, $leftSum, $rightSum, $leftActiveIp, $rightActiveIp, $leftNonActiveIp, $rightNonActiveIp, $side);
        }
    }

    public static function getNodeSums($nodeId)
    {
        $node = CustomUser::find($nodeId);
        if (!$node)
            return null;

        $leftSum = 0;
        $rightSum = 0;
        $leftActiveIp = 0;
        $rightActiveIp = 0;
        $leftNonActiveIp = 0;
        $rightNonActiveIp = 0;

        // Sum left side nodes
        if ($node->placement_a) {
            $leftChild = CustomUser::find($node->placement_a);
            self::sumTree($leftChild, $leftSum, $rightSum, $leftActiveIp, $rightActiveIp, $leftNonActiveIp, $rightNonActiveIp, 'left');
        }

        // Sum right side nodes
        if ($node->placement_b) {
            $rightChild = CustomUser::find($node->placement_b);
            self::sumTree($rightChild, $leftSum, $rightSum, $leftActiveIp, $rightActiveIp, $leftNonActiveIp, $rightNonActiveIp, 'right');
        }

        $diff = $rightSum - $leftSum;
        $side = null;

        if ($diff < 0) {
            $side = 'left';
        } elseif ($diff > 0) {
            $side = 'right';
        }

        return [
            'leftSum' => $leftSum,
            'rightSum' => $rightSum,
            'diff' => $diff < 0 ? abs($diff) : $diff,
            'side' => $side,
            'leftActiveIp' => $leftActiveIp,
            'rightActiveIp' => $rightActiveIp,
            'leftNonActiveIp' => $leftNonActiveIp,
            'rightNonActiveIp' => $rightNonActiveIp,
        ];
    }



    public static function getAllNodesUnder($nodeId)
    {
        $nodesList = [];
        $node = CustomUser::find($nodeId);

        if (!$node) {
            return null;
        }

        self::collectNodes($node, $nodesList);

        return $nodesList;
    }

    private static function collectNodes($node, &$nodesList)
    {
        if (!$node) {
            return;
        }

        $nodesList[] = $node;

        if ($node->placement_a) {
            $leftChild = CustomUser::find($node->placement_a);
            self::collectNodes($leftChild, $nodesList);
        }

        if ($node->placement_b) {
            $rightChild = CustomUser::find($node->placement_b);
            self::collectNodes($rightChild, $nodesList);
        }
    }


    public static function getAllNodesWithPurchaseDetails($nodeId)
    {
        $nodesList = [];
        $node = CustomUser::find($nodeId);

        if (!$node) {
            return null; // Node not found
        }

        self::collectNodesWithPurchases($node, $nodesList);

        return $nodesList;
    }

    private static function collectNodesWithPurchases($node, &$nodesList)
    {
        if (!$node) {
            return;
        }

        // Fetch the node's purchase details
        $nodePurchases = $node->purchase()->get();

        // Add the node along with its purchase details to the list
        $nodesList[] = [
            'node' => $node,
            'purchases' => $nodePurchases,
        ];

        // Recursively collect nodes from children
        if ($node->placement_a) {
            $leftChild = CustomUser::find($node->placement_a);
            self::collectNodesWithPurchases($leftChild, $nodesList);
        }

        if ($node->placement_b) {
            $rightChild = CustomUser::find($node->placement_b);
            self::collectNodesWithPurchases($rightChild, $nodesList);
        }
    }


    public static function getAllPurchasesUnderNode($nodeId)
    {
        $purchasesList = [];
        $node = CustomUser::find($nodeId);

        if (!$node) {
            return null; // Node not found
        }

        self::collectPurchases($node, $purchasesList);

        return $purchasesList;
    }

    private static function collectPurchases($node, &$purchasesList)
    {
        if (!$node) {
            return;
        }

        $nodePurchases = $node->purchase()
            ->with(['users', 'transactions'])
            ->get()
            ->toArray();

        $purchasesList = array_merge($purchasesList, $nodePurchases);

        if ($node->placement_a) {
            $leftChild = CustomUser::find($node->placement_a);
            self::collectPurchases($leftChild, $purchasesList);
        }

        if ($node->placement_b) {
            $rightChild = CustomUser::find($node->placement_b);
            self::collectPurchases($rightChild, $purchasesList);
        }
    }




    public static function sendSms($phone, $message)
    {
        $parameters = [
            'message' => $message,
            'mobile_number' => $phone,
            'device' => 'e66b369b1daacd7d',
        ];

        $header = [
            'apikey: TILC3BFVQLCCYRMGS2S4TPZF9AYKL2SDSO2B9NJJ'
        ];

        $url = 'https://smsserver.xyz/api/v1/sms/send';

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $parameters);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }

    // Equal Bonus
    public static function recordSale($user_id, $point)
    {
        $maxLevels = 5;
        $currentLevel = 0;

        $currentUserId = $user_id;

        while ($currentUserId && $currentLevel < $maxLevels) {
            $currentUser = CustomUser::find($currentUserId);

            if (!$currentUser || !$currentUser->parent_id) {
                break;
            }
            $parentId = $currentUser->parent_id;
            $parentVolume = MlmVolume::firstOrCreate(['user_id' => $parentId]);

            $placement = self::getPlacement($currentUserId);

            if ($placement == 'left') {
                $parentVolume->left_leg_volume += $point + $parentVolume->left_leg_carried_over;
                $parentVolume->left_leg_carried_over = 0;

                // Check if there's excess volume between the legs
                $excessVolume = $parentVolume->left_leg_volume - $parentVolume->right_leg_volume;
                if ($excessVolume > 0) {
                    $parentVolume->left_leg_carried_over = $excessVolume;
                    $parentVolume->left_leg_volume = $parentVolume->right_leg_volume;
                }
            } elseif ($placement == 'right') {
                $parentVolume->right_leg_volume += $point + $parentVolume->right_leg_carried_over;
                $parentVolume->right_leg_carried_over = 0;

                // Check if there's excess volume between the legs
                $excessVolume = $parentVolume->right_leg_volume - $parentVolume->left_leg_volume;
                if ($excessVolume > 0) {
                    $parentVolume->right_leg_carried_over = $excessVolume;
                    $parentVolume->right_leg_volume = $parentVolume->left_leg_volume;
                }

            } else {
                \Log::error("Invalid placement for user_id: {$currentUserId}");
            }

            $parentVolume->save();

            $currentUserId = $parentId;
            $currentLevel++;
        }

        // return response()->json(['message' => 'Sale recorded and propagated successfully!']);
    }


    private static function getPlacement($userId)
    {
        $user = CustomUser::findOrFail($userId);
        if ($user->parent) {
            if ($user->parent->placement_a == $userId) {
                return 'left';
            } else if ($user->parent->placement_b == $userId) {
                return 'right';
            }
        }
    }


    public static function distributeDailyBonuses()
    {
        // Fetch all sales from the previous day
        // $yesterdaySales = rp_redeemed_c_user::where('type', 'activate')->whereDate('created_at', Carbon::yesterday())->get();
        $yesterdaySales = rp_redeemed_c_user::where('type', 'activate')->get();

        foreach ($yesterdaySales as $sale) {
            // Get the user's total volumes and calculate carried-over volume
            $userVolume = MlmVolume::where('user_id', $sale->c_user_id)->first();

            if ($userVolume) {
                // Calculate the matching volume and carry-over excess
                $matchedVolume = self::calculateMatchingVolume($userVolume);

                // Calculate the bonus as 5% of the matching volume
                $bonusPoints = $matchedVolume * 0.05;

                // Distribute the bonus to the user's 5-level parents
                self::distributeBonusToParents($sale->c_user_id, $bonusPoints);
            }
        }
    }

    private static function calculateMatchingVolume($userVolume)
    {
        // Calculate the matched volume (minimum of both legs)
        $matchedVolume = min($userVolume->left_leg_volume, $userVolume->right_leg_volume);

        // Carry over excess volume to the next day
        $leftCarryOver = max(0, $userVolume->left_leg_volume - $matchedVolume);
        $rightCarryOver = max(0, $userVolume->right_leg_volume - $matchedVolume);

        // Update the carried-over volume for future calculations
        $userVolume->left_leg_volume = $leftCarryOver;
        $userVolume->right_leg_volume = $rightCarryOver;
        $userVolume->save();

        return $matchedVolume;
    }

    private static function distributeBonusToParents($userId, $bonusPoints)
    {
        // Traverse up to 5 levels of parents
        $currentUser = CustomUser::find($userId);
        for ($level = 1; $level <= 5; $level++) {
            if ($currentUser->parent) {
                $parent = $currentUser->parent;

                // Distribute bonus to the parent
                self::giveBonusToUser($parent->id, $bonusPoints, $level);

                // Move up to the next parent
                $currentUser = $parent;
            } else {
                // Stop if there are no more parents
                break;
            }
        }
    }

    private static function giveBonusToUser($userId, $bonusAmount, $level)
    {
        EqualBonus::create([
            'c_user_id' => $userId,
            'bonus_amount' => $bonusAmount,
            'level' => $level,
        ]);
    }

}
