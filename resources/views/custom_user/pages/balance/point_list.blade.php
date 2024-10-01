@extends('layouts.admin')

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
                                        <td>Purchase Bonus</td>
                                        <td>{{ $purchase_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="purchase_bonus"
                                                data-amount="{{ $purchase_bonus }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Creating Bonus</td>
                                        <td>{{ $creating_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="creating_bonus"
                                                data-amount="{{ $creating_bonus }}">Add to
                                                Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Re-creating Bonus</td>
                                        <td>{{ $re_creating_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="re_creating_bonus"
                                                data-amount="{{ $re_creating_bonus }}">Add
                                                to Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Equal Bonus</td>
                                        <td>{{ $equal_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="equal_bonus"
                                                data-amount="{{ $equal_bonus }}">Add
                                                to Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Rank Reward Bonus</td>
                                        <td>{{ $rank_reward_bonus }}</td>
                                        <td>
                                            {{-- <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="rank_reward_bonus"
                                                data-amount="{{ $rank_reward_bonus }}">Add
                                                to Balance</button> --}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Captainship Bonus</td>
                                        <td>{{ $cb }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="captainship_bonus"
                                                data-amount="{{ $cb }}">Add
                                                to Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Guardianship Bonus</td>
                                        <td>{{ $gb }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="guardianship_bonus"
                                                data-amount="{{ $gb }}">Add
                                                to Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Stockist Refer Bonus</td>
                                        <td>{{ $sto_ref_bonus }}</td>
                                        <td>
                                            <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="stockiest_refer_bonus"
                                                data-amount="{{ $sto_ref_bonus }}">Add
                                                to Balance</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>After Death Allowance</td>
                                        <td>{{ $ada }}</td>
                                        <td>
                                            {{-- <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="after_death_allowance"
                                                data-amount="{{ $ada }}">Add to
                                                Balance</button> --}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Company Profit Share</td>
                                        <td>{{ $cf }}</td>
                                        <td>
                                            {{-- <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="company_profit_share"
                                                data-amount="{{ $cps }}">Add to
                                                Balance</button> --}}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Company Fund</td>
                                        <td>{{ $cf }}</td>
                                        <td>
                                            {{-- <button class="btn btn-sm btn-info" data-toggle="modal"
                                                data-target="#exampleModalCenter" data-type="company_fund"
                                                data-amount="{{ $cf }}">Add to
                                                Balance</button> --}}
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

                            <form action="{{ route('user.add_to_balance') }}" method="post">

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
