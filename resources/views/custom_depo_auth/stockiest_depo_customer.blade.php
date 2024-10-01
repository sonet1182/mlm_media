@extends('dashboard.stockiest_master')

<style>
    .card-headers{
        position: relative;
        width: 100%;
    }
    .add_depo{
        position: absolute;
        right: -2%;
        top: 50%;
        transform: translate(-50%,-50%);



    }

</style>


@section('content')
<div class="col-lg-12 col-12 col-md-12 col-sm-12">
    <div class="card">
        <div class="card-header card-headers" style="">
            <div style="">
                <h4>Depo List</h4>
            </div>
            <div style="" class="add_depo">
                <a href="{{ route('stockiest.depo.add') }}" class="btn btn-primary">Add Depo</a>
            </div>

        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>Depo Name</th>
                    <th>Contact Person Name</th>
                    <th>Contact Number</th>
                    <th>Depo Email</th>
                    <th>Depo Address</th>
                    <th>Depo Area</th>
                    <th>Depo User Id</th>
                    <th>Action</th>
                </tr>
                @foreach ($depos as $depo)
                <tr>
                    <td>{{ $depo->depo_name }}</td>
                    <td>{{ $depo->contact_person_name }}</td>
                    <td>{{ $depo->contact_number }}</td>
                    <td>{{ $depo->depo_email_id }}</td>
                    <td>{{ $depo->depo_address }}</td>
                    <td>{{ $depo->depo_arya }}</td>
                    <td>{{ $depo->depo_user_id }}</td>
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
