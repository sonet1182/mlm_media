@extends('dashboard.stockiest_master')
@push('css')

<link rel="stylesheet" href="sweetalert2.min.css">


@endpush
@push('css')
<link rel="stylesheet" href="sweetalert2.min.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" integrity="sha512-nMNlpuaDPrqlEls3IX/Q56H36qvBASwb3ipuo3MxeWbsQB1881ox0cRv7UPTgBlriqoynt35KjEwgGUeUXIPnw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
        box-sizing:border-box;
        cursor:pointer;
        display:block;
        height: 8% !important;

        user-select:none;
        -webkit-user-select:none
      }
      .select2-container--default .select2-selection--single {

        border: 1px solid #ced4da !important;
        border-radius: 4px;
      }
      .form-control:disabled, .form-control[readonly] {
        background-color:transparent !important;
        opacity: 1;
      }

</style>


@endpush

@section('content')
<div class="col-lg-12">
  <div class="card">
    <div class="card-header"><h4>USER REGISTRATION </h4></div>
    <div class="card-body">
        <form action="{{ route('stockiest.custom.add.post') }}" method="post">
            @csrf
            <div class="container">
                <div class="row">

                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Customer Name:</label>
                            <input type="text" name="customer_name" id="" class="form-control" placeholder="Enter Customer Name">
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Customer Contact Number:</label>
                            <input type="text" name="customer_contact_number" id="" class="form-control" placeholder="Enter Customer Contact Number">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Customer Email ID:</label>
                            <input type="email" name="customer_email" id="" class="form-control" placeholder="Enter Customer Email">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Customer Address:</label>
                            <input type="text" name="customer_address" id="" class="form-control" placeholder="Enter Stockiest Address">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Id:</label>
                            <select name="stockiest_id" id="stockiest_id" class="form-control" >
                                @foreach (App\Models\Stockiest::all() as $stockiest)
                                <option value="{{ $stockiest->stockiest_user_id }}">{{ $stockiest->stockiest_user_id }}</option>

                                @endforeach

                            </select>

                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label"> User Ref ID:</label>
                            <select name="user_ref_id" id="user_ref_id"  class="form-control " >
                                @foreach (App\Models\CustomUser::all() as $custom)
                                <option  value="{{ $custom->user_id }}">{{ $custom->user_id }}</option>

                                @endforeach

                            </select>

                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label"> Placement User ID:</label>
                            <select name="place_user_id" id="place_user_id"  class="form-control " >
                                @foreach (App\Models\CustomUser::all() as $custom)
                                <option  value="{{ $custom->user_id }}">{{ $custom->user_id }}</option>

                                @endforeach

                            </select>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label"> Placement Side:</label>
                            <select name="place_side" id="" class="form-control">
                                <option value="A">
                                    A
                                </option>
                                <option value="B">B</option>
                            </select>

                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">  User Password:</label>
                            <input type="password" name="user_password" id="" class="form-control" placeholder="Enter User Password">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">User ID:</label>

                            <input type="text" name="user_id" id="" class="form-control " disabled aria-label="Disabled select example" disabled placeholder="Enter User Id"  value="{{ App\Models\CustomUser::latest('created_at')->first()->user_id  }}">
                        </div>
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
<script src="sweetalert2.min.js"></script>
@if(Session::has('add_customer'))
<script>
    Swal.fire({
        position: "top-end",
        icon: "success",
        title: "Your work has been saved",
        showConfirmButton: false,
        timer: 1500
      });
</script>

@endif

@endpush
@push('js')
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js" integrity="sha512-2ImtlRlf2VVmiGZsjm9bEyhjGW4dU7B6TNwh/hx/iSByxNENtj3WVE6o/9Lj4TJeVXPi4bnOIMXFIJJAeufa0A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    $(document).ready(function() {
        $('#place_user_id').select2();
    });
    $(document).ready(function() {
        $('#stockiest_id').select2();
    });
    $(document).ready(function() {
        $('#user_ref_id').select2();
    });
</script>



@endpush
