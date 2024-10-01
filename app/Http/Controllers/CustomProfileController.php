<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CustomProfileController extends Controller
{
    function custom_photo(Request $request){
        $image=$request->image;
        $extension=$image->extension();
        $imageName = time().'.'.$extension;
        $image->move(public_path('upload/profile'), $imageName);
       User::find(Auth::user()->id)->update([
            'photo'=>$imageName,
        ]);
        return back();







    }
}
