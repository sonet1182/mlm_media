<?php

namespace App\Http\Controllers\Stockiest;

use App\Http\Controllers\Controller;
use App\Models\BalanceSheet;
use App\Models\PaymentGateway;
use App\Models\Stockiest;
use App\Models\WithdrawRequest;
use Auth;
use Illuminate\Http\Request;

class OwnWithdrawController extends Controller
{

    public function index()
    {
        $balance = BalanceSheet::where('user_id', auth()->guard('stockiest')->user()->id)->where('user_type', 'stockiest')->first()->amount ?? 0;
        $pending_req = WithdrawRequest::where('user_id', auth()->guard('stockiest')->user()->id)->where('status', 'pending')->where('user_type', 'stockiest')->sum('amount') ?? 0;
        $available_balance = $balance - $pending_req;
        $stockiest = Stockiest::all();
        $gateway = PaymentGateway::where('c_user_id', auth()->guard('stockiest')->user()->id)->where('user_type', 'stockiest')->first();

        if (!isset($gateway)) {
            $gateway = new PaymentGateway();
            $gateway->c_user_id = auth()->guard('stockiest')->user()->id;
            $gateway->user_type = 'stockiest';
            $gateway->save();
        }

        return view('stockiest.pages.own_withdraw.index', compact('balance', 'available_balance', 'stockiest', 'gateway'));
    }

    public function store(Request $request)
    {
        // Retrieve the authenticated user
        $user = Auth::guard('stockiest')->user();

        // Fetch the user's current balance
        $balance = BalanceSheet::where('user_id', $user->id)->first()->amount ?? 0;
        $pending_req = WithdrawRequest::where('user_id', $user->id)->where('status', 'pending')->sum('amount') ?? 0;
        $available_balance = $balance - $pending_req;

        // Base validation rules
        $rules = [
            'amount' => ['required', 'numeric', 'min:200', 'max:' . $available_balance],
            'gateway' => ['required', 'string', 'in:bkash,nagad,rocket,dbbl'],
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
        $payableAmount = $validatedData['amount'] - ($validatedData['amount'] * 0.03);
        $withdrawRequest->payable_amount = $payableAmount;  // 5% reduced amount

        // Calculate the 5% service charge
        $serviceCharge = $validatedData['amount'] * 0.03;
        $withdrawRequest->service_charge = $serviceCharge;  // 5% of the amount

        $withdrawRequest->gateway = $validatedData['gateway'];
        $withdrawRequest->request_to = 'admin';
        $withdrawRequest->user_type = 'stockiest';
        $withdrawRequest->account_number = $validatedData['account_no'];

        if ($validatedData['gateway'] === 'dbbl') {
            $withdrawRequest->account_name = $validatedData['account_name'];
            $withdrawRequest->bank_name = $validatedData['bank_name'];
            $withdrawRequest->bank_branch = $validatedData['bank_branch'];
            $withdrawRequest->routing_number = $validatedData['routing_no'];
            $withdrawRequest->swift_code = $validatedData['swift_code'];
        }

        $withdrawRequest->status = 'pending';
        $withdrawRequest->save();

        // Redirect back with success message
        return redirect()->back()->with('success', 'Withdrawal request submitted successfully.');
    }


    public function list(Request $request)
    {
        $type = $request->query('type');

        $withdraws = WithdrawRequest::where('user_id', auth()->guard('stockiest')->user()->id)->where('user_type', 'stockiest');

        if ($type === 'pending') {
            $withdraws->where('status', 'pending');
        } elseif ($type === 'paid') {
            $withdraws->where('status', 'paid');
        }

        $withdraws = $withdraws->latest()->get();

        return view('stockiest.pages.withdraw.index', compact('withdraws', 'type'));
    }

    function paymentGateway()
    {
        $user = Auth::guard('stockiest')->user();
        $paymentGateway = PaymentGateway::where('c_user_id', $user->id)->where('user_type', 'stockiest')->first();

        if (!isset($paymentGateway)) {
            $paymentGateway = new PaymentGateway();
            $paymentGateway->c_user_id = $user->id;
            $paymentGateway->user_type = 'stockiest';
            $paymentGateway->save();
        }

        return view('stockiest.pages.settings.wallet', compact('paymentGateway', 'user'));
    }

    public function paymentGateway_update(Request $request)
    {
        // Validate request data
        $request->validate([
            'bkash' => 'nullable|string|max:255',
            'nagad' => 'nullable|string|max:255',
            'rocket' => 'nullable|string|max:255',
            'b_name' => 'nullable|string|max:255',
            'b_branch' => 'nullable|string|max:255',
            'b_route' => 'nullable|string|max:255',
            'b_swift' => 'nullable|string|max:255',
            'b_account_name' => 'nullable|string|max:255',
            'b_account' => 'nullable|string|max:255',
        ]);

        try {
            $paymentGateway = PaymentGateway::updateOrCreate(
                [
                    'c_user_id' => Auth::guard('stockiest')->user()->id,
                    'user_type' => 'stockiest',
                ],
                [
                    'bkash' => $request->bkash,
                    'nagad' => $request->nagad,
                    'rocket' => $request->rocket,
                    'b_name' => $request->b_name,
                    'b_branch' => $request->b_branch,
                    'b_route' => $request->b_route,
                    'b_swift' => $request->b_swift,
                    'b_account_name' => $request->b_account_name,
                    'b_account' => $request->b_account
                ]
            );

            return back()->with('success', 'Payment Info Updated');
        } catch (\Exception $e) {
            return back()->withErrors(['error' => 'Failed to update payment gateway. Please try again.']);
        }
    }

}
