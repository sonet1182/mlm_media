@extends('layouts.admin')

@section('title')
    Withdrawal
@endsection

@section('content')
    <main id="main" class="main col-sm-12">

        <div class="pagetitle">
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="{{ url('/dashboard') }}">Home</a></li>
                    <li class="breadcrumb-item">Users</li>
                    <li class="breadcrumb-item active">Withdrawal</li>
                </ol>
            </nav>
        </div>

        <section class="section profile">
            <div class="row">
                <div class="col-xl-12">
                    <div class="card">
                        <div class="row py-3">
                            <div class="col-md-6">
                                <h4 class="text-center">
                                    Current Balance: <span style="font-weight: 600;"> {{ number_format($balance, 2) }} BDT
                                    </span>
                                </h4>
                            </div>
                            <div class="col-md-6">
                                <h4 class="text-center">
                                    Available Balance: <span style="font-weight: 600;">
                                        {{ number_format($available_balance, 2) }} BDT
                                    </span>
                                </h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body pt-3">
                    <div class="pt-2">
                        @if (session('success'))
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                {{ session('success') }}
                            </div>
                        @endif

                        @if ($errors->any())
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <ul class="mb-0">
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif

                        <div class="" id="head_office">
                            <h4 class="my-2">Withdrawal Request</h4>

                            <form method="POST" action="{{ route('withdraw.store') }}">
                                @csrf
                                <div class="col-md-12">
                                    <div class="form-row my-5">
                                        <!-- Gateway Radio Buttons -->
                                        <div class="form-check">
                                            <input type="radio" id="bkash" name="gateway" value="bkash" checked>
                                            <label for="bkash">
                                                <img src="{{ asset('img/bkash.png') }}" alt="bkash"
                                                    style="width: 50px; height: 50px;">
                                                Bkash
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input type="radio" id="nagad" name="gateway" value="nagad">
                                            <label for="nagad">
                                                <img src="{{ asset('img/nagad.png') }}" alt="nagad"
                                                    style="width: 50px; height: 50px;">
                                                Nagad
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input type="radio" id="rocket" name="gateway" value="rocket">
                                            <label for="rocket">
                                                <img src="{{ asset('img/rocket.png') }}" alt="rocket"
                                                    style="width: 50px; height: 50px;">
                                                Rocket
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input type="radio" id="dbbl" name="gateway" value="dbbl">
                                            <label for="dbbl">
                                                <img src="{{ asset('img/DBBL-Logo.png') }}" alt="dbbl"
                                                    style="width: 50px; height: 50px;">
                                                Dutch Bangla Bank
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-8 col-lg-9">
                                    <div>
                                        <!-- Request To Dropdown -->
                                        <div class="row mb-3">
                                            <label for="acName" class="col-md-4 col-lg-3 col-form-label">Request
                                                To</label>
                                            <div class="col-md-8 col-lg-9">
                                                <select class="form-control" name="request_to" id="request_to">
                                                    <option value="admin">Head Office</option>
                                                    <option value="stockiest">Stockiest</option>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Stockiest Dropdown -->

                                        <div id="stockiest_row" style="display: none;">

                                            <div class="row mb-3">
                                                <label for="acName" class="col-md-4 col-lg-3 col-form-label">Select
                                                    Stockiest</label>
                                                <div class="col-md-8 col-lg-9">
                                                    <select class="form-control" name="stockiest_id" id="stockiest_select">
                                                        <option value="">Select One</option>
                                                        @foreach ($stockiest as $sto)
                                                            <option value="{{ $sto->id }}"
                                                                data-name="{{ $sto->stockiest_name }}"
                                                                data-contact="{{ $sto->contact_number }}"
                                                                data-arya="{{ $sto->stockiest_arya }}">
                                                                {{ $sto->stockiest_user_id }}
                                                            </option>
                                                        @endforeach
                                                    </select>

                                                    <!-- Stockiest Details (Name and Contact) -->
                                                    <div class="" id="stockiest_details" style="display: none;">
                                                        <label for="stockiest_info"
                                                            class="col-md-4 col-lg-3 col-form-label">Stockiest Info</label>


                                                        <table class="table table-bordered table-striped">
                                                            <tbody>
                                                                <tr>
                                                                    <th scope="row">Name</th>
                                                                    <td>
                                                                        <span id="stockiest_name"></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th scope="row">Contact</th>
                                                                    <td>
                                                                        <span id="stockiest_contact"></span>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <th scope="row">Adress</th>
                                                                    <td>
                                                                        <span id="stockiest_arya"></span>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row mb-3">
                                            <label for="acName" class="col-md-4 col-lg-3 col-form-label">Amount</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="amount" type="text" class="form-control" id="acName"
                                                    max="{{ $available_balance }}" min="1"
                                                    value="{{ old('amount') }}">
                                            </div>
                                        </div>
                                    </div>

                                    <div id="mobile-fields">
                                        <div class="row mb-3">
                                            <label for="account_no" class="col-md-4 col-lg-3 col-form-label">Account
                                                No</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="account_no" type="text" class="form-control"
                                                    id="account_no" value="{{ old('account_no') ?? $gateway->bkash }}">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Additional fields for Dutch Bangla Bank -->
                                    <div id="dbbl-fields" style="display: none;">
                                        <div class="row mb-3">
                                            <label for="account_name" class="col-md-4 col-lg-3 col-form-label">Account
                                                Name</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="account_name" type="text" class="form-control"
                                                    id="account_name"
                                                    value="{{ old('account_name') ?? $gateway->b_account_name }}">
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label for="bank_name" class="col-md-4 col-lg-3 col-form-label">Bank
                                                Name</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="bank_name" type="text" class="form-control"
                                                    id="bank_name" value="{{ $gateway->b_name }}">
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label for="bank_branch" class="col-md-4 col-lg-3 col-form-label">Bank
                                                Branch</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="bank_branch" type="text" class="form-control"
                                                    id="bank_branch" value="{{ $gateway->b_branch }}">
                                            </div>
                                        </div>

                                        <div class="row mb-3">
                                            <label for="routing_no" class="col-md-4 col-lg-3 col-form-label">Routing
                                                No</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="routing_no" type="text" class="form-control"
                                                    id="routing_no" value="{{ $gateway->b_route }}">
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <label for="swift_code" class="col-md-4 col-lg-3 col-form-label">SWIFT
                                                Code</label>
                                            <div class="col-md-8 col-lg-9">
                                                <input name="swift_code" type="text" class="form-control"
                                                    id="swift_code" value="{{ $gateway->b_swift }}">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary">Request</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
