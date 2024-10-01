@extends('layouts.admin')
@section('content')
<div class="col-lg-12">
    <div class="card">
        <div class="card-header"><h6><b>User Creating Bonus</b></h6></div>
        <div class="card-body">
            <div class="justify-between pv-wrapper d-flex align-items-center" style="position: relative;">
                <div class="total_pb" width='400px'><p><b>Total CB:</b></p></div>
                <div class="current_pb" width='400px' style="position: absolute;right:10%;"><p><b>Current CB:</b></p></div>
            </div>
            <table class="table table-bordered">
                <tr>
                    <th>Sl</th>
                    <th>Date</th>
                    <th>User ID</th>
                    <th>Invoice Number</th>
                    <th>Total Amount</th>
                    <th>PV</th>
                    <th>CB</th>
                    <th>Action</th>
                </tr>
                @php
                $i = 1;
            @endphp
            @foreach ($rp_redeemed as $rp)
                @foreach ($rp->beneficiary as $bf)
                    @if ($bf->beneficiary_type == 'Creating Bonus')
                        <tr>
                            <td>{{ $i }}</td>
                            <td>${{ date('d-m-Y', strtotime($rp->created_at)) }}</td>
                            <td>{{ $rp->transactions->invoice_no }}</td>
                            <td>{{ $rp->transactions->total_before_tax }}</td>
                            <td>{{ $rp->transactions->rp_earned }}</td>
                            <td>{{ $bf->amount }}</td>
                            <td></td>
                        </tr>
                        @php
                            $i++;
                        @endphp
                    @endif
                @endforeach
            @endforeach
            </table>
        </div>
    </div>
</div>

@endsection
