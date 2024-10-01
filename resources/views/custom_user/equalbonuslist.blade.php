@extends('dashboard.admin_master')

<style>
    .card-headers{
        position: relative;
        width: 100%;
    }
    .add_customer{
        position: absolute;
        right: -3.5%;
        top: 50%;
        transform: translate(-50%,-50%);



    }

</style>


@section('admin')
<div class="col-lg-12 col-12 col-md-12 col-sm-12">
    <div class="card">
        <div class="card-header card-headers" style="">
            <div style="">
                <h4>Equal Bonus List</h4>
            </div>


        </div>
        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>customer Name</th>

                    <th>L1 A</th>
                    <th>L1 B</th>
                    <th>L2 A</th>
                    <th>L2 B</th>
                    <th>L3 A</th>
                    <th>L3 B</th>
                    <th>L4 A</th>
                    <th>L4 B</th>
                    <th>L5 A</th>
                    <th>L5 B</th>


                    <th>Total</th>

                </tr>
                @foreach ($equalBonus as $customer)
                <tr>
                    <td>{{ $customer->users->customer_name }}</td>
                    <td>{{ $customer->l1a }}</td>
                    <td>{{ $customer->l1b }}</td>
                    <td>{{ $customer->l2a }}</td>
                    <td>{{ $customer->l2b }}</td>
                    <td>{{ $customer->l3a }}</td>
                    <td>{{ $customer->l3b }}</td>
                    <td>{{ $customer->l4a }}</td>
                    <td>{{ $customer->l4b }}</td>
                    <td>{{ $customer->l5a }}</td>
                    <td>{{ $customer->l5b }}</td>
                    <td>{{ $customer->total }}</td>


                </tr>

                @endforeach
            </table>
        </div>
    </div>

</div>

@push('js')

    <script>
        $(document).ready(function(){
            $('.plus').click(function(){
                var parentTR = $(this).closest('tr');
                var $this=$(this)
                var id = $(this).data('id');
                console.log(id);
                var url = "{{ route('user.child', ":id") }}";

                $.ajax({
                    url: url.replace(':id', id),
                    type: "GET",
                    success: function(data){
                        console.log(data.data);
                        // data
                        $this.prop('disabled', true)
                        if(data.data.length>0){
                        data.data.map((item)=>{
                            console.log(item);
                            parentTR.after(
                                '<tr style="background:#ccc">'
                                   + '<td>'+ item.customer_name +'</td>'
                                   + '<td>'+ item.customer_contact_number +'</td>'
                                   + ' <td>'+ item.customer_email +'</td>'
                                   + ' <td>'+ item.customer_address +'</td>'
                                   + '<td>'+ item.stockiest_id +'</td>'
                                   + '<td>'+ item.user_id +'</td>'
                                   + '<td>'+ item.user_ref_id +'</td>'
                                   + '<td>'+ item.place_user_id +'</td>'
                                   + '<td>'+ item.placement_side +'</td>'
                                   + '<td></td>'

                                   + '</tr>'
                            );
                        })
                    }else{
                        parentTR.after(
                                '<tr>'
                                   + '<td colspan="9" style="background:#ccc;text-align:center">No Data Found</td>'
                                   + '</tr>'
                            );
                    }

                    }
                });

            })
        })
    </script>
@endpush

@endsection

