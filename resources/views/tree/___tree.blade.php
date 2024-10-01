@extends('layouts.admin')
@push('css')
    <style type="text/css">
        /*Now the CSS*/
        * {
            margin: 0;
            padding: 0;
        }

        .tree ul {
            padding-top: 20px;
            position: relative;

            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
        }

        .tree li {
            float: left;
            text-align: center;
            list-style-type: none;
            position: relative;
            padding: 20px 5px 0 5px;

            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
        }

        /*We will use ::before and ::after to draw the connectors*/

        .tree li::before,
        .tree li::after {
            content: '';
            position: absolute;
            top: 0;
            right: 50%;
            border-top: 1px solid #ccc;
            width: 50%;
            height: 20px;
        }

        .tree li::after {
            right: auto;
            left: 50%;
            border-left: 1px solid #ccc;
        }

        /*We need to remove left-right connectors from elements without
      any siblings*/
        .tree li:only-child::after,
        .tree li:only-child::before {
            display: none;
        }

        /*Remove space from the top of single children*/
        .tree li:only-child {
            padding-top: 0;
        }

        /*Remove left connector from first child and
      right connector from last child*/
        .tree li:first-child::before,
        .tree li:last-child::after {
            border: 0 none;
        }

        /*Adding back the vertical connector to the last nodes*/
        .tree li:last-child::before {
            border-right: 2px solid #ccc;
            border-radius: 0 5px 0 0;
            -webkit-border-radius: 0 5px 0 0;
            -moz-border-radius: 0 5px 0 0;
        }

        .tree li:first-child::after {
            border-radius: 5px 0 0 0;
            -webkit-border-radius: 5px 0 0 0;
            -moz-border-radius: 5px 0 0 0;
        }

        /*Time to add downward connectors from parents*/
        .tree ul ul::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            border-left: 2px solid #ccc;
            width: 0;
            height: 20px;
        }

        .tree li a {
            border: 2px solid #ccc;
            padding: 5px 5px;
            text-decoration: none;
            color: #666;
            font-family: arial, verdana, tahoma;
            font-size: 11px;
            display: inline-block;

            border-radius: 15px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;

            transition: all 0.5s;
            -webkit-transition: all 0.5s;
            -moz-transition: all 0.5s;
            width: 160px;
        }

        /*Time for some hover effects*/
        /*We will apply the hover effect the the lineage of the element also*/
        .tree li a:hover,
        .tree li a:hover+ul li a {
            background: #c8e4f8;
            color: #000;
            border: 2px solid #94a0b4;
        }

        /*Connector styles on hover*/
        .tree li a:hover+ul li::after,
        .tree li a:hover+ul li::before,
        .tree li a:hover+ul::before,
        .tree li a:hover+ul ul::before {
            border-color: #94a0b4;
        }
    </style>
@endpush
@section('content')
    <div class="tree" style="width:100%">
        <ul>
            <li style="width:100%">
                <a title=" " href="{{ route('childTree', $referGroupAdmin->id) }}">
                    @if (@$referGroupAdmin->image)
                        <img src="{{ asset($referGroupAdmin->image) }}" alt="Profile Image"
                            style="width: 50px; height: 50px; border-radius: 50%;">
                    @else
                        <img src="{{ asset('img/pro_pic.jpg') }}" alt="Profile"
                            style="width: 50px; height: 50px; border-radius: 50%;">
                    @endif
                    <span style="">{{ $referGroupAdmin->user_id }}</span>
                </a>
                <ul>

                    @foreach ($layers as $layer)
                        <li style="width:50%">
                            <!-- <a href="">{{ $layer->customer_name }}</a>  -->
                            <a 
                                href="{{ route('childTree', $layer->id) }}">
                                <!-- <img src="{{ asset($layer->image) }}" alt="Profile Image" class="profile-image"> -->
                                <!-- <img src="{{ asset('img/pro_pic.jpg') }}" alt="Profile Image" class="profile-image" style="width: 50px; height: 50px; border-radius: 50%;"> -->
                                @if (@$layer->image)
                                    <img src="{{ asset($layer->image) }}" alt="Profile Image"
                                        style="width: 50px; height: 50px; border-radius: 50%;">
                                @else
                                    <img src="{{ asset('img/pro_pic.jpg') }}" alt="Profile"
                                        style="width: 50px; height: 50px; border-radius: 50%;">
                                @endif
                                <span style="">{{ $layer->user_id }}</span>
                            </a>
                            <ul>
                                @php
                                    $layers2 = App\Models\CustomUser::where('user_ref_id', '=', $layer->id)->orderBy('placement_side', 'asc')->get();
                                @endphp
                                @if ($layers2)
                                    @foreach ($layers2 as $layer2)
                                        <li style="width:50%">
                                            <!-- <a href="">{{ $layer2->customer_name }}</a> -->
                                            <a title=""
                                                href="{{ route('childTree', $layer2->id) }}">
                                                <!-- <img src="{{ asset($layer2->image) }}" alt="Profile Image" class="profile-image"> -->
                                                <!-- <img src="{{ asset('img/pro_pic.jpg') }}" alt="Profile Image" class="profile-image" style="width: 50px; height: 50px; border-radius: 50%;"> -->
                                                @if ($layer2->image)
                                                    <img src="{{ asset($layer2->image) }}" alt="Profile Image"
                                                        style="width: 50px; height: 50px; border-radius: 50%;">
                                                @else
                                                    <img src="{{ asset('img/pro_pic.jpg') }}" alt="Profile"
                                                        style="width: 50px; height: 50px; border-radius: 50%;">
                                                @endif
                                                <span style="">{{ $layer2->user_id }} </span>
                                            </a>


                                        </li>
                                    @endforeach
                                @endif
                            </ul>
                        </li>
                    @endforeach
                </ul>
            </li>

        </ul>
    </div>
    {{-- <a href="{{ url('dashboard') }}" class="btn btn-primary">Go to Home</a> --}}
@endsection
@push('js')
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
        TotalPrice = document.getElementsByClassName('prices');

        function total_call() {
            let cal = 0;

            for (let i = 0; i < TotalPrice.length; i++) {
                parseFloat(cal += parseFloat(TotalPrice[i].innerText));
            }
            document.getElementById('span').innerHTML = cal.toFixed(3);
        }
        total_call();


        function saveParent(id) {
            var parent_id = $("#parent_id_" + id).val();
            var layer = $("#layer_" + id).val();
            $.ajax({
                url: "",
                method: "GET",
                data: {
                    "parent_id": parent_id,
                    "layer": layer,
                    "contact_id": id
                },
                datatype: "json",
                success: function(result) {
                    alert(JSON.stringify(result));
                },
                beforeSend: function() {
                    $('#loading').show();
                },
                complete: function() {
                    $('#loading').hide();
                },
                error: function(response) {
                    alert(JSON.stringify(resourse));
                }
            });

        }
    </script>
@endpush
