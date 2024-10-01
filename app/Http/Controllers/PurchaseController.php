<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PurchaseController extends Controller
{
    public function purchase_bonus(){
        return view('purchase_bonus.purchase_list');
    }
}
