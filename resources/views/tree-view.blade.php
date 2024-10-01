@extends('dashboard.admin_master')

@push('css')
    <style>
        /*----------------genealogy-scroll----------*/
        .genealogy-scroll::-webkit-scrollbar {
            width: 5px;
            height: 8px;
        }

        .genealogy-scroll::-webkit-scrollbar-track {
            border-radius: 10px;
            background-color: #e4e4e4;
        }

        .genealogy-scroll::-webkit-scrollbar-thumb {
            background: #212121;
            border-radius: 10px;
            transition: 0.5s;
        }

        .genealogy-scroll::-webkit-scrollbar-thumb:hover {
            background: #d5b14c;
            transition: 0.5s;
        }


        /*----------------genealogy-tree----------*/
        .genealogy-body {
            white-space: nowrap;
            overflow-y: hidden;
            padding: 50px;
            min-height: 500px;
            padding-top: 10px;
            text-align: center;
        }

        .genealogy-tree {
            display: inline-block;
        }

        .genealogy-tree ul {
            padding-top: 20px;
            position: relative;
            padding-left: 0px;
            display: flex;
            justify-content: center;
        }

        .genealogy-tree li {
            float: left;
            text-align: center;
            list-style-type: none;
            position: relative;
            padding: 20px 5px 0 5px;
        }

        .genealogy-tree li::before,
        .genealogy-tree li::after {
            content: '';
            position: absolute;
            top: 0;
            right: 50%;
            border-top: 2px solid #ccc;
            width: 50%;
            height: 18px;
        }

        .genealogy-tree li::after {
            right: auto;
            left: 50%;
            border-left: 2px solid #ccc;
        }

        .genealogy-tree li:only-child::after,
        .genealogy-tree li:only-child::before {
            display: none;
        }

        .genealogy-tree li:only-child {
            padding-top: 0;
        }

        .genealogy-tree li:first-child::before,
        .genealogy-tree li:last-child::after {
            border: 0 none;
        }

        .genealogy-tree li:last-child::before {
            border-right: 2px solid #ccc;
            border-radius: 0 5px 0 0;
            -webkit-border-radius: 0 5px 0 0;
            -moz-border-radius: 0 5px 0 0;
        }

        .genealogy-tree li:first-child::after {
            border-radius: 5px 0 0 0;
            -webkit-border-radius: 5px 0 0 0;
            -moz-border-radius: 5px 0 0 0;
        }

        .genealogy-tree ul ul::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            border-left: 2px solid #ccc;
            width: 0;
            height: 20px;
        }

        .genealogy-tree li a {
            text-decoration: none;
            color: #666;
            font-family: arial, verdana, tahoma;
            font-size: 11px;
            display: inline-block;
            border-radius: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
        }

        .genealogy-tree li a:hover,
        .genealogy-tree li a:hover+ul li a {
            background: #c8e4f8;
            color: #000;
        }

        .genealogy-tree li a:hover+ul li::after,
        .genealogy-tree li a:hover+ul li::before,
        .genealogy-tree li a:hover+ul::before,
        .genealogy-tree li a:hover+ul ul::before {
            border-color: #fbba00;
        }

        /*--------------memeber-card-design----------*/

        .member-view-box {
            padding-bottom: 10px;
            text-align: center;
            border-radius: 4px;
            position: relative;
            border: 1px;
            border-color: #e4e4e4;
            border-style: solid;
        }

        .member-image {
            padding: 10px;
            width: 120px;
            position: relative;
        }

        .member-image img {
            width: 100px;
            height: 100px;
            border-radius: 6px;
            background-color: #fff;
            z-index: 1;
        }

        .member-header {
            padding: 5px 0;
            text-align: center;
            background: #345;
            color: #fff;
            font-size: 14px;
            border-radius: 4px 4px 0 0;
        }

        .member-footer {
            text-align: center;
        }

        .member-footer div.name {
            color: #000;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .member-footer div.downline {
            color: #000;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .ui-tooltip {
            background: #009541;
            /* Custom background color */
            color: #FFFFFF;
            border: 1px solid #009541;
            font-size: 12px;
            padding: 10px;
            border-radius: 15px;
            width: 250px;
        }

        .ui-tooltip-content {
            color: #FFFFFF;
        }

        .ui-tooltip table {
            color: #FFFFFF;
            font-size: 12px;
            width: 100%;
            border-collapse: collapse;
            /* Ensure table borders are collapsed */
        }

        .ui-tooltip th {
            text-align: left;
            padding-right: 10px;
            font-weight: bold;
        }

        .ui-tooltip td {
            padding: 5px 0;
        }

        .ui-tooltip td span {
            float: right;
        }
    </style>
@endpush

@section('title')
    My Placement Tree
@endsection


@section('content')
    @php
        $user = App\Models\CustomUser::find($id); // Replace with the leader's ID
    @endphp

    <div class="body genealogy-body genealogy-scroll">
        <div class="genealogy-tree">
            <ul>
                @if ($user)
                    @php App\Helpers\Helper::renderTree($user); @endphp
                @else
                    <li>No Leader Found</li>
                @endif
            </ul>
        </div>
    </div>
@endsection

@push('js')
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(document).ready(function() {
            // Initialize tooltips
            $('.member-view-box[data-tooltip]').tooltip({
                content: function() {
                    return $(this).attr('data-tooltip');
                },
                items: ".member-view-box[data-tooltip]",
                show: {
                    effect: "slideDown",
                    duration: 0
                },
                hide: {
                    effect: "fadeOut",
                    duration: 0
                }
            });
        });
    </script>
@endpush
