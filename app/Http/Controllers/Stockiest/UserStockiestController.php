<?php

namespace App\Http\Controllers\Stockiest;

use App\Http\Controllers\Controller;
use App\Models\CustomUser;
use App\Models\Referral;
use Auth;
use Carbon\Carbon;
use Hash;
use Illuminate\Support\Str;
use Illuminate\Http\Request;

class UserStockiestController extends Controller
{
    function stockiest_customer_list(Request $request)
    {
        $type = $request->query('type');

        $customers = CustomUser::where('stockiest_id', Auth::guard('stockiest')->user()->id);

        if ($type === 'active') {
            $customers->where('is_IpActive', 1);
        }

        $customers = $customers->latest()->get();


        return view('stockiest.pages.custom_user.list', [
            'customers' => $customers,
        ]);
    }

    function customer_add()
    {
        $count = CustomUser::count() + 1;
        $user_id = 'ITRHCL-000' . $count;
        return view('stockiest.pages.custom_user.create', compact('user_id'));
    }

    public function user_user_list_user(Request $request)
    {
        $user_ref_id = $ids = Str::lower(str_replace(' ', '-', 'STOCKIST-ISP-000')) . random_int(1, 100) . '.' . uniqid();
        $count = CustomUser::count() + 1;
        $id = 'ITRHCL-000' . $count;

        // Validate the request data
        $request->validate([
            'customer_email' => "required|email|unique:custom_users,customer_email",
            'customer_contact_number' => "required|unique:custom_users,customer_contact_number",
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
            'stockiest_id' => Auth::guard('stockiest')->user()->id,
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

        return redirect()->route('stockiest.customer.list')->with('status', 'User Added Successfully!');;
    }


    public function tree($id)
    {
        return view('stockiest.pages.custom_user.tree', compact('id'));
    }

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

    public function reset_password($id)
    {
        $user = CustomUser::findOrFail($id);
        $user->password = Hash::make($user->customer_contact_number);
        $user->save();

        return back()->with('status', $user->customer_name . ' - Password has been reset successfully.');
    }

    function field_force()
    {
        $customers = CustomUser::where('stockiest_id', Auth::guard('stockiest')->user()->id);
        $customers = $customers->get();

        return view('stockiest.pages.field_force.all_list', [
            'customers' => $customers,
        ]);
    }

    public function showChildGenerations_user($id)
    {
        $user = CustomUser::findOrFail($id);
        $customers = CustomUser::where('referrer_id', $id)->get();

        if (!$customers) {
            return redirect()->back()->with('error', 'User not found.');
        }

        return view('stockiest.pages.field_force.list', ['customers' => $customers, 'user' => $user]);
    }

    function direct_list()
    {
        $customers = CustomUser::where('stockiest_id', Auth::guard('stockiest')->user()->id);
        $customers = $customers->get();

        return view('stockiest.pages.direct_list.all_list', [
            'customers' => $customers,
        ]);
    }

    public function showParentalGenerations_user($id)
    {
        $user = CustomUser::find($id);
        if (!$user) {
            return redirect()->back()->with('error', 'User not found.');
        }

        $generations = $user->getAncestors();

        return view('stockiest.pages.direct_list.list', ['generations' => $generations, 'user' => $user]);
    }
}
