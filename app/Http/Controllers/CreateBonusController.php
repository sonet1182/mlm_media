<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CreateBonusController extends Controller
{
    function create_bonus_list(){
        return view('create_bonus.create_bonus_list');
    }
}
