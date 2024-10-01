@extends('custom_user.pages.auth.layout')

@section('title')
    Reset Password
@endsection

@section('content')

    @include('layouts.session')

    <div class="">
        <!-- Form to request OTP -->
        <form class="login" action="{{ route('forgot.password.sendOtp') }}" method="POST" class="login">
            @csrf
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" name="email" class="form-control" required>
                @if ($errors->has('email'))
                    <span class="text-danger">{{ $errors->first('email') }}</span>
                @endif
            </div>
            <input type="submit" class="btn btn-success" value="Send OTP">

        </form>

    </div>
@endsection
