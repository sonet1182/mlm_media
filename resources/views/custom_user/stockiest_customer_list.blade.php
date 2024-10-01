@extends('dashboard.stockiest_master')

<style>
    .card-headers{
        position: relative;
        width: 100%;
    }
    .add_customer{
        position: absolute;
        right: -3.5%;
        top: 50%;
        transform: translate(-50%,-50%);
    }
</style>


@section('content')
<div class="col-lg-12 col-12 col-md-12 col-sm-12">
    <div class="card">
        <div class="card-header card-headers" style="">
            <div style="">
                <h4>customer List</h4>
            </div>
            <div style="" class="add_customer">
                <a href="{{ route('stockiest.custom.add') }}" class="btn btn-primary">Add customer</a>
            </div>

        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>customer Name</th>
                    {{--  <th>Contact Person Name</th>  --}}
                    <th>Contact Number</th>
                    <th>customer Email</th>
                    <th>customer Address</th>
                    <th>Stockiest Id</th>
                    <th>customer User Id</th>
                    <th>Action</th>
                </tr>
                @foreach ($customers as $customer)
                <tr>
                    <td>{{ $customer->customer_name }}</td>
                    {{--  <td>{{ $customer->customer_contact_person_name }}</td>  --}}
                    <td>{{ $customer->customer_contact_number }}</td>
                    <td>{{ $customer->customer_email }}</td>
                    <td>{{ $customer->customer_address }}</td>
                    <td>{{ $customer->stockiest_id }}</td>
                    <td>{{ $customer->user_id }}</td>
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
