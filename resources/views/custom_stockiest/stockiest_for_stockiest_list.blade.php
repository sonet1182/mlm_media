
@extends('dashboard.stockiest_master')
@section('content')
<style>
    .card-headers{
        position: relative;
        width: 100%;
    }
    .add_depo{
        position: absolute;
        right: -3%;
        top: 50%;
        transform: translate(-50%,-50%);



    }

</style>
<div class="col-lg-12">
    <div class="card">
        <div class="card-header card-headers" style="">
            <div style="">
                <h4>Stockiest List</h4>
            </div>
            <div style="" class="add_depo">
                <a href="{{ route('stockiest.stockiest.for.add') }}" class="btn btn-primary">Add Stockiest</a>
            </div>

        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>Stockist Name</th>
                    <th>Contact Person Name</th>
                    <th>Contact Number</th>
                    <th>Stockist Email</th>
                    <th>Stockist Address</th>
                    <th>Stockist Area</th>
                    <th>Stockist User Id</th>
                    <th>Action</th>
                </tr>
                @foreach ($stockists as $stockist)
                <tr>
                    <td>{{ $stockist->stockiest_name }}</td>
                    <td>{{ $stockist->stockiest_contact_person_name }}</td>
                    <td>{{ $stockist->contact_number }}</td>
                    <td>{{ $stockist->stockiest_email_id }}</td>
                    <td>{{ $stockist->stockiest_address }}</td>
                    <td>{{ $stockist->stockiest_arya }}</td>
                    <td>{{ $stockist->stockiest_user_id }}</td>
                    <td>
                        <div class="d-flex justify-content-between" >
                            <a href="#" class="shadow btn btn-danger btn-xs sharp"><i class="fa fa-trash"></i></a>&NonBreakingSpace;  <a href="#" class="shadow btn btn-primary btn-xs sharp"><i class="fa fa-edit"></i></a> &NonBreakingSpace; <a href="#" class="shadow btn btn-success btn-xs sharp"><i class="fa fa-eye"></i></a>
                        </div>
                    </td>

                </tr>

                @endforeach
            </table>
        </div>
    </div>

</div>

@endsection

