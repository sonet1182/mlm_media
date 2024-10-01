@extends('dashboard.admin_master')
@section('admin')
    <style>
        .card-headers {
            position: relative;
            width: 100%;
        }

        .add_depo {
            position: absolute;
            right: -3%;
            top: 50%;
            transform: translate(-50%, -50%);



        }
    </style>
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Stockiest List</h4>
                </div>
                <div style="" class="add_depo">
                    <a href="{{ route('stockiest.register') }}" class="btn btn-primary">Add Stockiest</a>
                </div>

            </div>
            <div class="card-body">

                @include('layouts.session')

                <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Stockist Name</th>
                                <th>Contact Person Name</th>
                                <th>Contact Number</th>
                                <th>Stockist Email</th>
                                <th>Stockist Address</th>
                                <th>Stockist Area</th>
                                <th>Stockist User Id</th>
                                <th>Refer Id</th>
                                <th>Action</th>
                                <th>Password Action</th>
                            </tr>
                        </thead>

                        <tbody>
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
                                        @if ($stockist->stockiest_ref_id_type == 'user')
                                            {{ $stockist->user_refer->user_id ?? '' }}
                                        @elseif($stockist->stockiest_ref_id_type == 'stockiest')
                                            {{ $stockist->stockiest_refer->stockiest_user_id ?? '' }}
                                        @else
                                            {{ $stockist->depo_refer->depo_user_id ?? '' }}
                                        @endif
                                    </td>
                                    <td>
                                        <div class="d-flex justify-content-between">

                                            <a href="{{ route('admin.stockiest.edit', $stockist->id) }}"
                                                class="shadow btn btn-primary btn-sm sharp"><i class="fa fa-edit"></i></a>



                                            <a href="{{ route('admin.stockiest.delete', $stockist->id) }}"
                                                class="shadow btn btn-danger btn-sm sharp"
                                                onclick="return confirm('Are you sure to delete this stockiest?');"><i
                                                    class="fa fa-trash"></i></a>
                                        </div>
                                    </td>
                                    <td style="width: 180px">
                                        <a href="{{ route('admin.stockiest.reset_password', $stockist->id) }}"
                                            class="btn btn-sm btn-primary"
                                            onclick="return confirm('Are you sure you want to reset the password for this stockiest?');">
                                            <i class="fa fa-cog"></i> Reset Password
                                        </a>
                                    </td>

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
            "responsive": true,
            "lengthChange": false,
            "autoWidth": false,
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
