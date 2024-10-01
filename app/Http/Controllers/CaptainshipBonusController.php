<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CaptainshipBonusController extends Controller
{
    function captainship_bonus_list(){



        return view('captain_ship_bonus.captain_ship_bonus');
    }
}
