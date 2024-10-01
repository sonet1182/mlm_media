@extends('layouts.admin')

@section('title')
    Guardiansip Points of: {{ $user->customer_name }} - {{ $month }}/{{ $year }}
@endsection

@section('content')
    <main id="main" class="main col-sm-12">
        <section class="section profile">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            @if ($errors->any())
                                <div class="alert alert-danger">
                                    <ul>
                                        @foreach ($errors->all() as $error)
                                            <li>{{ $error }}</li>
                                        @endforeach
                                    </ul>
                                </div>
                            @endif

                            @include('layouts.session')

                            <!-- Month and Year Selection Form -->
                            <form method="GET" action="{{ route('user.captain_ship_points', ['id' => $user->id]) }}">
                                <div class="row mb-3">
                                    <div class="col-md-3">
                                        <label for="month">Select Month</label>
                                        <select id="month" name="month" class="form-control">
                                            @for ($m = 1; $m <= 12; $m++)
                                                <option value="{{ $m }}" {{ $m == $month ? 'selected' : '' }}>
                                                    {{ date('F', mktime(0, 0, 0, $m, 1)) }}
                                                </option>
                                            @endfor
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="year">Select Year</label>
                                        <select id="year" name="year" class="form-control">
                                            @for ($y = date('Y'); $y >= 2000; $y--)
                                                <option value="{{ $y }}" {{ $y == $year ? 'selected' : '' }}>
                                                    {{ $y }}
                                                </option>
                                            @endfor
                                        </select>
                                    </div>
                                    <div class="col-md-3 align-self-end">
                                        <button type="submit" class="btn btn-primary">Filter</button>
                                    </div>

                                </div>
                            </form>


                            <!-- Table with stripped rows -->
                            <table class="table table-bordered table-striped" id="">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Bonus Name</th>
                                        <th scope="col">Total Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Purchase Bonus</td>
                                        <td>{{ $total_purchase_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Creating Bonus</td>
                                        <td>{{ $total_creating_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>Refer Bonus</td>
                                        <td>{{ $total_refer_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>Rank Reward Bonus</td>
                                        <td>{{ $total_rank_reward_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>After Death Allowance</td>
                                        <td>{{ $total_ada_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td>Company Profit Share</td>
                                        <td>{{ $total_cps_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>7</td>
                                        <td>Stockiest Refer Bonus</td>
                                        <td>{{ $total_stockiest_ref_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td>8</td>
                                        <td>Company Fund</td>
                                        <td>{{ $total_cf_bonus }}</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" class="text-end">
                                            <div class="float-right">Total:</div>
                                        </td>
                                        <td>{{ $total }}</td>
                                    </tr>
                                </tbody>
                            </table>


                          

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
@endpush
