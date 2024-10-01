@extends('layouts.admin')

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
    ul {
        list-style: none
    }

    li {
        border-bottom: 1px solid;
        padding-bottom: 3px;
        padding-top: 3px;
    }
    li label {
        width: 150px;
        margin-bottom: 9px;
    }
</style>


@section('content')
<div class="col-lg-12 col-12 col-md-12 col-sm-12">
    <div class="card">
        <div class="card-header card-headers" style="">
            <div style="">
                <h4>Equal Bonus List</h4>
            </div>


        </div>
        <div class="card-body">
            <ul>
                @php
                    $total_bonus =0;
                @endphp
                @foreach ($rp_redeemed as $rp_rd)
                <tr>
                    <li><label for="">Customer Name: </label>{{ $rp_rd->users->customer_name }}</li>
                    @foreach ($rp_rd->beneficiary as $beneficiary)
                        @if ($beneficiary->beneficiary_type == 'Purchase Bonus')
                            <li><label for="">Purchase Bonus: </label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Creating Bonus')
                            <li><label for="">Creating Bonus</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Rank Reward Bonus')
                            <li><label for="">Rank Reward Bonus</label>{{ $beneficiary->amount }}</li>
                        @endif

                        @if ($beneficiary->beneficiary_type == 'After Death Allowance')
                            <li><label for="">After Death Allowance</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Company Profit Share')
                            <li><label for="">Company Profit Share</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Stockiest Bonus')
                            <li><label for="">Stockiest Bonus</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Stockiest Refer Bonus')
                            <li><label for="">Stockiest Refer Bonus</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Depo Bonus')
                            <li><label for="">Depo Bonush</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Company Fun')
                            <li><label for="">Company Fun</label>{{ $beneficiary->amount }}</li>
                        @endif
                        @if ($beneficiary->beneficiary_type == 'Re-Creating Bonus 1st')
                            <li><label for="">Re-Creating Bonus 1st</label>{{ $beneficiary->amount }}</li>
                        @endif
                    @endforeach
                    {{-- <td>{{ $rp_rd->beneficiary }}</td> --}}
                    {{-- <td>{{ $rp_rd->beneficiary }}</td> --}}




                @endforeach
            </ul>
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

