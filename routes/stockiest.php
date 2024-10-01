<?php
use App\Http\Controllers\Stockiest\BalanceController;
use App\Http\Controllers\Stockiest\OwnWithdrawController;
use App\Http\Controllers\Stockiest\WithdrawController;
use App\Http\Controllers\StockiestController;
use App\Http\Controllers\RedeemController;
use App\Http\Controllers\Stockiest\BonusController;
use App\Http\Controllers\Stockiest\StockiestWithdrawController;
use App\Http\Controllers\Stockiest\UserStockiestController;
use App\Http\Controllers\StockiestUserProfileController;
use App\Http\Controllers\UserAdminController;


// Stockiest Routes
Route::middleware('stockiest')->prefix('stockiest')->group(function () {
    Route::get('dashboard', [StockiestController::class, 'dashboard'])->name('stockiest.dashboard')->middleware('stockiest');

    Route::get('profile', [StockiestUserProfileController::class, 'profile'])->name('stockiest.user.profile');
    Route::post('profile/update', [StockiestUserProfileController::class, 'profile_update'])->name('stockiest.profile.update');
    Route::post('profile/update/password', [StockiestUserProfileController::class, 'password_update'])->name('stockiest.profile.update_password');

    Route::get('customer/list', [UserStockiestController::class, 'stockiest_customer_list'])->name('stockiest.customer.list');
    Route::get('customer/add', [UserStockiestController::class, 'customer_add'])->name('stockiest.customer.create');
    Route::post('customer/create', [UserStockiestController::class, 'user_user_list_user'])->name('stockiest.customer.store');

    Route::get('sales_team/field_force_list', [UserStockiestController::class, 'field_force'])->name('stockiest.refer_info_child');
    Route::get('sales_team/field_force_list/{id}', [UserStockiestController::class, 'showChildGenerations_user'])->name('stockiest.refer_info_child_data');
    Route::get('sales_team/direct_list', [UserStockiestController::class, 'direct_list'])->name('stockiest.refer_info_parental');
    Route::get('sales_team/direct_list/{id}', [UserStockiestController::class, 'showParentalGenerations_user'])->name('stockiest.refer_info_parental_data');

    Route::get('placement/tree/{id}', [UserStockiestController::class, 'tree'])->name('stockiest.placement_tree');
    // Route::get('reset_user_password/{id}', [UserStockiestController::class, 'reset_password'])->name('stockiest.user.reset_password');
    // Route::get('refer_info/parental/{id}', [UserStockiestController::class, 'showParentalGenerations'])->name('stockiest.refer_info_parental');

    Route::get('bonus', [BonusController::class, 'bonus_list'])->name('stockiest.bonus');
    
    Route::get('/user/withdraw', [StockiestWithdrawController::class, 'index'])->name('stockiest.user.withdraw');
    Route::get('/user/withdraw/edit/{id}', [StockiestWithdrawController::class, 'edit'])->name('stockiest.user.withdraw.edit');
    Route::put('/user/withdraw/update/{id}', [StockiestWithdrawController::class, 'update'])->name('stockiest.user.withdraw.update');


    Route::get('/balance', [BalanceController::class, 'balance'])->name('stockiest.balance');
    Route::post('/add_to_balance', [BalanceController::class, 'add_to_balance'])->name('stockiest.add_to_balance');

    // Own Withdraw
    Route::get('/withdrawal', [OwnWithdrawController::class, 'index'])->name('stockiest.withdraw');
    Route::post('/withdrawal_request', [OwnWithdrawController::class, 'store'])->name('stockiest.withdraw.store');
    Route::get('/withdrawal/list', [OwnWithdrawController::class, 'list'])->name('stockiest.withdraw.list');


    Route::post('photo/post', [StockiestUserProfileController::class, 'profile_post'])->name('stockiest.admin.user.profile.post');
    Route::post('password/update', [StockiestUserProfileController::class, 'password_update'])->name('stockiest.admin.user.password.update');
    Route::get('depo/list', [StockiestController::class, 'stockiest_depo_list'])->name('stockiest.depo.list');
    Route::get('depo/add', [StockiestController::class, 'stockiest_depo_add'])->name('stockiest.depo.add');
    Route::post('depo/add/post', [StockiestController::class, 'stockiest_depo_add_post'])->name('stockiest.depo.add.post');

    Route::get('for/depo/list', [UserAdminController::class, 'stockiest_depo_for_list'])->name('stockiest.depo.for.list');
    Route::get('for/depo/add', [UserAdminController::class, 'stockiest_depo_for_add'])->name('stockiest.depo.for.add');
    Route::post('for/depo/add/post', [UserAdminController::class, 'stockiest_depo_for_add_post'])->name('stockiest.depo.for.add.post');
    Route::get('for/stockiest/list', [UserAdminController::class, 'stockiest_stockiest_for_list'])->name('stockiest.stockiest.for.list');
    Route::get('for/stockiest/add', [UserAdminController::class, 'stockiest_stockiest_for_add'])->name('stockiest.stockiest.for.add');
    Route::post('for/stockiest/add/post', [UserAdminController::class, 'stockiest_stockiest_for_add_post'])->name('stockiest.stockiest.for.add.post');

    Route::get('/redeem-point', [StockiestUserProfileController::class, 'redeem'])->name('stockiest.redeemPoint');
    Route::get('/sales-report', [StockiestUserProfileController::class, 'redeem_list'])->name('stockiest.redeemList');
    Route::get('/transacton', [RedeemController::class, 'transaction_action'])->name('stockiest.transaction.action');

    Route::get('/settings/wallet', [OwnWithdrawController::class, 'paymentGateway'])->name('stockiest.settings.wallet');
    Route::post('/settings/wallet/update', [OwnWithdrawController::class, 'paymentGateway_update'])->name('stockiest.settings.wallet.update');


    Route::get('/bonus/{bonus_type}', [BonusController::class, 'bonus_list'])->name('stockiest.bonus.list');
});