@extends('dashboard.admin_master')
@push('css')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

@endpush
@section('admin')
<div class="mx-auto col-lg-6">
    <div class="card">
        <div class="card-header"><h4><b>Edit Profile</b></h4></div>
        <div class="card-body">
            <form action="{{ route('password.update') }}" method="post" enctype="multipart/form-data">
                @method('put')
                @csrf
                <div class="mb-3">
                    <label for="name">Current Password:</label>
                    <input type="password" name="current_password"  class="form-control">
                </div>
                <div class="mb-3">
                    <label for="name"> Password:</label>
                    <input type="password" name="password"  class="form-control">
                </div>
                <div class="mb-3">
                    <label for="name">Confirm Password:</label>
                    <input type="password" name="password_confirmation"  class="form-control">
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Save Info</button>
                </div>
            </form>
        </div>
    </div>
</div>
@push('js')
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>


    @if(Session::has('status'))
            toastr.success("{{ Session::get('status') }}");
    @endif





  </script>


@endpush

@endsection
