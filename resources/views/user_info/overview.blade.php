@extends('dashboard.admin_master')
@section('admin')
<br><br><br>
<div class="m-auto col-lg-4">
    <div class="card" style="width: 28rem;position: relative;">
        <img class="card-img-top" src="https://demo.themesberg.com/volt/assets/img/profile-cover.jpg" alt="Card image cap">
        <div class="text-center card-body" >
            @if(Auth::user()->photo==null)

            <img src="{{ Avatar::create('Auth::user()->name')->toBase64() }}" style="width: 150px;height:150px;border-radius:50%;position:absolute;left:50%;top:60%;transform:translate(-50%,-50%);" alt="">


            @else
            <img src="{{ asset('upload/profile/') }}/{{ $user_info->photo }}" style="width: 150px;height:150px;border-radius:50%;position:absolute;left:50%;top:60%;transform:translate(-50%,-50%);" alt="">



            @endif


         <div class="mt-5">
            <h3 style="margin-bottom: 2px!important;">{{ $user_info->name }}</h3>
            <p>{{ $user_info->email }}</p>
         </div>

        </div>
      </div>

</div>


@endsection
