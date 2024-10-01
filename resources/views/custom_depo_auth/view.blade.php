@extends('layouts.admin')
@section('content')
<div class="col-lg-12">
    <div class="card">
        <div class="card-header"><h4>Customer Details</h4></div>
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
                    <th>Photo</th>


                </tr>
                @foreach ($viewers as $depo)
                <tr>
                    <td>{{ $depo->depo_name }}</td>
                    <td>{{ $depo->contact_person_name }}</td>
                    <td>{{ $depo->contact_number }}</td>
                    <td>{{ $depo->depo_email_id }}</td>
                    <td>{{ $depo->depo_address }}</td>
                    <td>{{ $depo->depo_arya }}</td>
                    <td>{{ $depo->depo_user_id }}</td>
                    <td>
                        @if($depo->photo==null)
                        <img src="{{ Avatar::create($depo->depo_name)->toBase64() }}"  width="20px" />


                        @else
                        <img src="{{ asset('upload/profile/') }}/{{ $depo->photo }}"   width="20px" height="20px"  style="border-radius:50% !important;height:40px !important;width:40px !important;" alt="User Image"/>


                        @endif

                    </td>

                </tr>

                @endforeach

            </table>
        </div>
    </div>
</div>

@endsection
