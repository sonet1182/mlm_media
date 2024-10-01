@extends('layouts.admin')

@section('title')
    Equal Bonus
@endsection

@section('content')
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h6><b>Equal Bonus List</b></h6>
            </div>
            <div class="card-body">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Sl</th>
                            <th>Bonus Amount</th>
                            <th>Date</th>
                            <th>Left Side Point</th>
                            <th>Right Side Point</th>
                            <th>Carry Point</th>
                            <th>Carry Side</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($equalBonus as $i => $data)
                            <tr>
                                <td>{{ $i + 1 }}</td>
                                <td>{{ $data->bonus_amount }}</td>
                                <td>{{ $data->date }}</td>
                                <td>{{ $data->left_sum }}</td>
                                <td>{{ $data->right_sum }}</td>
                                <td>{{ $data->carry }}</td>
                                <td>{{ ucfirst($data->carry_side) }}</td>

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
