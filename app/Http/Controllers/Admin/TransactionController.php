<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use Illuminate\Http\Request;

class TransactionController extends Controller
{
    function transaction_list(){
        $transactions = Transaction::all();
        return view('admin.pages.transactions.list',compact('transactions'));
    }
}
