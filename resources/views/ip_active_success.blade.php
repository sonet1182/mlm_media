@extends('dashboard.admin_master')
@section('admin')
    <!-- Small boxes (Stat box) -->


    @if ($user->is_IpActive == 1)
    <div class="card col-sm-6 offset-3 bg-info">

        <div class="card-body">
            <h2 class="card-title">Activation Successfull</h2>
            <hr>

            <br>

            <p class="card-text">{{$user->customer_name}}</p>
            <p>Invoice ID: {{$rp_redeemed->transactions->invoice_no}}</p>
            <p>Redeem Point: {{$rp_redeemed->transactions->rp_earned}}</p>

        </div>
      </div>

    @endif




    <!-- ./col -->
@endsection
