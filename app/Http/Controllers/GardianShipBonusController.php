<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class GardianShipBonusController extends Controller
{
    function gardianship_bonus_list(){
        return view('GardianShip_bonus.gardianship_bonus');
    }
}
