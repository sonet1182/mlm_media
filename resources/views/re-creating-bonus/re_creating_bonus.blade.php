@extends('layouts.admin')
@section('content')
<div class="col-lg-12">
    <div class="card">
        <div class="card-header"><h6><b>User Re-Creating Bonus</b></h6></div>
        <div class="card-body">
            <div class="justify-between pv-wrapper d-flex align-items-center" style="position: relative;">
                <div class="total_pb" width='400px'><p><b>Total Re-CB:</b></p></div>
                <div class="current_pb" width='400px' style="position: absolute;right:10%;"><p><b>Current Re-CB:</b></p></div>
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
                <tr>
                    <td>1</td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
        </div>
    </div>
</div>

@endsection
