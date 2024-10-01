@extends('layouts.admin')
@section('content')
<div class="col-lg-12">
    <div class="card">
        <div class="card-header"><h6><b>User Income Statement</b></h6></div>
        <div class="card-body">
            {{--  <div class="justify-between pv-wrapper d-flex align-items-center" style="position: relative;">
                <div class="total_pb" width='400px'><p><b>Total Re-CB:</b></p></div>
                <div class="current_pb" width='400px' style="position: absolute;right:10%;"><p><b>Current Re-CB:</b></p></div>
            </div>  --}}
            <table class="table table-bordered">
                <tr>
                    <th>Sl</th>
                    <th>Month</th>
                    <th>Purchase
                        Bonus</th>
                    <th>Creating
                        Bonus</th>
                    <th>Re-Creating
                        Bonus</th>
                    <th>Equal
                        Bonus</th>
                    <th>Stockiest
                        Refer Bonus</th>
                        <th>Total</th>
                    <th>Action</th>
                </tr>
                @foreach ($captainshipBonus as $key=> $captainB)

                <tr>
                    <td>{{$key +1}}</td>
                    <td>{{$captainB->month}}</td>
                    <td>{{$captainB->purchaseBonus}}</td>
                    <td>{{$captainB->creatingBonus}}</td>
                    <td>{{$captainB->reCreatingBonus}}</td>
                    <td>{{$captainB->equalBonus}}</td>
                    <td>{{$captainB->stockiestReferBonus}}</td>
                    <td>{{$captainB->total}}</td>
                    <td></td>

                </tr>
                @endforeach
            </table>
        </div>
    </div>
</div>

@endsection
