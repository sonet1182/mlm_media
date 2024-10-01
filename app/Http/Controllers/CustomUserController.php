<?php

namespace App\Http\Controllers;

use App\Models\BalanceSheet;
use App\Models\CaptainshipBonus;
use App\Models\CustomUser;
use App\Models\EqualBonus;
use App\Models\GardianshipBonus;
use App\Models\PaymentGateway;
use App\Models\Redeem_Beneficiary;
use App\Models\rp_redeemed_c_user;
use App\Models\TotalBonusPoint;
use App\Models\Transaction;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Helpers\Helper;

class CustomUserController extends Controller
{

    function profile()
    {
        $data = CustomUser::find(Auth::guard('customUser')->user()->id);
        return view('customUserProfile.profile', compact('data'));
    }


    public function profile_update(Request $request)
    {
        $request->validate([
            'name' => 'nullable|string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        // Get the authenticated stockiest user
        $stockiest = CustomUser::find(Auth::guard('customUser')->user()->id);

        // Check if an image was uploaded
        if ($request->hasFile('image')) {
            $image = $request->image;
            $extension = $image->extension();
            $path = 'upload/profile/';
            $imageName = $path . time() . '.' . $extension;
            $image->move($path, $imageName);
        } else {
            // If no image was uploaded, keep the current image
            $imageName = $stockiest->photo; // Use existing image if no new image is provided
        }

        // Update the stockist profile
        $stockiest->update([
            'customer_address' => $request->address,
            'blood_group' => $request->blood_group,
            'photo' => $imageName, // Update the image only if a new one is provided
        ]);

        return back()->with('success', 'Profile Updated');
    }



    public function password_update(Request $request)
    {
        // Validate the form data
        $request->validate([
            'old_password' => 'required',
            'password' => 'required|min:6|confirmed',
        ]);

        $stockiest = CustomUser::find(Auth::guard('customUser')->user()->id);

        // Check if the old password matches the current password
        if (!Hash::check($request->old_password, $stockiest->password)) {
            return back()->with('error', 'The provided password does not match your current password.');
        }

        // Update the password
        $stockiest->update([
            'password' => Hash::make($request->password),
        ]);

        // Optionally, log the user out after the password change
        Auth::guard('customUser')->logout();

        return redirect()->route('welcome')->with('success', 'Password updated successfully. Please log in with your new password.');
    }


    function paymentGateway()
    {
        $user = Auth::guard('customUser')->user();
        $paymentGateway = PaymentGateway::where('c_user_id', $user->id)->where('user_type', 'user')->first();
        if (!isset($paymentGateway)) {
            $paymentGateway = new PaymentGateway();
            $paymentGateway->c_user_id = $user->id;
            $paymentGateway->user_type = 'user';
            $paymentGateway->save();
        }
        return view('customUserProfile.paymentGateway', compact('paymentGateway', 'user'));
    }
    function profile_post(Request $request)
    {
        $image = $request->image;
        $extension = $image->extension();
        $imageName = time() . '.' . $extension;
        $image->move(public_path('upload/profile'), $imageName);
        CustomUser::find(Auth::guard('customUser')->user()->id)->update([
            'photo' => $imageName,
        ]);
        return back()->with('success', 'Customer User  Profile Updated');
    }

    public function paymentGateway_update(Request $request)
    {
        // Validate request data
        $request->validate([
            'bkash' => 'nullable|string|max:255',
            'nagad' => 'nullable|string|max:255',
            'rocket' => 'nullable|string|max:255',
            'b_name' => 'nullable|string|max:255',
            'b_branch' => 'nullable|string|max:255',
            'b_route' => 'nullable|string|max:255',
            'b_swift' => 'nullable|string|max:255',
            'b_account_name' => 'nullable|string|max:255',
            'b_account' => 'nullable|string|max:255',
        ]);

        try {
            // Create or update payment gateway information
            $paymentGateway = PaymentGateway::updateOrCreate(
                [
                    'c_user_id' => Auth::guard('customUser')->user()->id,
                    'user_type' => 'user',
                ],
                [
                    'bkash' => $request->bkash,
                    'nagad' => $request->nagad,
                    'rocket' => $request->rocket,
                    'b_name' => $request->b_name,
                    'b_branch' => $request->b_branch,
                    'b_route' => $request->b_route,
                    'b_swift' => $request->b_swift,
                    'b_account_name' => $request->b_account_name,
                    'b_account' => $request->b_account
                ]
            );

            return back()->with('success', 'Payment Gateway Updated');
        } catch (\Exception $e) {
            // Handle any errors
            return back()->withErrors(['error' => 'Failed to update payment gateway. Please try again.']);
        }
    }



    function logout()
    {
    }


    public function user_equal_bonus_list()
    {
        $user = Auth::guard('customUser')->user();
        $equalBonus = EqualBonus::where('user_id', $user->id)->get();

        return view('custom_user.userequalbonuslist', [
            'equalBonus' => $equalBonus,
        ]);
    }
    public function all_bonus_list()
    {
        // dd('hi');
        $user = Auth::guard('customUser')->user();
        $rp_redeemed = rp_redeemed_c_user::where('c_user_id', $user->id)->with('users', 'beneficiary')->get();

        return view('custom_user.userbonuslist', [
            'rp_redeemed' => $rp_redeemed,
        ]);
    }


    function captainship_bonus_list()
    {
        $user = Auth::guard('customUser')->user();
        $captainshipBonus = CaptainshipBonus::where('c_user_id', $user->id)->get();


        return view('captain_ship_bonus.captain_ship_bonus', compact('user', 'captainshipBonus'));
    }

    function gardianship_bonus_list()
    {
        $user = Auth::guard('customUser')->user();
        $gardianhipBonus = GardianshipBonus::where('c_user_id', $user->id)->get();

        return view('GardianShip_bonus.gardianship_bonus', compact('user', 'gardianhipBonus'));
    }

    // Child Generation referrals
    public function refer_info($userId)
    {
        $user = CustomUser::with('referrals.referredUser')->find($userId);
        if (!$user) {
            return redirect()->back()->with('error', 'User not found.');
        }

        $referrals = $this->getReferralsRecursive($user);
        return view('admin.referral_info', ['referrals' => $referrals, 'user' => $user]);
    }

    private function getReferralsRecursive($user, $maxGenerations = 7, $currentGeneration = 1)
    {
        if ($currentGeneration > $maxGenerations || !$user->referrals->count()) {
            return [];
        }

        $result = [];
        foreach ($user->referrals as $referral) {
            $result[] = [
                'user' => $referral->referredUser,
                'generation' => $currentGeneration,
                'children' => $this->getReferralsRecursive($referral->referredUser, $maxGenerations, $currentGeneration + 1)
            ];
        }
        return $result;
    }

    // Prental Generation referrals
    public function showParentalGenerations($userId)
    {
        $user = CustomUser::find($userId);
        if (!$user) {
            return redirect()->back()->with('error', 'User not found.');
        }

        $generations = $this->getParentalGenerations($user);
        return view('admin.parental_generations', ['generations' => $generations]);
    }

    private function getParentalGenerations($user, $maxGenerations = 7, $currentGeneration = 1)
    {
        $result = [];

        if ($currentGeneration < $maxGenerations && $user->referredBy) {
            $result = [
                'generation' => $currentGeneration,
                'user' => $user->referredBy,
                'parent' => $this->getParentalGenerations($user->referredBy, $maxGenerations, $currentGeneration + 1)
            ];
        }

        return $result;
    }

    public function showChildGenerrations_user()
    {
        return 'Working in progress...';

        $customers = CustomUser::where('referrer_id',Auth::guard('customUser')->user()->id)->get();

        if (!$customers) {
            return redirect()->back()->with('error', 'User not found.');
        }

        return view('custom_user.pages.sales_team.field_force_list', ['customers' => $customers]);
    }

    public function direct_list()
    {
        $customers = CustomUser::where('referrer_id',Auth::guard('customUser')->user()->id)->get();

        if (!$customers) {
            return redirect()->back()->with('error', 'User not found.');
        }

        return view('custom_user.pages.sales_team.direct_list', ['customers' => $customers]);
    }


    public function showParentalGenerations_user()
    {
        $user = CustomUser::find(Auth::guard('customUser')->user()->id);
        if (!$user) {
            return redirect()->back()->with('error', 'User not found.');
        }

        $generations = $user->getAncestors();

        // $generations = $this->getParentalGenerations($user);
        // return view('custom_user.parental_generations', ['generations' => $generations]);

        return view('custom_user.pages.sales_team.direct_list', ['generations' => $generations]);
    }



    public function purchase_bonus()
    {
        $user = Auth::guard('customUser')->user();
        $rp_redeemed = rp_redeemed_c_user::where('c_user_id', $user->id)->with('transactions', 'beneficiary')->get();
        return view('purchase_bonus.purchase_list', compact('user', 'rp_redeemed'));
    }

    function create_bonus_list()
    {
        $user = Auth::guard('customUser')->user();
        $rp_redeemed = rp_redeemed_c_user::where('c_user_id', $user->id)->with('transactions', 'beneficiary')->get();
        return view('create_bonus.create_bonus_list', compact('user', 'rp_redeemed'));
    }

    function re_create_bonus_list()
    {
        $user = Auth::guard('customUser')->user();
        $rp_redeemed = rp_redeemed_c_user::where('c_user_id', $user->id)->with('transactions', 'beneficiary')->get();
        return view('re-creating-bonus.re_creating_bonus', compact('user', 'rp_redeemed'));
    }

    function equal_bonus_list()
    {
        return view('equal_bonus.equal_bonus_list');
    }

    function rankreward_list()
    {
        return view('rank_reward_bonus.rank_reward_bonus');
    }

    function ipActiveSuccess($c_user_id, $transaction_id)
    {
        $user = CustomUser::where('id', $c_user_id)->first();
        $rp_redeemed = rp_redeemed_c_user::where('transaction_id', $transaction_id)->with('beneficiary', 'transactions')->first();
        return view('ip_active_success', compact('user', 'rp_redeemed'));
    }

    function purchase_list()
    {
        $user = Auth::guard('customUser')->user();
        $purchase = rp_redeemed_c_user::where('c_user_id', $user->id)->with('transactions')->latest()->get();
        return view('custom_user.pages.purchase.list', compact('purchase'));
    }

    function sale_list()
    {
        $user = Auth::guard('customUser')->user();
        $purchase = Helper::getAllPurchasesUnderNode($user->id);

        return view('custom_user.pages.sales.list', compact('purchase'));
    }

    function redeem_list($id)
    {
        $purchase = rp_redeemed_c_user::findOrFail($id);
        $redeems = Redeem_Beneficiary::where('rp_redeemed_id', $id)->with('custom_user', 'stockiest')->get();
        return view('custom_user.pages.redeem.list', compact('redeems', 'purchase'));
    }


    function bonus_list($type)
    {
        $user = Auth::guard('customUser')->user();

        $redeemed = Redeem_Beneficiary::where('rp_beneficiary_id', $user->id)->where('benifit_by', 'user');


        if ($type == 'purchase_bonus') {
            $bonus_type = 'Purchase Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'creating_bonus') {
            $bonus_type = 'Creating Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 're_creating_bonus') {
            $bonus_type = 'Re-creating Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', 'Refer Bonus')->latest()->get();
        }
        if ($type == 'stockiest_refer_bonus') {
            $bonus_type = 'Stockiest Refer Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'rank_reward_bonus') {
            $bonus_type = 'Rank Reward Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'after_death_allowance') {
            $bonus_type = 'After Death Allowance';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'company_profit_share') {
            $bonus_type = 'Company Profit Share';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'stockiest_refer_bonus') {
            $bonus_type = 'Stockiest Refer Bonus';
            $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
        }
        if ($type == 'equal_bonus') {
            $bonus_type = 'Equal Bonus';
            // $rp_redeemed = $redeemed->where('beneficiary_type', $bonus_type)->latest()->get();
            return $bonus_type . " - is working in progress!!";
        }

        return view('custom_user.pages.bonus.list', compact('bonus_type', 'rp_redeemed'));
    }
}
