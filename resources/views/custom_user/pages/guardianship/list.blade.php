@extends('layouts.admin')

@section('title')
    Guardianship List
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


                            <!-- Table with stripped rows -->
                            <table class="table table-bordered table-striped" id="dataTable">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">User Id</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Phone Number</th>
                                        <th scope="col">Created At</th>
                                        <th scope="col">Action</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    @foreach ($captainships as $i => $data)
                                        <tr>
                                            <td>{{ $i + 1 }}</td>
                                            <td>{{ $data->user_id }}</td>
                                            <td>{{ $data->customer_name }}</td>
                                            <td>{{ $data->customer_contact_number }}</td>
                                            <td>{{ $data->created_at->format('h:i A | d F, Y') }}</td>
                                            <td>
                                                <a href="{{ route('user.guardian_ship_points', $data->id) }}" class="btn btn-sm btn-info">View Points</a>
                                            </td>
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
