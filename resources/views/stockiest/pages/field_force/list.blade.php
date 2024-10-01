@extends('dashboard.stockiest_master')


@section('title')
    Sales Team
@endsection

<style>
    .card-headers {
        position: relative;
        width: 100%;
    }

    .add_customer {
        position: absolute;
        right: -3.5%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
</style>


@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Field Force List of: {{ $user->user_id }}</h4>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-striped" id="dataTable">
                    <thead>
                        <tr>
                            <th>customer Name</th>
                            <th>Contact Number</th>
                            <th>customer Email</th>
                            <th>customer Address</th>
                            <th>Stockiest Id</th>
                            <th>customer User Id</th>
                            <th>Referrel Info</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($customers as $customer)
                            <tr>
                                <td>{{ $customer->customer_name }}</td>
                                <td>{{ $customer->customer_contact_number }}</td>
                                <td>{{ $customer->customer_email }}</td>
                                <td>{{ $customer->customer_address }}</td>
                                <td>{{ $customer->stockiest->stockiest_user_id ?? '' }}</td>
                                <td>{{ $customer->user_id }}</td>
                                <td>
                                    <a href="{{ route('stockiest.refer_info_child_data', $customer->id) }}"
                                        class="btn btn-sm btn-primary"><i class="fa fa-eye"></i> Show Field Force List</a>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
@endsection


@push('js')
    <script>
        $(document).ready(function() {
            $("#dataTable").DataTable({
                "order": [] // Disable default sorting
            });
        });
    </script>
@endpush
