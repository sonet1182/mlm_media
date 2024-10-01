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
                    <th>Purchase Bonus</th>
                    <th>Creating Bonus</th>
                    <th>Rank Reward Bonus</th>
                    <th>Captainship Bonus</th>
                    <th>Guardianship Bonus</th>
                    <th>After Death Allowance</th>
                    <th>Company Profit Share</th>
                    <th>Stockiest Bonus</th>
                    <th>Stockiest Refer Bonus</th>
                    <th>Depo Bonus</th>
                    <th>Company Fund</th>
                    <th>Re-Creating Bonus 1st</th>


                    <th>Total</th>

                </tr>
                @foreach ($rp_redeemed as $rp_rd)
                <tr>
                    <td>{{ $rp_rd->users->customer_name }}</td>
                    @foreach ($rp_rd->beneficiary as $beneficiary)
                        @if ($beneficiary->beneficiary_type == 'Purchase Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Creating Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Rank Reward Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Captainship Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'After Death Allowance')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Company Profit Share')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Stockiest Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Stockiest Refer Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Depo Bonus')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Company Fun')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Re-Creating Bonus 1st')
                            <td>{{ $beneficiary->amount }}</td>
                        @endif
                    @endforeach
                    {{-- <td>{{ $rp_rd->beneficiary }}</td> --}}
                    {{-- <td>{{ $rp_rd->beneficiary }}</td> --}}



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

