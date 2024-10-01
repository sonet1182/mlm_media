<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RankRewardBonusController extends Controller
{
    function rankreward_list(){
        return view('rank_reward_bonus.rank_reward_bonus');
    }
}
