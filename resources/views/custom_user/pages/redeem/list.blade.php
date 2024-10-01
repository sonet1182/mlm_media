@extends('layouts.admin')

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
    Redeem List
@endsection

@section('content')
    <div class="col-lg-12 col-12 col-md-12 col-sm-12">
        <div class="card">
            <div class="card-header card-headers" style="">
                <div style="">
                    <h4>Invoice No: {{ $purchase->transactions->invoice_no }}</h4>
                </div>
            </div>

            <div class="card-body p-3">
                @if (count($redeems) > 0)
                    <!-- General Beneficiary Table (without Ref Level) -->
                    <div class="row">
                        <div class="col-md-6">
                            <h5>General Beneficiary Details</h5>
                            <table class="table table-bordered table-striped" id="dataTable">
                                <thead>
                                    <tr>
                                        <th>Beneficiary Type</th>
                                        <th>Beneficiary ID</th>
                                        <th>Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($redeems as $redeem)
                                        @if (!$redeem->ref_level)
                                            <tr>
                                                <td>{{ $redeem->beneficiary_type }}</td>
                                                <td>
                                                    @if ($redeem->benifit_by == 'user')
                                                        {{ $redeem->custom_user ? $redeem->custom_user->user_id : '' }}
                                                    @endif
                                                    @if($redeem->benifit_by == 'stockiest')
                                                        {{ $redeem->stockiest ? $redeem->stockiest->stockiest_user_id : '' }}
                                                    @endif
                                                    @if($redeem->benifit_by == 'depo')
                                                        {{ $redeem->depo ? $redeem->depo->depo_user_id : '' }}
                                                    @endif
                                                </td>
                                                <td>{{ $redeem->amount }}</td>
                                            </tr>
                                        @endif
                                    @endforeach
                                </tbody>
                            </table>
                        </div>

                        <div class="col-md-6">
                            <!-- Referral Level Table (with Ref Level) -->
                            <h5>Referral Level Details</h5>
                            <table class="table table-bordered table-striped" id="refLevelTable">
                                <thead>
                                    <tr>
                                        <th>Beneficiary Type</th>
                                        <th>User ID</th>
                                        <th>Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach ($redeems as $redeem)
                                        @if ($redeem->ref_level)
                                            <tr>
                                                <td>Re-Creating Bonus Gen-{{ $redeem->ref_level }}</td>
                                                <td>{{ $redeem->custom_user ? $redeem->custom_user->user_id : '' }}</td>
                                                <td>{{ $redeem->amount }}</td>
                                            </tr>
                                        @endif
                                    @endforeach
                                </tbody>
                            </table>
                        </div>

                    </div>
                @else
                    <p>No redeem records found.</p>
                @endif
            </div>
        </div>
    </div>
@endsection
