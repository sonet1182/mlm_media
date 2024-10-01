<?php

namespace App\Http\Controllers;

use App\Models\BalanceSheet;
use App\Models\PaymentGateway;
use App\Models\Stockiest;
use App\Models\WithdrawRequest;
use Auth;
use Illuminate\Http\Request;
use App\Helpers\Helper;

class WithdrawController extends Controller
{
    public function index()
    {
        $balance = BalanceSheet::where('user_id', auth()->guard('customUser')->user()->id)->where('user_type', 'user')->first()->amount ?? 0;
        $pending_req = WithdrawRequest::where('user_id', auth()->guard('customUser')->user()->id)->where('status', 'pending')->where('user_type', 'user')->sum('amount') ?? 0;
        $available_balance = $balance - $pending_req;
        $stockiest = Stockiest::all();
        $gateway = PaymentGateway::where('c_user_id', auth()->guard('customUser')->user()->id)->first();

        if (!isset($gateway)) {
            $gateway = new PaymentGateway();
            $gateway->c_user_id = auth()->guard('customUser')->user()->id;
            $gateway->user_type = 'user';
            $gateway->save();
        }

        return view('dashboard.withdrawal', compact('balance', 'available_balance', 'stockiest', 'gateway'));
    }

    public function store(Request $request)
    {
        // Retrieve the authenticated user
        $user = Auth::guard('customUser')->user();

        // Fetch the user's current balance
        $balance = BalanceSheet::where('user_id', $user->id)->first()->amount ?? 0;
        $pending_req = WithdrawRequest::where('user_id', $user->id)->where('status', 'pending')->sum('amount') ?? 0;
        $available_balance = $balance - $pending_req;

        // Base validation rules
        $rules = [
            'amount' => ['required', 'numeric', 'min:200', 'max:' . $available_balance],
            'gateway' => ['required', 'string', 'in:bkash,nagad,rocket,dbbl'],
            'request_to' => ['required', 'string', 'in:admin,stockiest'],
            'account_no' => ['required', 'string'],
        ];

        // Additional rules if the selected gateway is DBBL
        if ($request->gateway === 'dbbl') {
            $rules = array_merge($rules, [
                'account_name' => ['required', 'string'],
                'bank_name' => ['required', 'string'],
                'bank_branch' => ['required', 'string'],
                'routing_no' => ['required', 'string'],
                'swift_code' => ['required', 'string'],
            ]);
        }

        if ($request->request_to === 'stockiest') {
            $rules = array_merge($rules, [
                'stockiest_id' => ['required'],
            ]);
        }

        // Custom error messages
        $messages = [
            'amount.min' => 'The withdrawal amount should be minimum 200 BDT.',
            'amount.max' => 'The withdrawal amount cannot exceed your current balance of ' . number_format($available_balance, 2) . '.',
            'gateway.in' => 'The selected payment gateway is invalid.',
            'request_to.in' => 'The selected request recipient is invalid.',
            'stockiest_id.required' => 'Stockiest Selection is required if you request to stockiest',
        ];

        // Validate the request data
        $validatedData = $request->validate($rules, $messages);

        // Create a new withdrawal request
        $withdrawRequest = new WithdrawRequest();
        $withdrawRequest->user_id = $user->id;

        $withdrawRequest->amount = $validatedData['amount'];

        // Calculate the 5% reduction
        $payableAmount = $validatedData['amount'] - ($validatedData['amount'] * 0.05);
        $withdrawRequest->payable_amount = $payableAmount;  // 5% reduced amount

        // Calculate the 5% service charge
        $serviceCharge = $validatedData['amount'] * 0.05;
        $withdrawRequest->service_charge = $serviceCharge;  // 5% of the amount

        $withdrawRequest->gateway = $validatedData['gateway'];
        $withdrawRequest->request_to = $validatedData['request_to'];
        $withdrawRequest->account_number = $validatedData['account_no'];

        if ($validatedData['gateway'] === 'dbbl') {
            $withdrawRequest->account_name = $validatedData['account_name'];
            $withdrawRequest->bank_name = $validatedData['bank_name'];
            $withdrawRequest->bank_branch = $validatedData['bank_branch'];
            $withdrawRequest->routing_number = $validatedData['routing_no'];
            $withdrawRequest->swift_code = $validatedData['swift_code'];
        }

        if ($validatedData['request_to'] == 'stockiest') {
            $withdrawRequest->stockiest_id = $validatedData['stockiest_id'];
        }

        $withdrawRequest->status = 'pending';
        $withdrawRequest->save();


        if($withdrawRequest){
            $sms1 = Helper::sendSms(
                '+88' . $user->customer_contact_number,
                "Dear " . $user->customer_name . "\nThe Request of your ". $withdrawRequest->amount ." TK bKash Withdrawal has been successfully submitted, we will process it as soon as possible. \nThanks, \nITR Group",
            );
        }

        // Redirect back with success message
        return redirect()->back()->with('success', 'Withdrawal request submitted successfully.');
    }

    public function list()
    {
        $withdraws = WithdrawRequest::where('user_id', auth()->guard('customUser')->user()->id)->where('user_type', 'user')->latest()->get();
        return view('custom_user.pages.withdraw.list', compact('withdraws'));
    }
}
