@extends('dashboard.stockiest_master')

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
    My Withdraw
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">


        @include('layouts.session')

        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>User Withdraw Request List ( {{ $type ? $type : 'All' }} )</h4>
                </div>
            </div>

            <div class="class-body p-3">
                <table class="table table-bordered" id="example1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User Id</th>
                            <th>Gateway</th>
                            <th>Account Info</th>
                            <th>Request To</th>
                            <th>Amount</th>
                            <th>Service Charge</th>
                            <th>Payable Amount</th>
                            <th>Note</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($withdraws as $i => $data)
                            <tr>
                                <td>{{ $i + 1 }}</td>
                                <td>{{ $data->user ? $data->user->user_id : '' }}</td>
                                <td>{{ $data->gateway }}</td>
                                <td>
                                    Acc Name: {{ $data->account_name }} <br>
                                    Acc Number: {{ $data->account_number }}
                                    @if ($data->gateway == 'dbbl')
                                        <br>
                                        Bank Name: {{ $data->bank_name }} <br>
                                        Branch Name: {{ $data->bank_branch }} <br>
                                        Routing Number: {{ $data->routing_number }} <br>
                                        Swift Code: {{ $data->swift_code }}
                                    @endif
                                </td>
                                <td>
                                    {{ $data->request_to }}

                                    @if ($data->stockiest)
                                        <br>
                                        ID: {{ $data->stockiest->stockiest_user_id }}
                                    @endif
                                </td>
                                <td>
                                    {{ $data->amount }}
                                </td>
                                <td>
                                    {{ $data->service_charge }}
                                </td>
                                <td>
                                    {{ $data->payable_amount }}
                                </td>
                                <td>
                                    {{ $data->note }}
                                </td>
                                <td>
                                    @if ($data->status == 'paid')
                                        <span class="badge badge-success">Paid</span>
                                    @elseif($data->status == 'cancel')
                                        <span class="badge badge-danger">Cancel</span>
                                    @else
                                        <span class="badge badge-warning">Pending</span>
                                    @endif
                                </td>
                                <td>
                                    @if ($data->status == 'paid')
                                        <span></span>
                                    @else
                                        <button class="btn btn-success btn-sm edit-btn" data-row-id="{{ $data->id }}">
                                            Edit <i class="fa fa-ellipsis-v"></i>
                                        </button>
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>

        <div class="modal fade" id="exampleModal1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Account Info</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="teacher_box"></div>
                    </div>

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

    <script>
        $(document).on('click', '.edit-btn', function(event) {
            event.preventDefault();

            $('#exampleModal1').modal('show');

            var id = $(this).data('row-id');

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="token"]').attr('value')
                }
            });

            $.ajax({
                url: "{{ route('stockiest.user.withdraw.edit', ['id' => ':id']) }}".replace(':id',
                    id),
                type: 'GET',
                success: function(res) {
                    $("#teacher_box").empty();
                    $("#teacher_box").append(res);
                },
                error: function(data) {
                    console.error(data.responseText);
                }
            });
        });
    </script>
@endpush