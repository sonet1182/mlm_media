<?php

namespace App\Http\Controllers;

use App\Models\CaptainshipBonus;
use App\Models\CbDistributeList;
use App\Models\CustomUser;
use App\Models\EqualBonus;
use App\Models\GsDistributeList;
use App\Models\Redeem_Beneficiary;
use App\Models\Referral;
use App\Models\rp_redeemed_c_user;
use App\Models\Stockiest;
use App\Models\TotalBonusPoint;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Helpers\Helper;

class UserAdminController extends Controller
{
    function user_add()
    {
        $count = CustomUser::count() + 1;
        $user_id = 'ITRHCL-000' . $count;
        return view('custom_user.user', compact('user_id'));
    }


    function customer_user_add()
    {
        $count = CustomUser::count() + 1;
        $user_id = 'ITRHCL-000' . $count;
        return view('custom_user.add_customer', compact('user_id'));
    }


    public function user_user_list_user(Request $request)
    {
        $user_ref_id = $ids = Str::lower(str_replace(' ', '-', 'STOCKIST-ISP-000')) . random_int(1, 100) . '.' . uniqid();
        $count = CustomUser::count() + 1;
        $id = 'ITRHCL-000' . $count;

        // Validate the request data
        $request->validate([
            'customer_email' => "required|email|unique:custom_users,customer_email",
            'customer_contact_number' => [
                'required',
                'unique:custom_users,customer_contact_number',
                'regex:/^01[0-9]{9}$/'
            ],
            'customer_address' => "required",
        ]);


        // Check placement availability
        $parentUser = CustomUser::find($request->place_user_id);
        if ($request->place_side == 'A' && $parentUser->placement_a) {
            return back()->with('errors', 'Placement A is not available');
        } elseif ($request->place_side == 'B' && $parentUser->placement_b) {
            return back()->with('errors', 'Placement B is not available');
        }

        // Create the new user
        $newUser = CustomUser::create([
            'customer_name' => $request->customer_name,
            'customer_contact_number' => $request->customer_contact_number,
            'customer_email' => $request->customer_email,
            'customer_address' => $request->customer_address,
            'stockiest_id' => $request->stockiest_id,
            'user_ref_id' => $user_ref_id,
            'referrer_id' => $request->user_ref_id,
            'user_id' => $id,
            'place_user_id' => $request->place_user_id,
            'placement_side' => $request->place_side,
            'password' => Hash::make($request->user_password),
            'created_at' => Carbon::now(),
            'parent_id' => $request->place_user_id,
        ]);

        // Update placement
        if ($request->place_side == 'A') {
            $parentUser->placement_a = $newUser->id;
        } elseif ($request->place_side == 'B') {
            $parentUser->placement_b = $newUser->id;
        }
        if ($parentUser) {
            $parentUser->save();
        }
        // Create the referral entry if a referrer is provided
        if ($request->has('user_ref_id')) {
            $referrer = CustomUser::find($request->user_ref_id);

            if ($referrer) {
                $level = 1;
                $parentReferrer = $referrer;
                while ($parentReferrer->referredBy) {
                    $level++;
                    $parentReferrer = $parentReferrer->referredBy;
                }

                Referral::create([
                    'user_id' => $referrer->id,
                    'referred_id' => $newUser->id,
                    'level' => $level,
                ]);
            }
        }


        if ($newUser) {
            $sms1 = Helper::sendSms(
                '+88' . $newUser->customer_contact_number,
                "ITR Health Care Ltd.\nWelcome To The ITR Group Family Member\n " . $newUser->customer_name
            );


            $sms2 = Helper::sendSms(
                '+88' . $newUser->customer_contact_number,
                "Dear Sir,\nYou have successfully registered as one of our members.\nPlease keep this information safe as it contains your username and password."
            );

            $sms3 = Helper::sendSms(
                '+88' . $newUser->customer_contact_number,
                "Your Membership Info:\nUsername: " . $newUser->user_id . "\nPassword: " . $request->user_password
            );
        }


        return redirect()->route('user.list');
    }


    public function addUserUnderParent($parentId, $newUserData)
    {
        // Find the parent user
        $parentUser = User::find($parentId);

        if (!$parentUser) {
            return response()->json(['error' => 'Parent user not found'], 404);
        }

        // Check for available placement
        if (!$parentUser->placement_a) {
            // Create new user
            $newUser = User::create($newUserData + ['parent_id' => $parentId]);

            // Assign new user to placement_a
            $parentUser->placement_a = $newUser->id;
            $parentUser->save();
        } elseif (!$parentUser->placement_b) {
            // Create new user
            $newUser = User::create($newUserData + ['parent_id' => $parentId]);

            // Assign new user to placement_b
            $parentUser->placement_b = $newUser->id;
            $parentUser->save();
        } else {
            return response()->json(['error' => 'No available placement under this parent'], 400);
        }

        return response()->json(['success' => 'User added successfully', 'user' => $newUser], 201);
    }



