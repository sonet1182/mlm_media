<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CustomLoginController extends Controller
{
    public function login(Request $request)
    {

        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
            'user_type'=>'required'
        ]);


        if (auth()->attempt($request->only('email', 'password','user_type'))) {

            return redirect()->route('dashboard');
        }


        return redirect()->back()->withInput()->withErrors([
            'email' => 'Invalid credentials',
        ]);
    }
}
