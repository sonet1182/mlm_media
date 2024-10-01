@extends('dashboard.stockiest_master')

@section('title')
    Balance
@endsection


@section('content')
    <main id="main" class="main col-sm-12">


        <section class="section profile">
            <div class="row">
                <div class="col-xl-12">
                    <div class="card">
                        <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                            <h3>
                                Current Balance: <span style="font-weight: 600;"> {{ number_format($total_balance, 2)  }} BDT
                                </span>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="card">

                        <div class="card-body">


                            @include('layouts.session')


                            <!-- Table with stripped rows -->
                            <table class="table table-bordered table-striped" id="dataTable">
                                <thead>
                                    <tr>
                                        <th scope="col">Bonus Name</th>
                                        <th scope="col">Amount</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>User Withdraw Balance</td>
                                        <td>{{ $stockiest_withdraw }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="stockiest_withdraw"
                                                data-amount="{{ $stockiest_withdraw }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Stockiest Bonus</td>
                                        <td>{{ $stockiest_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="stockiest_bonus"
                                                data-amount="{{ $stockiest_bonus }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr>
                                    {{-- <tr>
                                        <td>Stockiest Refer Bonus</td>
                                        <td>{{ $stockiest_refer_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="stockiest_refer_bonus"
                                                data-amount="{{ $stockiest_refer_bonus }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr> --}}
                                    <tr>
                                        <td>House Rent</td>
                                        <td>{{ $house_rent }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="house_rent"
                                                data-amount="{{ $house_rent }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Currier Cost</td>
                                        <td>{{ $currier_cost }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="currier_cost"
                                                data-amount="{{ $currier_cost }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog"
                aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Enter Amount</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <form action="{{ route('stockiest.add_to_balance') }}" method="post">

                                @csrf
                                <input type="hidden" class="form-control" id="modalType" name="type" value="">

                                <div class="form-group row">
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="modalAmount" name="amount"
                                            value="">
                                    </div>
                                    <div class="col-sm-4">
                                        <button type="submit" class="btn btn-primary ">Add Balance</button>
                                    </div>
                                </div>

                            </form>



                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main><!-- End #main -->
    <script></script>
@endsection

@push('js')
    <script>
        $(document).ready(function() {
            $("#dataTable").DataTable({
                "order": [] // Disable default sorting
            });
        });
    </script>

    <script>
        $(document).ready(function() {
            $('#exampleModalCenter').on('show.bs.modal', function(event) {
                var button = $(event.relatedTarget); // Button that triggered the modal
                var amount = button.data('amount'); // Extract info from data-* attributes
                var type = button.data('type');
                var modal = $(this);
                modal.find('.modal-body #modalAmount').val(amount); // Update the modal's content
                modal.find('.modal-body #modalType').val(type); // Update the modal's content
            });
        });
    </script>
@endpush
