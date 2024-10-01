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
    Purchase
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Purchase List</h4>
                </div>
            </div>

            <div class="class-body p-3">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Invoice No</th>
                            <th>Price Value</th>
                            <th>Point Value</th>
                            <th class="text-center">Type</th>
                            <th>Created At</th>
                            {{-- <th>Action</th> --}}
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($purchase as $i => $data)
                            <tr>
                                <td>{{ $i + 1 }}</td>
                                <td>{{ $data->transactions->invoice_no }}</td>
                                <td>{{ $data->price_value }}</td>
                                <td>{{ $data->point }}</td>
                                <td class="text-center">
                                    @if ($data->type == 'activate')
                                        <span class="btn btn-sm btn btn-success">Acivate</span>
                                    @else
                                        <span class="btn btn-sm btn btn-primary">Repurchase</span>
                                    @endif
                                </td>
                                <td>{{ $data->created_at->format('h:i A | d F, Y') }}</td>
                                {{-- <td>
                                    <a class="btn btn-sm btn-info" href="{{ route('user.redeem_list', $data->id) }}"><i
                                            class="fa fa-eye"></i> View Redeem</a>
                                </td> --}}
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
