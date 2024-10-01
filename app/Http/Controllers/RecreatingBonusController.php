<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RecreatingBonusController extends Controller
{
    function re_create_bonus_list(){
        return view('re-creating-bonus.re_creating_bonus');
    }
}
