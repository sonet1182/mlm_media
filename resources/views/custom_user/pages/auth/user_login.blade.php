@extends('custom_user.pages.auth.layout')

@section('title')
    Login
@endsection

@section('content')
    @if (session('errors'))
        <div class="alert alert-danger" role="alert">
            {{ session('errors') }}
        </div>
    @endif

    <form action="{{ route('customer.user.login') }}" method="post">
        @csrf
        <div class="mb-3 input-group">
            <input type="text" class="form-control" placeholder="User Id" name="user_id" value="{{ old('user_id') }}"
                required>
            <div class="input-group-append">
                <div class="input-group-text">
                    <span class="fas fa-user"></span>
                </div>
            </div>
        </div>

        <div class="mb-3 input-group">
            <input type="password" class="form-control" placeholder="Password" name="password"
                value="{{ old('password') }}">
            <div class="input-group-append">
                <div class="input-group-text">
                    <span class="fas fa-lock"></span>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-8">

            </div>
            <!-- /.col -->
            <div class="col-4">
                <button type="submit" class="btn btn-primary btn-block">Login</button>
            </div>
            <!-- /.col -->

        </div>
    </form>

    <a href="{{ route('forgot.password.form') }}">Forgot password</a>
@endsection
