<?php

namespace App\Http\Controllers;

use App\Mail\OtpMail;
use App\Models\CustomUser;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Mail;

class CustomAuthinticationController extends Controller
{
    public function user()
    {
        return view('custom_user.pages.auth.user_login');
    }
    public function user_post(Request $request)
    {
        $request->validate([
            'name' => ['required'],
            'email' => ['required'],
            'password' => ['required'],
            'user_type' => ['required'],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'user_type' => $request->user_type,

        ]);
        return redirect()->route('login');

    }
    public function admin()
    {
        return view('authentication.admin');
    }
    public function admin_post(Request $request)
    {
        $request->validate([
            'name' => ['required'],
            'email' => ['required'],
            'password' => ['required'],
            'user_type' => ['required'],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'user_type' => $request->user_type,

        ]);
        return redirect()->route('login');

    }
    public function depo()
    {
        return view('authentication.depo');
    }
    public function depo_post(Request $request)
    {
        $request->validate([
            'name' => ['required'],
            'email' => ['required'],
            'password' => ['required'],
            'user_type' => ['required'],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'user_type' => $request->user_type,

        ]);
        return redirect()->route('login');

    }
    public function stockiest()
    {
        return view('authentication.stockiest');
    }
    public function stockiest_post(Request $request)
    {
        $request->validate([
            'name' => ['required'],
            'email' => ['required'],
            'password' => ['required'],
            'user_type' => ['required'],
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'user_type' => $request->user_type,

        ]);
        return redirect()->route('login');

    }



    // Forget Password Recover
    public function showForgotPasswordForm()
    {
        return view('custom_user.pages.auth.forget_password');
    }

    public function sendOtp2(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email|max:255|exists:custom_users,customer_email',
        ]);

        $email = $request->input('email'); // Store the email in a variable
        $otp = rand(1000, 9999); // Generate a 4-digit OTP

        // Save the OTP in the session
        session(['otp' => $otp, 'email' => $email]);

        try {
            // Attempt to send the OTP via email
            Mail::to($email)->send(new OtpMail($otp));

            // If successful, return the view with a success status
            return view('custom_user.pages.auth.reset_password', compact('email'))
                ->with('status', 'OTP has been sent to your email!');
        } catch (\Exception $e) {
            session()->forget(['otp', 'email']);


            return redirect()->back()->with('error', 'Failed to send OTP. Please try again.');
        }
    }


    public function resetPasswordForm()
    {
        return view('custom_user.pages.auth.reset_password');
    }


    public function resetPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email|max:255|exists:custom_users,customer_email',
            'otp' => 'required|string',
            'password' => 'required|string|min:6|confirmed',
        ]);

        // Verify OTP
        if ($request->input('otp') != session('otp') || $request->input('email') != session('email')) {
            return redirect()->back()->withErrors(['otp' => 'Invalid OTP or email.']);
        }

        // Reset password
        $user = CustomUser::where('customer_email', $request->input('email'))->first();
        $user->password = Hash::make($request->input('password'));
        $user->save();

        // Clear the session
        session()->forget(['otp', 'email']);

        return redirect()->route('welcome')->with('status', 'Password has been reset successfully.');
    }



}
