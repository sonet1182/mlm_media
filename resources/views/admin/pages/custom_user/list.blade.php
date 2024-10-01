@extends('dashboard.admin_master')

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


@section('title')
    User
@endsection

@section('admin')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Customer List</h4>
                </div>
                <div style="" class="add_customer">
                    <a href="{{ route('user.add') }}" class="btn btn-primary"><i class="fa fa-plus"></i> Add customer</a>
                </div>
            </div>


            <div class="card-body">

                @if (session('status'))
                    <div class="alert alert-success">
                        {{ session('status') }}
                    </div>
                @endif

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
                                <th style="width: 180px">Referral Info</th>
                                <th>Action</th>
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
                                    <td style="width: 180px">
                                        <a href="{{ route('admin.placement_tree', $customer->id) }}"
                                            class="btn btn-sm btn-primary"><i class="fa fa-tree"></i> Tree</a>
                                        {{-- <a href="{{ route('admin.refer_info_child', $customer->id) }}"
                                            class="btn btn-sm btn-info"><i class="fa fa-info"></i> Child</a> --}}
                                        <a href="{{ route('admin.refer_info_parental', $customer->id) }}"
                                            class="btn btn-sm btn-success"><i class="fa fa-info"></i> Parental </a>
                                    </td>
                                    <td style="width: 180px">
                                        <a href="{{ route('admin.user.reset_password', $customer->id) }}"
                                            class="btn btn-sm btn-primary"
                                            onclick="return confirm('Are you sure you want to reset the password for this user?');">
                                            <i class="fa fa-cog"></i> Reset Password
                                        </a>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>

                        <tfoot>
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
                                <th style="width: 180px">Referral Info</th>
                                <th>Action</th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>


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
                            exportOptions: {
                                columns: ':not(:nth-last-child(2)):not(:last-child)' // Exclude the last column ("Action")
                            }
                        },
                        {
                            extend: 'excel',
                            exportOptions: {
                                columns: ':not(:nth-last-child(2)):not(:last-child)' // Exclude the last column ("Action")
                            }
                        },
                        'colvis'
                    ]
                }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
            });
        </script>
    @endpush
@endsection
