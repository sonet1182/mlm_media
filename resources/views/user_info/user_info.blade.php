@extends('dashboard.admin_master')
@section('admin')
<div class="col-lg-12">
    <div class="card">
        <div class="card-header">User Information</div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <td class="text-center"><a href="{{ route('overview.info') }}" class="text-center text-dark"><b>Overview</b></a></td>
                    <td class="text-center"><a href="{{ route('user.info.profile') }}"class="text-dark"><b>Edit Profile</b></a></td>
                    <td class="text-center"><a href="{{ route('user.info.profile.password') }}"class="text-dark"><b>Change Password</b></a></td>
                </tr>
            </table>
        </div>
    </div>
</div>

@endsection
