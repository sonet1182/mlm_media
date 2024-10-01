@extends('layouts.admin')
@push('css')
<link rel="stylesheet" href="sweetalert2.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" rel="stylesheet">


@endpush
@section('content')
<div class="col-lg-12">
  <div class="card">
    <div class="card-header"><h4>DEPO REGISTRATION </h4></div>
    <div class="card-body">
        <form action="{{ route('depo.depo.register.post.user') }}" method="post">
            @csrf
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Name:</label>
                            <input type="hidden"  value="1" name="min">
                            <input type="text" name="depo_name" id="" class="form-control" placeholder="Enter Depo Name">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Contact Person Name:</label>
                            <input type="text" name="depo_contact_personal_name" id="" class="form-control" placeholder="Enter Depo Contract Name">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Contact Number:</label>
                            <input type="text" name="depo_contact_number" id="" class="form-control" placeholder="Enter Depo Contact Number">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Email ID:</label>
                            <input type="email" name="depo_email_id" id="" class="form-control" placeholder="Enter Depo Email">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Address:</label>
                            <input type="text" name="depo_address" id="" class="form-control" placeholder="Enter Depo Address">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Arya:</label>
                            <input type="text" name="depo_arya" id="" class="form-control" placeholder="Enter Depo Arya">
                        </div>
                    </div>
                    {{--  <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo User ID:</label>
                            <input type="hidden" name="depo_user_id" id="" class="form-control" placeholder="Enter Depo User Id">
                        </div>
                    </div>  --}}
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo  UserPassword:</label>
                            <input type="password" name="depo_user_password" id="" class="form-control" placeholder="Enter Depo Password">
                        </div>
                    </div>


                </div>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <button type="submit" class="btn btn-primary">Add Depo</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
  </div>
</div>
@push('js')
<script src="sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>


@endpush

@endsection

