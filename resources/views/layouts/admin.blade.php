<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User | @yield('title', 'Dashboard')</title>

    @include('layouts.inc.css')
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">

        <!-- Preloader -->
        <div class="preloader flex-column justify-content-center align-items-center">
            <img class="animation__shake" src="{{ asset('assets') }}/dist/img/AdminLTELogo.png" alt="AdminLTELogos"
                height="60" width="60">
        </div>

        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i
                            class="fas fa-bars"></i></a>
                </li>
            </ul>

            <ul class="ml-auto navbar-nav">
                <li class="">
                    <a href="{{ route('customer.logout') }}" class="btn btn-primary">
                        Logout
                    </a>
                    </form>
                </li>
            </ul>
        </nav>



        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <div class="sidebar">
                <div class="pb-3 mt-3 mb-3 user-panel d-flex">
                    <div class="image">
                        @if (Auth::guard('customUser')->user()->photo == null)
                            <img src="{{ Avatar::create(Auth::guard('customUser')->user()->customer_name)->toBase64() }}"
                                width="20px" />
                        @else
                            <img src="{{ asset(Auth::guard('customUser')->user()->photo) }}"
                                width="20px" height="20px"
                                style="border-radius:50% !important;height:40px !important;width:40px !important;"
                                alt="User Image" />
                        @endif
                    </div>
                    <div class="info">
                        <a href="#" class="d-block">{{ Auth::guard('customUser')->user()->customer_name }}</a>
                    </div>
                </div>


                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                        data-accordion="false">

                        <li class="nav-item">
                            <a href="{{ route('dashboard') }}"
                                class="nav-link {{ Request::url() == url('user/dashboard') ? 'active' : '' }}">
                                <i class="nav-icon fas fa-tachometer-alt"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="{{ route('dashboard') }}" class="nav-link">
                                <i class="nav-icon fas fa-home"></i>
                                <p>
                                    Product Purchase
                                </p>
                            </a>
                        </li>

                        <li class="nav-item {{ request()->is('user/sales_team*') ? 'menu-open active' : '' }}">
                            <a href="#" class="nav-link {{ request()->is('user/sales_team*') ? 'active' : '' }}">
                                <i class="nav-icon fas fa-table"></i>
                                <p>
                                    Sales Team
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('myTree') }}"
                                        class="nav-link {{ request()->is('user/sales_team/genealogy_tree') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Genealogy Tree</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.refer_info_child') }}"
                                        class="nav-link {{ request()->is('user/sales_team/field_force_list') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Field Force List</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.refer_info_parental') }}"
                                        class="nav-link {{ request()->is('user/sales_team/my_direct_list') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>My Direct List</p>
                                    </a>
                                </li>

                            </ul>
                        </li>


                        <li class="nav-item {{ request()->is('user/sales_report*') ? 'menu-open active' : '' }}">
                            <a href="#"
                                class="nav-link {{ request()->is('user/sales_report*') ? 'active' : '' }}">
                                <i class="nav-icon fas fa-table"></i>
                                <p>
                                    Sales Reports
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('user.sale_list') }}"
                                        class="nav-link {{ request()->is('user/sales_report/sale_list') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Team Sale Report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.purchase_list') }}"
                                        class="nav-link {{ request()->is('user/sales_report/purchase_list') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Product Purchase Report</p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item {{ request()->is('user/bonus*') ? 'menu-open active' : '' }}">
                            <a href="#" class="nav-link {{ request()->is('user/bonus*') ? 'active' : '' }}">
                                <i class="nav-icon fas fa-table"></i>
                                <p>
                                    Wallets Reports
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 'purchase_bonus') }}"
                                        class="nav-link {{ request()->is('user/bonus/purchase_bonus') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Purchase Bonus List</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 'creating_bonus') }}"
                                        class="nav-link {{ request()->is('user/bonus/creating_bonus') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Creating Bonus List</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 're_creating_bonus') }}"
                                        class="nav-link {{ request()->is('user/bonus/re_creating_bonus') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Re-Creating Bonus List</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.equal_bonus_list') }}"
                                        class="nav-link {{ request()->is('user/equal_bonus') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>Equal Bonus List</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 'rank_reward_bonus') }}"
                                        class="nav-link {{ request()->is('user/bonus/rank_reward_bonus') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>
                                            Rank Reward Bonus List
                                        </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 'stockiest_refer_bonus') }}"
                                        class="nav-link {{ request()->is('user/bonus/stockiest_refer_bonus') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>
                                            Stockiest Refer Bonus
                                        </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 'after_death_allowance') }}"
                                        class="nav-link {{ request()->is('user/bonus/after_death_allowance') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>
                                            After Death Allowance
                                        </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.bonus.list', 'company_profit_share') }}"
                                        class="nav-link {{ request()->is('user/bonus/company_profit_share') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>
                                            Company Profit Share
                                        </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.captain_ship') }}"
                                        class="nav-link {{ request()->is('user/bonus/captain_ship') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>
                                            Captain Ship Bonus
                                        </p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('user.guardian_ship') }}"
                                        class="nav-link {{ request()->is('user/bonus/guardian_ship') ? 'active' : '' }}">
                                        <i class="fa fa-list nav-icon"></i>
                                        <p>
                                            Guardian Ship Bonus
                                        </p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item">
                            <a href="{{ route('balance') }}" class="nav-link">
                                <i class="fa fa-exchange nav-icon"></i>
                                <p>
                                    Balance Transfer
                                </p>
                            </a>
                        </li>



                        <li class="nav-item {{ request()->is('user/withdrawal*') ? 'menu-open active' : '' }}">
                            <a href="#"
                                class="nav-link {{ request()->is('user/withdrawal*') ? 'active' : '' }}">
                                <i class="nav-icon fas fa-bank"></i>
                                <p>
                                    Withdrawal
                                    <i class="right fas fa-angle-left"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('withdrawal') }}"
                                        class="nav-link {{ request()->is('user/withdrawal') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Withdrawal Request</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('withdrawal.list') }}""
                                        class="nav-link {{ request()->is('user/withdrawal/list') ? 'active' : '' }}">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Withdrawal List</p>
                                    </a>
                                </li>
                            </ul>
                        </li>





                        <li class="nav-item">
                            <a href="" class="nav-link">
                                <i class="nav-icon far fa-plus-square"></i>
                                <p>
                                    Setting
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('user.profile') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Profile</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('custom.user.paymentGateway') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Payment Infos</p>
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>
        </aside>


        <div class="content-wrapper">
            <div class="content-header">
                <div class="container-fluid">
                    <div class="mb-2 row">
                        <div class="col-sm-6">
                            <h1 class="m-0">@yield('title', 'Dashboard')</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="{{ route('dashboard') }}">Home</a></li>
                                <li class="breadcrumb-item active">Dashboard </li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <section class="content">
                <div class="container-fluid">
                    @yield('content')
                </div>
            </section>
        </div>

        @include('dashboard.footer')
        <aside class="control-sidebar control-sidebar-dark"></aside>
    </div>

    @include('layouts.inc.js')
</body>

</html>
