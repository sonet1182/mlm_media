@extends('layouts.admin')
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

</style>


@endpush
@section('content')
<div class="col-lg-12">
  <div class="card">
    <div class="card-header"><h4>Stockiest REGISTRATION </h4></div>
    <div class="card-body">
        <form action="{{ route('stockiest.user.add.post') }}" method="post">
            @csrf
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockist Name:</label>
                            <input type="text" name="stockiest_name" id="" class="form-control" placeholder="Enter Stockiest Name">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Contact Person Name:</label>
                            <input type="text" name="stockiest_contact_person_name" id="" class="form-control" placeholder="Enter Stockiest Contract Name">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Contact Number:</label>
                            <input type="text" name="contact_number" id="" class="form-control" placeholder="Enter Stockiest Contact Number">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Email ID:</label>
                            <input type="email" name="stockiest_email" id="" class="form-control" placeholder="Enter Stockiest Email">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Address:</label>
                            <input type="text" name="stockiest_address" id="" class="form-control" placeholder="Enter Stockiest Address">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Depo Id:</label>
                            <select name="depo_id" id="depo_id" class="form-control">
                                @foreach (App\Models\Depo::all() as $depo)
                                <option value="{{ $depo->depo_user_id }}">
                                    {{ $depo->depo_user_id }}
                                </option>

                                @endforeach
                            </select>

                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Arya:</label>
                            <input type="text" name="stockiest_arya" id="" class="form-control" placeholder="Enter Stockiest Arya">
                        </div>
                    </div>
                    {{--  <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest User ID:</label>
                           <select name="stockiest_user_id" id="" class="form-control">
                            <option value="1">1</option>
                           </select>
                        </div>
                    </div>  --}}
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest  User Password:</label>
                            <input type="password" name="stockiest_password" id="" class="form-control" placeholder="Enter Stockiest Password">
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="name" class="form-label">Stockiest Ref ID: Optional [Depo ID/Stockiest ID/User ID]:</label>
                            <input type="text" name="stockiest_ref" id="" class="form-control" placeholder="Enter Stockiest Refference Id">
                        </div>
                    </div>


                </div>
                <div class="col-lg-6">
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">Add Stockiest</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
  </div>
</div>
@push('js')
<script src="sweetalert2.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
@if(session('success'))
<script>
    Swal.fire({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!"
      }).then((result) => {
        if (result.isConfirmed) {
          Swal.fire({
            title: "Deleted!",
            text: "Your file has been deleted.",
            icon: "success"
          });
        }
      });
</script>
<script>


    @if(Session::has('success'))
            toastr.success("{{ Session::get('success') }}");
    @endif








  </script>


@endif
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js" integrity="sha512-2ImtlRlf2VVmiGZsjm9bEyhjGW4dU7B6TNwh/hx/iSByxNENtj3WVE6o/9Lj4TJeVXPi4bnOIMXFIJJAeufa0A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>

    $(document).ready(function() {
        $('#depo_id').select2();
    });
</script>

@endpush

@endsection
