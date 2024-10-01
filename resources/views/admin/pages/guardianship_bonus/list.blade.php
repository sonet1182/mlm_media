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
    Guardianship Bonus
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
                            <form method="POST" action="{{ route('admin.user.guardianship_bonus_distribute') }}">
                                @csrf
                                <div class="row mb-3">
                                    <div class="col-md-3">
                                        <label for="month">Select Month</label>
                                        <select id="month" name="month" class="form-control">
                                            @for ($m = 1; $m <= 12; $m++)
                                                <option value="{{ $m }}">
                                                    {{ date('F', mktime(0, 0, 0, $m, 1)) }}
                                                </option>
                                            @endfor
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="year">Select Year</label>
                                        <select id="year" name="year" class="form-control">
                                            @for ($y = date('Y'); $y >= 2000; $y--)
                                                <option value="{{ $y }}">
                                                    {{ $y }}
                                                </option>
                                            @endfor
                                        </select>
                                    </div>
                                    <div class="col-md-3 align-self-end">
                                        <button type="submit" class="btn btn-primary">Distribute</button>
                                    </div>

                                </div>
                            </form>


                            <!-- Table with stripped rows -->
                            <table class="table table-bordered table-striped" id="">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Date</th>
                                        <th scope="col">Created At</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    @foreach ($gs_list as $i => $data)

                                    <tr>
                                        <td>{{ $i + 1 }}</td>
                                        <td>{{ $data->date }}</td>
                                        <td>{{ $data->created_at->format('h:i A | d F, Y') }}</td>
                                    </tr>
                                        
                                    @endforeach

                                    
                                    
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