    function user_list()
    {
        $customers = CustomUser::all();
        return view('admin.pages.custom_user.list', [
            'customers' => $customers,
        ]);
    }
    function custom_user_list()
    {
        $customers = CustomUser::all();
        return view('custom_user.custom_user_list', [
            'customers' => $customers,
        ]);
    }
    function customer_user_login(Request $request)
    {
        $user = CustomUser::where('user_id', $request->user_id)->first();

        if ($user) {
            if (Auth::guard('customUser')->attempt(['user_id' => $request->user_id, 'password' => $request->password])) {
                return redirect()->route('dashboard');
            } else {
                return back()->with('errors', 'Password Does Not Exist');
            }
        } else {
            return back()->with('errors', 'User Id Does Not Exist');
        }
    }

    function customer_user_login2(Request $request)
    {
        $user = CustomUser::where('user_id', $request->user_id)->first();

        if ($user) {
            if (Hash::check($request->password, $user->password)) {
                Auth::guard('customUser')->login($user);
                return redirect()->route('dashboard');
            } else {
                return back()->with('errors', 'Password Does Not Exist');
            }
        } else {
            return back()->with('errors', 'User Id Does Not Exist');
        }
    }


    function user_logout()
    {
        Auth::guard('customUser')->logout();
        return redirect()->route('welcome');
    }
    function admin_user_dashboard()
    {
        return view('dashboard.admin');
    }
    function admin_user_login_post(Request $request)
    {
        if (User::where('admin_id', $request->admin_id)->exists()) {
            if (auth()->attempt(['admin_id' => $request->admin_id, 'password' => $request->password])) {
                return redirect()->route('admin.user.dashboard');
            } else {
                return back()->with('exists', 'Password Does Not Exists');
            }
        } else {
            return back()->with('exists', 'User Id Does Not Exists');
        }
    }
    function stockiest_user_list()
    {
        $stockiests = Stockiest::all();
        return view('custom_stockiest.stockiest_list_for_user', [
            'stockists' => $stockiests,
        ]);
    }
    function stockiest_user_add()
    {
        return view('custom_stockiest.stockiest_add_for_user');
    }
    public function stockiest_user_add_post(Request $request)
    {

        // $ids=Str::lower(str_replace(' ','-','STOCKIST-ISP-000')).random_int(1,100);
        //$id = IdGenerator::generate(['table' => 'stockiests', 'length' => 10, 'prefix' =>'CUST-']);
        $count = Stockiest::count() + 1;
        $id = 'stockiest-isp-000' . $count;


        Stockiest::insert([
            'stockiest_name' => $request->stockiest_name,
            'stockiest_contact_person_name' => $request->stockiest_contact_person_name,
            'contact_number' => $request->contact_number,
            'stockiest_email_id' => $request->stockiest_email,
            'stockiest_address' => $request->stockiest_address,
            'depo_id' => $request->depo_id,
            'stockiest_arya' => $request->stockiest_arya,
            'stockiest_user_id' => $id,
            'password' => Hash::make($request->stockiest_password),
            'stockiest_ref_id' => $request->stockiest_ref,



        ]);
        return redirect()->route('stockiest.user.list');
    }
    function stockiest_depo_for_list()
    {
        $stockiests = Stockiest::all();
        return view('custom_stockiest.stockiest_for_depo_list', [
            'stockists' => $stockiests,
        ]);
    }
    function stockiest_depo_for_add()
    {
        return view('custom_stockiest.stockiest_for_depo_add');
    }
    public function stockiest_depo_for_add_post(Request $request)
    {

        // $ids=Str::lower(str_replace(' ','-','STOCKIST-ISP-000')).random_int(1,100);
        //$id = IdGenerator::generate(['table' => 'stockiests', 'length' => 10, 'prefix' =>'CUST-']);
        $count = Stockiest::count() + 1;
        $id = 'stockiest-isp-000' . $count;


        Stockiest::insert([
            'stockiest_name' => $request->stockiest_name,
            'stockiest_contact_person_name' => $request->stockiest_contact_person_name,
            'contact_number' => $request->contact_number,
            'stockiest_email_id' => $request->stockiest_email,
            'stockiest_address' => $request->stockiest_address,
            'depo_id' => $request->depo_id,
            'stockiest_arya' => $request->stockiest_arya,
            'stockiest_user_id' => $id,
            'password' => Hash::make($request->stockiest_password),
            'stockiest_ref_id' => $request->stockiest_ref,



        ]);
        return redirect()->route('stockiest.depo.for.list');
    }
    function stockiest_stockiest_for_list()
    {
        $stockists = Stockiest::all();
        return view('custom_stockiest.stockiest_for_stockiest_list', [
            'stockists' => $stockists,
        ]);
    }
    function stockiest_stockiest_for_add()
    {
        return view('custom_stockiest.stockiest_stockiest_add');
    }
    public function stockiest_stockiest_for_add_post(Request $request)
    {

        // $ids=Str::lower(str_replace(' ','-','STOCKIST-ISP-000')).random_int(1,100);
        //$id = IdGenerator::generate(['table' => 'stockiests', 'length' => 10, 'prefix' =>'CUST-']);
        $count = Stockiest::count() + 1;
        $id = 'stockiest-isp-000' . $count;


        Stockiest::insert([
            'stockiest_name' => $request->stockiest_name,
            'stockiest_contact_person_name' => $request->stockiest_contact_person_name,
            'contact_number' => $request->contact_number,
            'stockiest_email_id' => $request->stockiest_email,
            'stockiest_address' => $request->stockiest_address,
            'depo_id' => $request->depo_id,
            'stockiest_arya' => $request->stockiest_arya,
            'stockiest_user_id' => $id,
            'password' => Hash::make($request->stockiest_password),
            'stockiest_ref_id' => $request->stockiest_ref,



        ]);
        return redirect()->route('stockiest.stockiest.for.list');
    }

