<?php

namespace App\Http\Controllers;

use App\Models\rp_redeemed_c_user;
use App\Models\Stockiest;
use App\Helpers\Helper;
use Carbon\Carbon;
use Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class StockiestUserProfileController extends Controller
{
    function profile()
    {
        $data = Stockiest::find(Auth::guard('stockiest')->user()->id);
        return view('StockiestUserProfile.profile', compact('data'));
    }


    public function profile_update(Request $request)
    {
        $request->validate([
            'name' => 'nullable|string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        // Get the authenticated stockiest user
        $stockiest = Stockiest::find(Auth::guard('stockiest')->user()->id);

        // Check if an image was uploaded
        if ($request->hasFile('image')) {
            $image = $request->image;
            $extension = $image->extension();
            $path = 'upload/profile/';
            $imageName = $path . time() . '.' . $extension;
            $image->move($path, $imageName);
        } else {
            // If no image was uploaded, keep the current image
            $imageName = $stockiest->image; // Use existing image if no new image is provided
        }

        // Update the stockist profile
        $stockiest->update([
            'stockiest_address' => $request->address,
            'blood_group' => $request->blood_group,
            'image' => $imageName, // Update the image only if a new one is provided
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

        $stockiest = Stockiest::find(Auth::guard('stockiest')->user()->id);

        // Check if the old password matches the current password
        if (!Hash::check($request->old_password, $stockiest->password)) {
            return back()->with('error', 'The provided password does not match your current password.');
        }

        // Update the password
        $stockiest->update([
            'password' => Hash::make($request->password),
        ]);

        // Optionally, log the user out after the password change
        Auth::guard('stockiest')->logout();

        return redirect()->route('welcome')->with('success', 'Password updated successfully. Please log in with your new password.');
    }


    function redeem()
    {
        return view('stockiest.pages.redeem');
    }

    public function redeem_list(Request $request)
    {
        $query = rp_redeemed_c_user::with('users', 'transactions')->where('created_by', Auth::guard('stockiest')->user()->id);

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
                'html' => view('stockiest.pages.redeem.partials.redeemListTable', compact('redeemList'))->render(),
                'total_price_value' => $total_price_value,
                'total_point' => $total_point,
            ]);
        }

        // Otherwise, return the full view
        return view('stockiest.pages.redeem.redeemList', compact('redeemList', 'total_price_value', 'total_point'));
    }


    function transaction_action(Request $request)
    {
        $transactions = DB::table('transactions')->where('invoice_no', $request->invoice_no)->where('total_before_tax', $request->total_before_tax)->where('rp_earned', $request->rp_redeemed_amount)->first();

        if ($transactions) {
            if ($transactions->transaction_type == 0) {
                $data = Helper::process($transactions, $request->customer_id);

                if ($data == 'active') {
                    return back()->route("IpActiveSuccess", $request->customer_id, $transactions->id)->with('transactions', 'This transaction (active) setup successfully');
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
}
