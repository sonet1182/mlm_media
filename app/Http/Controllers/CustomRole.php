<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CustomRole extends Controller
{
   public function custom_role(){
    return view('custom_role.role');

    }
}
