@extends('layouts.admin')

@section('title')
    {{ $bonus_type }}
@endsection

@section('content')
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h6><b>Bonus List</b></h6>
            </div>
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Sl</th>
                            <th>Redeemed User</th>
                            <th>Price Value</th>
                            <th>Point</th>
                            <th>Bonus Amount</th>
                            <th>Type</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($rp_redeemed as $i => $data)
                            <tr>
                                <td>{{ $i + 1 }}</td>
                                <td>{{ $data->redeem_c_user ? $data->redeem_c_user->users->user_id : '' }}</td>
                                <td>{{ $data->redeem_c_user ? $data->redeem_c_user->price_value : '' }}</td>
                                <td>{{ $data->redeem_c_user ? $data->redeem_c_user->point : '' }}</td>
                                <td>{{ $data->amount }}</td>
                                <td>{{ $data->activate_type }}</td>
                                <td>{{ $data->created_at->format('h:i A | d F, Y') }}</td>
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
