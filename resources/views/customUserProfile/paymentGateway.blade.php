@extends('layouts.admin')
@push('css')
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"
        integrity="sha512-vKMx8UnXk60zUwyUnUPM3HbQo8QfmNx7+ltw8Pm5zLusl1XIfwcxo8DbWCqMGKaWeNxWA8yrx5v3SaVpMvR3CA=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
@endpush
@section('content')
    <div class=" col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4><b>Payment Info's of {{ $user->customer_name }}</b></h4>
            </div>
            <div class="card-body">
                <form action="{{ route('custom.user.paymentGateway.update') }}" method="post">
                    @csrf

                    <div class="mb-3 border-bottom">
                        <h6><strong>MTF:</strong></h6>
                    </div>

                    <div class="row">

                        <div class="mb-3 col-md-6">
                            <label for="name">Bkash:</label>
                            <input type="text" name="bkash" value="{{ @$paymentGateway->bkash }}" placeholder="Bkash"
                                class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Nagad:</label>
                            <input type="text" name="nagad" value="{{ @$paymentGateway->nagad }}" placeholder="Nagad"
                                class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Rocket:</label>
                            <input type="text" name="rocket" value="{{ @$paymentGateway->rocket }}" placeholder="Rocket"
                                class="form-control">
                        </div>
                    </div>


                    <div class="mb-3 border-bottom">
                        <h6><strong>Bank info:</strong></h6>
                    </div>


                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <label for="name">Bank Name:</label>
                            <input type="text" name="b_name" value="{{ @$paymentGateway->b_name }}"
                                placeholder="Bank Name" class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Bank Branch:</label>
                            <input type="text" name="b_branch" value="{{ @$paymentGateway->b_branch }}"
                                placeholder="Bank Branch" class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Route Number:</label>
                            <input type="text" name="b_route" value="{{ @$paymentGateway->b_route }}"
                                placeholder="Routing Number" class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Swift Code:</label>
                            <input type="text" name="b_swift" value="{{ @$paymentGateway->b_swift }}"
                                placeholder="Swift Code" class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Account Name:</label>
                            <input type="text" name="b_account_name" value="{{ @$paymentGateway->b_account_name }}"
                                placeholder="Account Name" class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="name">Account Number:</label>
                            <input type="text" name="b_account" value="{{ @$paymentGateway->b_account }}"
                                placeholder="Account Number" class="form-control">
                        </div>
                        <div class="mb-3 col-md-6">
                            <button type="submit" class="btn btn-primary">Save Info</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>

    @push('js')
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"
            integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            @if (Session::has('success'))

                toastr.success("{{ Session::get('success') }}");
            @endif



            @if (Session::has('info'))

                toastr.info("{{ Session::get('info') }}");
            @endif



            @if (Session::has('warning'))

                toastr.warning("{{ Session::get('warning') }}");
            @endif



            @if (Session::has('error'))

                toastr.error("{{ Session::get('error') }}");
            @endif
        </script>
    @endpush
@endsection
