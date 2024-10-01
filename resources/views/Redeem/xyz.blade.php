@extends('dashboard.admin_master')
@push('css')
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
@section('admin')
<div class="col-lg-7 mx-auto">
    <div class="card">
        <div class="card-header">
            <h5> Redeem point</h5>
        </div>
        <div class="card-body">
            <form action="{{ route('transaction.action') }}" method="Get">
                @csrf
                @if (session('transaction'))
                <div class="alert alert-danger">{{ session('transaction') }}</div>

                @endif
                @if (session('transactions'))
                <div class="alert alert-info">{{ session('transactions') }}</div>

                @endif
                <div class="mb-3">
                    <label for="name">Select Customer Name:</label>
                    <select name="customer_id" id="customer_name" class="form-control">
                        @foreach (App\Models\CustomUser::all() as $user)
                        <option value="{{$user->id}}">{{ $user->customer_name }} &NonBreakingSpace; {{ $user->user_id }}</option>

                        @endforeach
                    </select>
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">
                        Invoice:
                    </label>
                    <input type="text" class="form-control" name="invoice_no" id="" placeholder="Enter Your invoice">
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">
                        Total Amount:
                    </label>
                    <input type="number" class="form-control" name="total_before_tax" id="" placeholder="Enter Your Amount">
                </div>
                <div class="mb-3">
                    <label for="" class="form-label">
                        Point:
                    </label>
                    <input type="text" class="form-control" name="rp_redeemed_amount" id="" placeholder="Enter Your point">
                </div>
                <div class="mb-3">
                    <button type="submit" class="btn btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>

@push('js')

<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js" integrity="sha512-2ImtlRlf2VVmiGZsjm9bEyhjGW4dU7B6TNwh/hx/iSByxNENtj3WVE6o/9Lj4TJeVXPi4bnOIMXFIJJAeufa0A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    $(document).ready(function() {
        $('#customer_name').select2();
    });
    $(document).ready(function() {
        $('#stockiest_id').select2();
    });
    $(document).ready(function() {
        $('#user_ref_id').select2();
    });
</script>




@endpush

@endsection
