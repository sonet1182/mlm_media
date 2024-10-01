<?php

namespace App\Http\Controllers;

use App\Models\Depo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DepoUserProfile extends Controller
{
    function profile(){
        return view('DepoUserProfile.profile');
    }
    function profile_post(Request $request){
        $image=$request->image;
        $extension=$image->extension();
        $imageName = time().'.'.$extension;
        $image->move(public_path('upload/profile'), $imageName);
       Depo::find(Auth::guard('depo')->user()->id)->update([

            'photo'=>$imageName,
        ]);
        return back()->with('success','Depo User  Profile Updated');

    }
    function password_update(Request $request){
        $password=Depo::find(Auth::guard('depo')->id());




        if(password_verify($request->current_password,$password->password)){
            Depo::find(Auth::guard('depo')->user()->id)->update([
                'password'=>bcrypt($request->password),

            ]);
            return back()->with('success','depo User  Password Updated');

        }
        else{
            return back()->with('success','depo User  Password Does Not Exists');
        }
    }

}
