@extends('dashboard.admin_master')
@section('admin')
<div class="col-lg-8">
    <div class="card">
        <div class="card-header">Role Manage</div>
        <div class="card-body">
            <form action="{{ route('custom.role.post') }}" method="post">
                @csrf
                {{--  <div class="mb-3">
                    <label for="form-label">Select User</label>
                    <select name="" id="" name="user_role">
                        <option value="0">User</option>
                        <option value="1">Super Admin</option>
                        <option value="2">Depo</option>
                        <option value="3">Stockiest</option>
                    </select>
                </div>  --}}
                <div class="mb-3">
                    <label for="form-label">Select User</label>
                    <select name="" id="" name="user_type" class="form-control">
                        <option value="0">User</option>
                        <option value="1">Super Admin</option>
                        <option value="2">Depo</option>
                        <option value="3">Stockiest</option>
                    </select>
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

@endsection
