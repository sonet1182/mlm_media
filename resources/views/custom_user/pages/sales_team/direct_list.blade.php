@extends('layouts.admin')

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
                    <h4>Direct List</h4>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Searial</th>
                                <th>customer Name</th>
                                <th>Contact</th>
                                <th>customer Address</th>
                                <th>Stockiest Id</th>
                                <th>customer User Id</th>
                                <th>Ref Id</th>
                                <th>Place Id</th>
                                <th>Placement Side</th>
                                <th>IP Active</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($customers as $i => $customer)
                                @php
                                    $refUser = \App\Models\CustomUser::where('id', $customer->user_ref_id)->first();
                                    $placeUser = \App\Models\CustomUser::where('id', $customer->place_user_id)->first();
                                    $stockiest = \App\Models\Stockiest::where('id', $customer->stockiest_id)->first();
                                @endphp
                                <tr>
                                    <td>{{ $i + 1 }}</td>
                                    <td>{{ $customer->customer_name }}</td>
                                    <td>
                                        Phone: {{ $customer->customer_contact_number }} <br>
                                        Email: {{ $customer->customer_email }}
                                    </td>
                                    <td>{{ $customer->customer_address }}</td>
                                    <td>{{ $stockiest ? $stockiest->stockiest_user_id : '' }}</td>
                                    <td>{{ $customer->user_id }} </td>
                                    <td>{{ $customer->referredBy ? $customer->referredBy->user_id : '' }}</td>
                                    <td>{{ $placeUser ? $placeUser->user_id : '' }}</td>
                                    <td>{{ $customer->placement_side }}</td>
                                    <td>{{ $customer->is_IpActive ? 'Active' : 'Inactive' }}</td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
@endsection


@push('js')
<script>
    $(function() {
        $("#example1").DataTable({
            "order": [],
            "responsive": false,
            "lengthChange": true,
            "autoWidth": true,
            "buttons": [{
                    extend: 'csv',
                },
                {
                    extend: 'excel',
                },
                'colvis'
            ]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    });
</script>
@endpush
