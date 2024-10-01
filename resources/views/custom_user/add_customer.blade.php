@extends('layouts.admin')


@push('css')
    <link rel="stylesheet" href="sweetalert2.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css"
        integrity="sha512-nMNlpuaDPrqlEls3IX/Q56H36qvBASwb3ipuo3MxeWbsQB1881ox0cRv7UPTgBlriqoynt35KjEwgGUeUXIPnw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .select2-container--default .select2-selection--single .select2-selection__rendered {
            color: #444;
            line-height: 24px;
        }

        .select2-container .select2-selection--single .select2-selection__rendered {
            display: block;
            padding-left: 8px;
            padding-right: 20px;

            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .select2-container .select2-selection--single {
            box-sizing: border-box;
            cursor: pointer;
            display: block;
            height: 8% !important;

            user-select: none;
            -webkit-user-select: none
        }

        .select2-container--default .select2-selection--single {

            border: 1px solid #ced4da !important;
            border-radius: 4px;
        }

        .form-control:disabled,
        .form-control[readonly] {
            background-color: transparent !important;
            opacity: 1;
        }
    </style>
@endpush

@section('content')
    <div class="col-lg-12">
        <div class="card">
            <div class="card-header">
                <h4>USER REGISTRATION </h4>
            </div>
            <div class="card-body">
                @if ($errors->any())
                    <div class="alert alert-danger">
                        <ul class="mb-0">
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif
                <form action="{{ route('user.post') }}" method="post">
                    @csrf
                    <div class="container">
                        <div class="row">

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Customer Name:</label>
                                    <input type="text" name="customer_name" value="{{ old('customer_name') }}"
                                        id="" class="form-control" placeholder="Enter Customer Name">
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Customer Contact Number:</label>
                                    <input type="text" name="customer_contact_number"
                                        value="{{ old('customer_contact_number') }}" id="" class="form-control"
                                        placeholder="Enter Customer Contact Number">

                                    @if ($errors->has('customer_contact_number'))
                                        <div class="error">{{ $errors->first('customer_contact_number') }}</div>
                                    @endif
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Customer Email ID:</label>
                                    <input type="email" name="customer_email" value="{{ old('customer_email') }}"
                                        id="" class="form-control" placeholder="Enter Customer Email">
                                    @if ($errors->has('customer_email'))
                                        <div class="error">{{ $errors->first('customer_email') }}</div>
                                    @endif
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Customer Address:</label>
                                    <input type="text" name="customer_address" value="{{ old('customer_address') }}"
                                        id="" class="form-control" placeholder="Enter Stockiest Address">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Stockiest Id:</label>
                                    <select name="stockiest_id" id="stockiest_id" class="form-control">
                                        @foreach (App\Models\Stockiest::all() as $stockiest)
                                            <option value="{{ $stockiest->id }}" @selected(old('stockiest_id') == $stockiest->id)>
                                                {{ $stockiest->stockiest_user_id }}</option>
                                        @endforeach

                                    </select>

                                </div>
                            </div>

                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label"> User Ref ID:</label>
                                    <select name="user_ref_id" id="user_ref_id" class="form-control ">
                                        @foreach (App\Models\CustomUser::all() as $custom)
                                            <option value="{{ $custom->id }}" @selected(old('user_ref_id') == $custom->user_ref_id)>
                                                {{ $custom->user_id }}</option>
                                        @endforeach

                                    </select>

                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label"> Placement User ID:</label>
                                    <select name="place_user_id" value="{{ old('place_user_id') }}" id="place_user_id"
                                        class="form-control ">
                                        @foreach (App\Models\CustomUser::all() as $custom)
                                            <option value="{{ $custom->id }}" @selected(old('place_user_id') == $custom->id)>
                                                {{ $custom->user_id }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label"> Placement Side:</label>
                                    <select name="place_side" value="{{ old('place_side') }}" id=""
                                        class="form-control">
                                        <option value="A" @selected(old('place_side') == 'A')>
                                            A
                                        </option>
                                        <option value="B" @selected(old('place_side') == 'B')>B</option>
                                    </select>

                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label"> User Password:</label>
                                    <input type="password" name="user_password" value="{{ old('user_password') }}"
                                        id="" class="form-control" placeholder="Enter User Password">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label for="name" class="form-label">User ID:</label>
                                    <input type="text" name="user_id" class="form-control" readonly
                                        value="{{ $user_id }}">
                                </div>
                                <div class="col-lg-6">
                                    <div class="mb-3">
                                        <button type="submit" class="btn btn-primary">Add User</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                </form>
            </div>
        </div>
    </div>
@endsection




@push('js')
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"
        integrity="sha512-2ImtlRlf2VVmiGZsjm9bEyhjGW4dU7B6TNwh/hx/iSByxNENtj3WVE6o/9Lj4TJeVXPi4bnOIMXFIJJAeufa0A=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
        $(document).ready(function() {
            $('#place_user_id').select2();
        });
        $(document).ready(function() {
            $('#stockiest_id').select2();
        });
        $(document).ready(function() {
            $('#user_ref_id').select2();

            $("#place_user_id").change(function() {
                $("#place_side option:nth-child(2)").removeAttr('disabled');
                $("#place_side option:last-child").removeAttr('disabled');
                var place_user_id = $(this).val();
                var url = "{{ route('checkPlacement', ':id') }}";
                $.ajax({
                    url: url.replace(':id', place_user_id),
                    type: "get",
                    success: function(data) {
                        console.log('object', data)

                        data.data.map((item) => {
                            console.log(item)
                            if (item.placement_side == "A") {
                                $("#place_side option:nth-child(2)").prop('disabled',
                                    true);
                            }
                            if (item.placement_side == "B") {
                                $("#place_side option:last-child").prop('disabled',
                                    true);
                            }
                        })
                    }
                });
            });

        });
    </script>
    <script>
        @if (Session::has('success'))
            toastr.success("{{ Session::get('success') }}");
        @endif
    </script>
@endpush
