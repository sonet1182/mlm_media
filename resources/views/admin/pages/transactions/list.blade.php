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
    Transaction
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Transaction List</h4>
                </div>
            </div>

            <div class="class-body p-3">
                <table class="table table-bordered" id="example1">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Invoice No</th>
                            <th>Redeem Before Tax</th>
                            <th>RP Earned</th>
                            <th>Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($transactions as $i => $data)
                            <tr>
                                <td>{{ $i + 1 }}</td>
                                <td>{{ $data->invoice_no }}</td>
                                <td>{{ $data->total_before_tax }}</td>
                                <td>{{ $data->rp_earned }}</td>
                                <td>
                                    @if ($data->transaction_type == 1)
                                        <span class="badge badge-warning">Used</span>
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
