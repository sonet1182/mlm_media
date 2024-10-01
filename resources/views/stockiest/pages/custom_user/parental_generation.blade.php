@extends('dashboard.stockiest_master')


@section('title')
    Parental Generations
@endsection

@section('content')
    <ul>
        @if (!empty($generations))
            @include('custom_user.partials.parent_generation', ['generation' => $generations])
        @else
            <li>No parental generations found.</li>
        @endif
    </ul>
@endsection
