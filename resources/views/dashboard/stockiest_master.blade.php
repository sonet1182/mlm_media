<!DOCTYPE html>

<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stockist | @yield('title', 'Dashboard')</title>

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
                <li class="" class="btn btn-success">
                    <a href="{{ route('stockiest.user.logout') }}" class="btn btn-primary">
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
                        @if (auth()->guard('stockiest')->user()->image == null)
                            <img src="{{ Avatar::create(Auth::guard('stockiest')->user()->stockiest_name)->toBase64() }}"
                                width="20px" />
                        @else
                            <img src="{{ asset(Auth::guard('stockiest')->user()->image) }}"
                                width="20px" height="20px"
                                style="border-radius:50% !important;height:40px !important;width:40px !important;"
                                alt="User Image" />
                        @endif
                    </div>
                    <div class="info">
                        <a href="" class="d-block">{{ auth()->guard('stockiest')->user()->stockiest_name }}</a>
                    </div>
                </div>


                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu"
                        data-accordion="false">

                        <li class="nav-item">
                            <a href="{{ url('stockiest/dashboard') }}" class="nav-link">
                                <i class="nav-icon fas fa-home"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>

                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-user"></i>
                                <p>
                                    USER
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>

                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.customer.list') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Customer List</p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item">
                            <a href="" class="nav-link">
                                <i class="nav-icon fas fa-list"></i>
                                <p>
                                    Sales Team
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.refer_info_child') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Field Force List</p>
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <a href="{{ route('stockiest.refer_info_parental') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Direct List</p>
                                    </a>
                                </li>

                                <li class="nav-item">
                                    <a href="{{ route('stockiest.customer.list', ['type' => 'active']) }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Active User Report</p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-shopping-cart"></i>
                                <p>
                                    Sales Reports
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.redeemList') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Stockiest Sale Report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Product Purchase Report</p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-edit"></i>
                                <p>
                                    Wallets Reports
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.bonus.list', 'stockiest_bonus') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Stockiest Bonus Report</p>
                                    </a>
                                </li>
                                {{-- <li class="nav-item">
                                    <a href="{{ route('stockiest.bonus.list', 'stockiest_bonus') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>User withdrawal balance report</p>
                                    </a>
                                </li> --}}
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.bonus.list', 'house_rent') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>House Rent report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.bonus.list', 'currier_cost') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Courier report</p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item">
                            <a href="{{ route('stockiest.balance') }}" class="nav-link">
                                <i class="nav-icon fa fa-exchange"></i>
                                <p>Balance Transfer</p>
                            </a>
                        </li>

                

                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-money"></i>
                                <p>
                                    Stockiest Withdrawal
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.withdraw') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Withdrawal Request</p>
                                    </a>
                                </li>
                                
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.withdraw.list') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Withdrawal Report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.withdraw.list', ['type' => 'pending']) }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Withdrawal Pending Report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.withdraw.list', ['type' => 'paid']) }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Withdrawal Complete Report</p>
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a href="#" class="nav-link">
                                <i class="nav-icon fas fa-money"></i>
                                <p>
                                   User Withdrawal
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.user.withdraw') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>User Withdrawal Report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.user.withdraw', ['type' => 'pending']) }}"
                                        class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>User Withdrawal Pending Report</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.user.withdraw', ['type' => 'paid']) }}"
                                        class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>User Withdrawal Complete Report</p>
                                    </a>
                                </li>

                            </ul>
                        </li>




                        <li class="nav-item">
                            <a href="{{ route('stockiest.redeemPoint') }}" class="nav-link">
                                <i class="nav-icon fas fa-star"></i>
                                <p>
                                    Redeem Point
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.redeemPoint') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Redeem Point</p>
                                    </a>
                                </li>
                            </ul>
                        </li>


                        <li class="nav-item">
                            <a href="" class="nav-link">
                                <i class="nav-icon fas fa-cog"></i>
                                <p>
                                    Settings
                                    <i class="fas fa-angle-left right"></i>
                                </p>
                            </a>
                            <ul class="nav nav-treeview">
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.settings.wallet') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Wallet Setting</p>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a href="{{ route('stockiest.user.profile') }}" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Profile Setting</p>
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
                            <h1 class="m-0">
                                @yield('title')
                            </h1>
                        </div>
                        <div class="col-sm-6"></div>
                    </div>
                </div>
            </div>


            <!-- Main content -->
            <section class="content">
                <div class="container-fluid">
                    <div class="">
                        @yield('content')
                    </div>
                </div>
            </section>
        </div>

        @include('dashboard.footer')


        <aside class="control-sidebar control-sidebar-dark">
        </aside>
    </div>

    @include('layouts.inc.js')
</body>

</html>
