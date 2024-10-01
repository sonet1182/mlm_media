@extends('layouts.admin')


<style>
    .card-headers{
        position: relative;
        width: 100%;
    }
    .add_depo{
        position: absolute;
        right: -2%;
        top: 50%;
        transform: translate(-50%,-50%);



    }

</style>


@section('content')
<div class="col-lg-12 col-12 col-md-12 col-sm-12">
    <div class="card">
        <div class="card-header card-headers" style="">
            <div style="">
                <h4>Depo List</h4>
            </div>
            <div style="" class="add_depo">
                <a href="{{ route('depo.depo.register.user') }}" class="btn btn-primary">Add Depo</a>
            </div>

        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>Depo Name</th>
                    <th>Contact Person Name</th>
                    <th>Contact Number</th>
                    <th>Depo Email</th>
                    <th>Depo Address</th>
                    <th>Depo Area</th>
                    <th>Depo User Id</th>
                    <th>Action</th>
                </tr>
                @foreach ($depos as $depo)
                <tr>
                    <td>{{ $depo->depo_name }}</td>
                    <td>{{ $depo->contact_person_name }}</td>
                    <td>{{ $depo->contact_number }}</td>
                    <td>{{ $depo->depo_email_id }}</td>
                    <td>{{ $depo->depo_address }}</td>
                    <td>{{ $depo->depo_arya }}</td>
                    <td>{{ $depo->depo_user_id }}</td>
                   <td>
                    <div class="d-flex justify-content-between" >
                        <button data-link="{{ route('depo.depo.list.user.remove',$depo->depo_user_id)}}" class="shadow btn btn-danger btn-xs sharp del_btn"><i class="fa fa-trash"></i></button>&NonBreakingSpace;  <a href="{{ route('depo.depo.list.user.edit',$depo->depo_user_id)}}" class="shadow btn btn-primary btn-xs sharp"><i class="fa fa-edit"></i></a> &NonBreakingSpace; <a href="{{ route('depo.depo.list.user.view',$depo->depo_user_id)}}" class="shadow btn btn-success btn-xs sharp"><i class="fa fa-eye"></i></a>
                    </div>
                   </td>
                </tr>

                @endforeach
            </table>
        </div>
    </div>

</div>
@push('js')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

    $('.del_btn').click(function(){
        var link=$(this).attr('data-link');
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
             window.location.href=link
            }
          });
    })
</script>









@endpush





@endsection
