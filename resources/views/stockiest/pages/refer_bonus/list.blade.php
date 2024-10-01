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
    Stockiest Bonus
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Stockist Bonus List</h4>
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
                                <th>Reedemed User</th>
                                <th>Invoice No</th>
                                <th>Price Value</th>
                                <th>Point Value</th>
                                <th>Bonus Point</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($bonus as $i => $data)
                                <tr>
                                    <td>{{ $i + 1 }}</td>
                                    <td>{{ $data->redeem_c_user->users->user_id ?? '' }}</td>
                                    <td>{{ $data->redeem_c_user->transactions->invoice_no ?? '' }}</td>
                                    <td>{{ $data->redeem_c_user->price_value ?? '' }}</td>
                                    <td>{{ $data->redeem_c_user->point ?? '' }}</td>
                                    <td>{{ $data->amount }}</td>
                                    <td>{{ $data->created_at->format('h:i A | d F, Y') }}</td>
                                </tr>
                            @endforeach
                        </tbody>
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
@endsection
