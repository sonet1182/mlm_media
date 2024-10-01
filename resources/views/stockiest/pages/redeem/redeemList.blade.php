@extends('dashboard.stockiest_master')

@section('title')
    Redeem List
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers">
                <div class="d-flex">
                    <div>
                        <h4>Redeem List</h4>
                    </div>

                    <div class="ml-auto">
                        <div class="col-md-12 mb-3">
                            <label>Date range:</label>
                            <div class="input-group" id="rangeInputGroup">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="far fa-clock"></i></span>
                                </div>
                                <input type="text" id="daterange" name="dates" value="" class="form-control" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="class-body p-3">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Created At</th>
                            <th>Invoice No</th>
                            <th>User Id</th>
                            <th>Price Value</th>
                            <th>Point Value</th>
                            <th class="text-center">Type</th>
                            {{-- <th>Action</th> --}}
                        </tr>
                    </thead>
                    <tbody>
                        @include('stockiest.pages.redeem.partials.redeemListTable')
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-md-6">
                        <h5 class="mb-0">Total Price Value: <span
                                id="total_price_value">{{ $total_price_value ?? 0 }}</span></h5>
                    </div>
                    <div class="col-md-6">
                        <h5 class="mb-0">Total Points: <span id="total_point">{{ $total_point ?? 0 }}</span></h5>
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
        $(document).ready(function() {
            // When date range is changed, send an AJAX request
            $('#daterange').on('apply.daterangepicker', function(ev, picker) {
                var startDate = picker.startDate.format('YYYY-MM-DD');
                var endDate = picker.endDate.format('YYYY-MM-DD');

                // Send AJAX request
                $.ajax({
                    url: "{{ route('stockiest.redeemList') }}", // The route to get the filtered data
                    method: "GET",
                    data: {
                        start_date: startDate,
                        end_date: endDate
                    },
                    success: function(response) {
                        // Update the table body with the new data
                        $('#dataTable tbody').html(response.html);

                        // Update total price value and total points
                        $('#total_price_value').text(response.total_price_value);
                        $('#total_point').text(response.total_point);
                    }
                });
            });
        });
    </script>
@endpush
