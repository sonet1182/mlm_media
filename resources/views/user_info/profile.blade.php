@extends('dashboard.admin_master')
@push('css')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

@endpush
@section('admin')
<div class="mx-auto col-lg-6">
    <div class="card">
        <div class="card-header"><h4><b>Edit Profile</b></h4></div>
        <div class="card-body">
            <form action="{{ route('user.info.profile.post') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="mb-3">
                    <label for="name">Name:</label>
                    <input type="text" name="name" id="name" class="form-control" placeholder="{{ Auth::user()->name }}">
                </div>
                <div class="mb-3">
                    <label for="name">Email:</label>
                    <input type="email" name="email" id="email" class="form-control" placeholder="{{ Auth::user()->email }}">
                </div>
                <div class="mb-3">
                    <label for="name">Update Photo:</label>
                    <input type="file" name="image" id="photo" class="form-control" >
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
</script>


@endpush

@endsection