    public function userChild($id)
    {
        $customUser = CustomUser::where('user_ref_id', $id)->orderBy('placement_side', 'desc')->get();
        // dd($id, $customUser);

        return response()->json([
            'success' => 'true',
            'data' => $customUser,
        ]);
    }

    public function checkPlacement($id)
    {
        $parent = CustomUser::find($id);

        if (!$parent) {
            return response()->json(['error' => 'Parent user not found'], 404);
        }

        $availableSides = [];

        // Check availability of placement sides
        if (!$parent->placement_a) {
            $availableSides[] = 'A';
        }

        if (!$parent->placement_b) {
            $availableSides[] = 'B';
        }

        return response()->json(['available_sides' => $availableSides]);
    }

    public function equal_bonus_list()
    {
        $equalBonus = EqualBonus::with('users')->orderBy('c_user_id', 'asc')->get();
        // dd($equalBonus);
        return view('custom_user.equalbonuslist', [
            'equalBonus' => $equalBonus,
        ]);
        // return view('custom_stockiest.equal_bonus_list');
    }
    public function all_bonus_list()
    {

        $rp_redeemed = rp_redeemed_c_user::with('users', 'beneficiary')->get();

        return view('custom_user.bonuslist', [
            'rp_redeemed' => $rp_redeemed,
        ]);
    }


    public function captainship_bonus_list()
    {
        $cb_list = CbDistributeList::latest()->get();

        return view('admin.pages.captainship_bonus.list', [
            'cb_list' => $cb_list,
        ]);
    }

    public function captainship_bonus_distribute(Request $request)
    {
        $cb_list = CbDistributeList::where('date', $request->month . '-' . $request->year)->first();

        if ($cb_list) {
            return back()->with('error', 'Already Distributed');
        } else {
            $users = CustomUser::all();
            foreach ($users as $user) {
                Helper::captain_ship_points($user->id, $request->month, $request->year);
            }

            CbDistributeList::create([
                'month' => $request->month,
                'year' => $request->year,
                'date' => $request->month . '-' . $request->year,
            ]);

            $users = CustomUser::all();

            foreach ($users as $user) {
                $totalSum = 0;

                // Get the referrals for the user
                $referrals = $user->referrals;

                foreach ($referrals as $referral) {
                    // Find the captainship bonuses for each referral
                    $bonuses = CaptainshipBonus::where('user_id', $referral->user_id)
                        ->where('month', $request->month . '-' . $request->year)
                        ->get();

                    // Sum the 'total' column from the bonuses
                    $totalSum += $bonuses->sum('total');
                }

                // Calculate 5% of the total bonus
                $captainship_bonus_increment = $totalSum * 0.05;
                // Update the captainship_bonus column for the user
                TotalBonusPoint::where('user_id', $user->id)->increment('captainship_bonus', $captainship_bonus_increment);
            }

            return back()->with('status', 'Distributed');
        }


    }

    public function guardianship_bonus_list()
    {
        $gs_list = GsDistributeList::latest()->get();

        return view('admin.pages.guardianship_bonus.list', [
            'gs_list' => $gs_list,
        ]);
    }

    public function guardianship_bonus_distribute(Request $request)
    {
        $cb_list = GsDistributeList::where('date', $request->month . '-' . $request->year)->first();

        if ($cb_list) {
            return back()->with('error', 'Already Distributed');
        } else {
            $users = CustomUser::all();
            foreach ($users as $user) {
                if ($user->referrer_id) {
                    Helper::guardian_ship_points($user->referrer_id, $request->month, $request->year, $user->id);
                }
            }

            GsDistributeList::create([
                'month' => $request->month,
                'year' => $request->year,
                'date' => $request->month . '-' . $request->year,
            ]);

            return back()->with('status', 'Distributed');
        }
    }

}
