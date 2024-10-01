@extends('dashboard.admin_master')
@section('admin')
<div class="col-lg-7">
    <div class="card">
        <div class="card-header">Profile Update</div>
        <div class="card-body">
            <form action="{{ route('custom.photo') }}" method="post" enctype="multipart/form-data">
                @csrf
                <div class="mb-3">
                    <label for="photo">Photo Update</label>
                    <input type="hidden" name="user_id" value="{{ Auth::user()->id }}">
                    <input type="file" name="image" id="" class="form-control">
                </div>
                <div class="mb-3">

                    <button type="submit" class="btn btn-primary">Update</button>
                </div>
            </form>
        </div>
    </div>
</div>

@endsection