@endsection

@push('js')
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const gatewayRadios = document.querySelectorAll('input[name="gateway"]');
            const dbblFields = document.getElementById('dbbl-fields');
            const mobileFields = document.getElementById('mobile-fields');
            const requestToSelect = document.getElementById('request_to');
            const stockiestRow = document.getElementById('stockiest_row');

            const stockiestSelect = document.getElementById('stockiest_select');
            const stockiestDetails = document.getElementById('stockiest_details');
            const stockiestName = document.getElementById('stockiest_name');
            const stockiestContact = document.getElementById('stockiest_contact');
            const stockiestArya = document.getElementById('stockiest_arya');

            gatewayRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    if (this.value === 'dbbl') {
                        dbblFields.style.display = 'block';
                    } else {
                        dbblFields.style.display = 'none';
                    }
                });
            });

            requestToSelect.addEventListener('change', function() {
                if (this.value === 'stockiest') {
                    stockiestRow.style.display = 'block';
                } else {
                    stockiestRow.style.display = 'none';
                }
            });

            stockiestSelect.addEventListener('change', function() {
                const selectedOption = stockiestSelect.options[stockiestSelect.selectedIndex];
                const name = selectedOption.getAttribute('data-name');
                const contact = selectedOption.getAttribute('data-contact');
                const arya = selectedOption.getAttribute('data-arya');

                if (name && contact) {
                    stockiestDetails.style.display = 'block';
                    stockiestName.textContent = `${name}`;
                    stockiestContact.textContent = `${contact}`;
                    stockiestArya.textContent = `${arya}`;
                } else {
                    stockiestDetails.style.display = 'none';
                }
            });


            const bkash = '{{ $gateway->bkash }}';
            const nagad = '{{ $gateway->nagad }}'; // Fixed typo here
            const rocket = '{{ $gateway->rocket }}'; // Fixed typo here
            const b_account = '{{ $gateway->b_account }}';


            const accountInput = document.getElementById('account_no');

            gatewayRadios.forEach(radio => {
                radio.addEventListener('change', function() {
                    if (this.value === 'bkash') {
                        accountInput.value = bkash;
                    } else if (this.value === 'nagad') {
                        accountInput.value = nagad;
                    } else if (this.value === 'rocket') {
                        accountInput.value = rocket;
                    } else if (this.value === 'dbbl') {
                        accountInput.value = b_account;
                    }
                });
            });


        });
    </script>
@endpush
