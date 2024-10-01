@extends('layouts.admin')

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
    Withdraw Request
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Request List</h4>
                </div>
            </div>

            <div class="class-body p-3">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Gateway</th>
                            <th>Account Info</th>
                            <th>Request To</th>
                            <th>Amount</th>
                            <th>Service Charge</th>
                            <th>Payable Amount</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($withdraws as $i => $data)
                            <tr>
                                <td>{{ $i + 1 }}</td>
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
                                    @if ($data->status == 'paid')
                                        <span class="badge badge-success">Paid</span>
                                    @elseif($data->status == 'cancel')
                                        <span class="badge badge-danger">Cancel</span>
                                    @else
                                        <span class="badge badge-warning">Pending</span>
                                    @endif
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
