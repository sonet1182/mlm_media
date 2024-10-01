@extends('dashboard.stockiest_master')

<style>
    .card-headers {
        position: relative;
        width: 100%;
    }

    .add_customer {
        position: absolute;
        right: -3.5%;
        top: 50%;
        transform: translate(-50%, -50%);
    }
</style>


@section('title')
    User
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Direct List</h4>
                </div>
            </div>


            <div class="card-body">

                @if (session('status'))
                    <div class="alert alert-success">
                        {{ session('status') }}
                    </div>
                @endif

                <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Searial</th>
                                <th>customer Name</th>
                                <th>Contact</th>
                                <th>customer Address</th>
                                <th>Stockiest Id</th>
                                <th>customer User Id</th>
                                <th>Ref Id</th>
                                <th>Place Id</th>
                                <th>Placement Side</th>
                                <th>IP Active</th>
                                <th style="width: 180px">Referral Info</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach ($customers as $i => $customer)
                                @php
                                    $placeUser = \App\Models\CustomUser::where('id', $customer->place_user_id)->first();
                                    $stockiest = \App\Models\Stockiest::where('id', $customer->stockiest_id)->first();
                                @endphp
                                <tr>
                                    <td>{{ $i + 1 }}</td>
                                    <td>{{ $customer->customer_name }}</td>
                                    <td>
                                        Phone: {{ $customer->customer_contact_number }} <br>
                                        Email: {{ $customer->customer_email }}
                                    </td>
                                    <td>{{ $customer->customer_address }}</td>
                                    <td>{{ $stockiest ? $stockiest->stockiest_user_id : '' }}</td>
                                    <td>{{ $customer->user_id }} </td>
                                    <td>{{ $customer->referredBy ? $customer->referredBy->user_id : '' }}</td>
                                    <td>{{ $placeUser ? $placeUser->user_id : '' }}</td>
                                    <td>{{ $customer->placement_side }}</td>
                                    <td>{{ $customer->is_IpActive ? 'Active' : 'Inactive' }}</td>
                                    <td>
                                        <a href="{{ route('stockiest.refer_info_parental_data', $customer->id) }}"
                                            class="btn btn-sm btn-primary"><i class="fa fa-eye"></i> Show Direct List</a>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

    @push('js')
        <script>
    $(function() {
        $("#example1").DataTable({
            "order": [],
            "responsive": false,
            "lengthChange": true,
            "autoWidth": true,
            "buttons": [{
                    extend: 'csv',
                },
                {
                    extend: 'excel',
                },
                'colvis'
            ]
        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
    });
</script>

        <script>
            $(document).ready(function() {


                $('.plus').click(function() {
                    var parentTR = $(this).closest('tr');
                    var $this = $(this)
                    var id = $(this).data('id');
                    console.log(id);
                    var url = "{{ route('user.child', ':id') }}";

                    $.ajax({
                        url: url.replace(':id', id),
                        type: "GET",
                        success: function(data) {
                            console.log(data.data);
                            // data
                            $this.prop('disabled', true)
                            if (data.data.length > 0) {
                                data.data.map((item) => {
                                    console.log(item);
                                    parentTR.after(
                                        '<tr style="background:#ccc">' +
                                        '<td>' + item.customer_name + '</td>' +
                                        '<td>' + item.customer_contact_number +
                                        '</td>' +
                                        ' <td>' + item.customer_email + '</td>' +
                                        ' <td>' + item.customer_address + '</td>' +
                                        '<td>' + item.stockiest_id + '</td>' +
                                        '<td>' + item.user_id + '</td>' +
                                        '<td>' + item.user_ref_id + '</td>' +
                                        '<td>' + item.place_user_id + '</td>' +
                                        '<td>' + item.placement_side + '</td>' +
                                        '<td></td>'

                                        +
                                        '</tr>'
                                    );
                                })
                            } else {
                                parentTR.after(
                                    '<tr>' +
                                    '<td colspan="9" style="background:#ccc;text-align:center">No Data Found</td>' +
                                    '</tr>'
                                );
                            }

                        }
                    });

                })
            })
        </script>
    @endpush
@endsection
