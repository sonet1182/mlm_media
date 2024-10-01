@extends('dashboard.depo_master')
@push('css')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

@endpush
@section('depo')
<div class="col-lg-12">
    <div class="card">
        <div class="card-header">Profile Update</div>
        <div class="card-body">
            <form action="{{ route('depo.admin.user.profile.post') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="mb-3">
                    <label for="photo">Photo Update</label>

                    <input type="file" name="image" id="" class="form-control">
                </div>
                <div class="mb-3">

                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>
{{-- <div class="col-lg-6">
    <div class="card">
        <div class="card-header">Profile Update</div>
        <div class="card-body">
            <form action="{{ route('custom.admin.user.profile.post') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="mb-3">
                    <label for="photo">Photo Update</label>

                    <input type="file" name="image" id="" class="form-control">
                </div>
                <div class="mb-3">

                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div> --}}

<div class=" col-lg-12">
    <div class="card">
        <div class="card-header"><h4><b>Update Password</b></h4></div>
        <div class="card-body">
            <form action="{{ route('depo.admin.user.password.update') }}" method="post" >

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



    @if(Session::has('success'))

            toastr.success("{{ Session::get('success') }}");

    @endif



    @if(Session::has('info'))

            toastr.info("{{ Session::get('info') }}");

    @endif



    @if(Session::has('warning'))

            toastr.warning("{{ Session::get('warning') }}");

    @endif



    @if(Session::has('error'))

            toastr.error("{{ Session::get('error') }}");

    @endif



  </script>

@endpush

@endsection
