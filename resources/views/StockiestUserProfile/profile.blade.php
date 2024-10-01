@extends('dashboard.stockiest_master')

@section('content')

@include('layouts.session')

    <div class="card">
        <div class="card-body">
            <form id="bannerForm" class="needs-validation" action="{{ route('stockiest.profile.update') }}" method="POST"
                novalidate enctype="multipart/form-data">
                @csrf

                <div class="form-row">

                    <div class="col-md-3 mb-3">
                        <label for="title">Name</label>
                        <input type="text" class="form-control form-control-sm" id="title" name="name" readonly
                            placeholder="Enter Name" value="{{ $data->stockiest_name }}">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="title">User Id</label>
                        <input type="text" class="form-control form-control-sm" id="title" name="user_id" readonly
                            placeholder="Enter Id" value="{{ $data->stockiest_user_id }}">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="title">Phone</label>
                        <input type="text" class="form-control form-control-sm" id="title" name="phone" readonly
                            placeholder="Enter Phone" value="{{ $data->stockiest_contact_number }}">
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="title">Email</label>
                        <input type="text" class="form-control form-control-sm" id="title" name="email" readonly
                            placeholder="Enter Email" value="{{ $data->stockiest_email_id }}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="title">Address</label>
                        <input type="text" class="form-control form-control-sm" id="title" name="address"
                            placeholder="Enter Address" value="{{ $data->stockiest_address }}">
                    </div>


                    <div class="col-md-4 mb-3">
                        <label for="blood_group">Blood Group</label>
                        <select class="form-control" id="blood_group" name="blood_group">
                            <option value="">Select Blood Group</option>
                            <option value="A+" {{ $data->blood_group == 'A+' ? 'selected' : '' }}>A+</option>
                            <option value="A-" {{ $data->blood_group == 'A-' ? 'selected' : '' }}>A-</option>
                            <option value="B+" {{ $data->blood_group == 'B+' ? 'selected' : '' }}>B+</option>
                            <option value="B-" {{ $data->blood_group == 'B-' ? 'selected' : '' }}>B-</option>
                            <option value="O+" {{ $data->blood_group == 'O+' ? 'selected' : '' }}>O+</option>
                            <option value="O-" {{ $data->blood_group == 'O-' ? 'selected' : '' }}>O-</option>
                            <option value="AB+" {{ $data->blood_group == 'AB+' ? 'selected' : '' }}>AB+</option>
                            <option value="AB-" {{ $data->blood_group == 'AB-' ? 'selected' : '' }}>AB-</option>
                        </select>
                    </div>




                    <div class="col-md-4 mb-3">
                        <label for="validationCustom01">Image</label>

                        <input class="form-control" name="image" type="file"
                            onchange="previewImage(this, 'image-preview','200px','200px')">

                        <div class="mt-2" id="image-preview">
                            <image src="{{ asset($data->image) }}" alt="" height="200px" width="200px"
                                alt='Alternative Text';" />
                        </div>
                        <div class="invalid-feedback">
                            @error('image')
                                {{ $message }}
                            @enderror
                        </div>
                    </div>
                </div>
                <button class="btn btn-primary" type="submit">Submit</button>
            </form>
        </div>
    </div>

    <div class="card card-default mt-3">
        <div class="card-body">
            <h5>Update Password</h5>
            <form id="passwordUpdateForm" class="needs-validation"
                action="{{ route('stockiest.profile.update_password') }}" method="POST" novalidate>
                @csrf

                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="old_password">Old Password</label>
                        <input type="password" class="form-control form-control-sm" id="old_password" name="old_password"
                            placeholder="Enter old password" required>
                    </div>
                    <div class="col-md-6 mb-3"></div>

                    <div class="col-md-6 mb-3">
                        <label for="new_password">New Password</label>
                        <input type="password" class="form-control form-control-sm" id="password" name="password"
                            placeholder="Enter new password" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label for="confirm_password">Confirm New Password</label>
                        <input type="password" class="form-control form-control-sm" id="password_confirmation"
                            name="password_confirmation" placeholder="Confirm new password" required>
                    </div>
                </div>

                <button class="btn btn-primary" type="submit">Submit</button>
            </form>
        </div>
    </div>
@endsection
