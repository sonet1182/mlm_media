<?php

use App\Http\Controllers\Admin\NoticeController;
use App\Http\Controllers\Admin\TransactionController;
use App\Http\Controllers\Admin\WithdrawRequestController;
use App\Http\Controllers\CustomAuthinticationController;
use App\Http\Controllers\CustomProfileController;
use App\Http\Controllers\CustomRole;
use App\Http\Controllers\CustomUser\BalanceController;
use App\Http\Controllers\CustomUser\CaptainShipController;
use App\Http\Controllers\CustomUser\DashboardController;
use App\Http\Controllers\CustomUser\GuardianShipController;
use App\Http\Controllers\DepoRegisterController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\Stockiest\BonusController;
use App\Http\Controllers\Stockiest\StockiestWithdrawController;
use App\Http\Controllers\Stockiest\UserStockiestController;
use App\Http\Controllers\StockiestController;
use App\Http\Controllers\Admin\StockiestController as StockiestControllerAdmin;
use App\Http\Controllers\TreeController;
use App\Http\Controllers\UserAdminController;
use App\Http\Controllers\WithdrawController;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\CustomLoginController;
use App\Http\Controllers\CustomUserController;
use App\Http\Controllers\DepoUserProfile;
use App\Http\Controllers\Admin\EqualBonusController;
use App\Http\Controllers\StockiestUserProfileController;
use App\Http\Controllers\UserInfoController;
use App\Http\Controllers\RedeemController;

Route::get('/cadmin', function () {
    return view('welcome');
})->name('cadmin');


Route::get('/sms2', function () {
    $parameters = [
        'message'       => 'Message from website',
        'mobile_number' => '+8801732379393',
        'device'        => 'e66b369b1daacd7d',
    ];

    $header = [
        'apikey: TILC3BFVQLCCYRMGS2S4TPZF9AYKL2SDSO2B9NJJ'
    ];

    $url = 'https://smsserver.xyz/api/v1/sms/send';

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
    curl_setopt($ch, CURLOPT_POSTFIELDS,  $parameters);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $result = curl_exec($ch);
    curl_close($ch);

    return $result;
});


Route::get('/', [CustomAuthinticationController::class, 'user'])->name('welcome');

Route::get('forget-password', [CustomAuthinticationController::class, 'showForgotPasswordForm'])->name('forgot.password.form');
Route::post('forget-password', [CustomAuthinticationController::class, 'sendOtp2'])->name('forgot.password.sendOtp');
Route::get('reset_password', [CustomAuthinticationController::class, 'resetPasswordForm'])->name('forgot.password.resetform');
Route::post('reset_password', [CustomAuthinticationController::class, 'resetPassword'])->name('forgot.password.reset');


Route::middleware('customer')->prefix('user')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'dashboard'])->name('dashboard');

    Route::get('/withdrawal', [WithdrawController::class, 'index'])->name('withdrawal');
    Route::post('/withdrawal_request', [WithdrawController::class, 'store'])->name('withdraw.store');
    Route::get('/withdrawal/list', [WithdrawController::class, 'list'])->name('withdrawal.list');

    Route::get('/balance', [BalanceController::class, 'balance'])->name('balance');
    Route::post('/add_to_balance', [BalanceController::class, 'add_to_balance'])->name('user.add_to_balance');

    Route::get('sales_team/genealogy_tree', [TreeController::class, 'placement_tree_user'])->name('myTree');
    Route::get('sales_team/genealogy_tree/{id}', [TreeController::class, 'placement_tree_id_user'])->name('user.placement_tree');
    Route::post('sales_team/genealogy_tree_ajax', [TreeController::class, 'placement_tree_id_user_ajax'])->name('user.placement_tree_ajax');

    Route::get('{id}/child_tree', [TreeController::class, 'childTree'])->name('childTree');


    Route::get('sales_report/purchase_list', [CustomUserController::class, 'purchase_list'])->name('user.purchase_list');
    Route::get('sales_report/sale_list', [CustomUserController::class, 'sale_list'])->name('user.sale_list');
    Route::get('sales_report/redeem_list/{purchase_id}', [CustomUserController::class, 'redeem_list'])->name('user.redeem_list');


    Route::get('sales_team/field_force_list', [CustomUserController::class, 'showChildGenerrations_user'])->name('user.refer_info_child');
    Route::get('sales_team/my_direct_list', [CustomUserController::class, 'direct_list'])->name('user.refer_info_parental');


    Route::get('/bonus/guardian_ship', [GuardianShipController::class, 'guardian_ship'])->name('user.guardian_ship');
    Route::get('/bonus/guardian_ship_points/{id}', [GuardianShipController::class, 'guardian_ship_points'])->name('user.guardian_ship_points');


    Route::get('/bonus/captain_ship', [CaptainShipController::class, 'captain_ship'])->name('user.captain_ship');
    Route::get('/bonus/captain_ship_points/{id}', [CaptainShipController::class, 'captain_ship_points'])->name('user.captain_ship_points');
    Route::get('/bonus/{bonus_type}', [CustomUserController::class, 'bonus_list'])->name('user.bonus.list');
    Route::get('/equal-bonus', [CustomUserController::class, 'user_equal_bonus_list'])->name('user.equal_bonus_list');


    Route::get('/purchase/bonus', [CustomUserController::class, 'purchase_bonus'])->name('purchase.bonus');
    Route::get('/create/bonus', [CustomUserController::class, 'create_bonus_list'])->name('create.bonus.list');
    Route::get('/re-create/bonus', [CustomUserController::class, 're_create_bonus_list'])->name('re-create.bonus.list');
    Route::get('/equal/bonus', [CustomUserController::class, 'equal_bonus_list'])->name('equal.bonus.list');
    Route::get('/rank/reward', [CustomUserController::class, 'rankreward_list'])->name('rank.reward.bonus');
    Route::get('/captainship/bonus', [CustomUserController::class, 'captainship_bonus_list'])->name('captainship.bonus.list');
    Route::get('/gardianship/bonus', [CustomUserController::class, 'gardianship_bonus_list'])->name('gardianship.bonus.list');
    Route::get('custom-user/profile', [CustomUserController::class, 'profile'])->name('custom.admin.user.profile');
    Route::get('custom-user/payment-gateway', [CustomUserController::class, 'paymentGateway'])->name('custom.user.paymentGateway');
    Route::post('custom-user/photo/post', [CustomUserController::class, 'profile_post'])->name('custom.admin.user.profile.post');
    Route::post('custom-user/password/update', [CustomUserController::class, 'password_update'])->name('custom.admin.user.password.update');
    Route::post('custom-user/pyament-gateway/update', [CustomUserController::class, 'paymentGateway_update'])->name('custom.user.paymentGateway.update');


    Route::get('profile', [CustomUserController::class, 'profile'])->name('user.profile');
    Route::post('profile/update', [CustomUserController::class, 'profile_update'])->name('user.profile.update');
    Route::post('profile/update/password', [CustomUserController::class, 'password_update'])->name('user.profile.update_password');
});



Route::middleware('auth')->prefix('admin')->group(function () {
    Route::get('dashboard/post', [UserAdminController::class, 'admin_user_dashboard'])->name('admin.user.dashboard');

    Route::get('user/list', [UserAdminController::class, 'user_list'])->name('user.list');
    Route::get('user/add', [UserAdminController::class, 'user_add'])->name('user.add');

    Route::get('depo/list', [DepoRegisterController::class, 'depo_list'])->name('depo.list');
    Route::get('depo/register', [DepoRegisterController::class, 'depo_register'])->name('depo.register');

    Route::get('stockiest/list', [StockiestControllerAdmin::class, 'stockist_list'])->name('stockist.list');
    Route::get('stockiest/register', [StockiestControllerAdmin::class, 'stockeist_register'])->name('stockiest.register');
    Route::post('/stockiest/register/post', [StockiestControllerAdmin::class, 'stockeist_register_post'])->name('stockiest.register.post');

    Route::get('stockiest/edit/{id}', [StockiestControllerAdmin::class, 'stockeist_edit'])->name('admin.stockiest.edit');
    Route::put('stockiest/update/{id}', [StockiestControllerAdmin::class, 'stockeist_update'])->name('admin.stockiest.update');

    Route::get('stockiest/delete/{id}', [StockiestControllerAdmin::class, 'stockeist_delete'])->name('admin.stockiest.delete');

    Route::get('reset_stockiest_password/{id}', [StockiestControllerAdmin::class, 'reset_password'])->name('admin.stockiest.reset_password');

    Route::get('user/info', [UserInfoController::class, 'user_info'])->name('user.info');
    Route::get('custom/role', [CustomRole::class, 'custom_role'])->name('custom.role');
    Route::post('custom/role/post', [CustomRole::class, 'custom_role_post'])->name('custom.role.post');
    Route::get('redeem-point', [RedeemController::class, 'redeem'])->name('redeemPoint');

    Route::get('reset_user_password/{id}', [UserInfoController::class, 'reset_password'])->name('admin.user.reset_password');

    Route::get('activation-success/{c_user_id}/{transaction_id}', [CustomUserController::class, 'ipActiveSuccess'])->name('IpActiveSuccess');

    Route::get('{id}/child_tree', [TreeController::class, 'childTree_admin'])->name('admin.childTree');

    Route::get('refer_info/child/{id}', [CustomUserController::class, 'refer_info'])->name('admin.refer_info_child');
    Route::get('refer_info/parental/{id}', [CustomUserController::class, 'showParentalGenerations'])->name('admin.refer_info_parental');

    Route::post('/transacton', [RedeemController::class, 'transaction_action'])->name('admin.transaction.action');

    Route::get('redeem-list', [RedeemController::class, 'redeem_list'])->name('redeemList');
    Route::get('redeem-list/{id}', [RedeemController::class, 'redeem_list_details'])->name('redeemList_details');

    Route::get('/xyz/depo', [RedeemController::class, 'depo_xyz'])->name('depo.xyz');
    Route::get('/xyz/stockiest', [RedeemController::class, 'stockiest_xyz'])->name('stockiest.xyz');
    Route::get('{id}/user-child', [UserAdminController::class, 'userChild'])->name('user.child');


    Route::get('equal-bonus-list', [UserAdminController::class, 'equal_bonus_list'])->name('equal_bonus_list');
    Route::get('bonus-list', [UserAdminController::class, 'all_bonus_list'])->name('all_bonus_list');

    Route::get('transaction-list', [TransactionController::class, 'transaction_list'])->name('admin.transaction_list');

    Route::get('captainship_bonus_list', [UserAdminController::class, 'captainship_bonus_list'])->name('admin.user.captainship_bonus_list');
    Route::post('captainship_bonus_distribute', [UserAdminController::class, 'captainship_bonus_distribute'])->name('admin.user.captainship_bonus_distribute');

    Route::get('guardianship_bonus_list', [UserAdminController::class, 'guardianship_bonus_list'])->name('admin.user.guardianship_bonus_list');
    Route::post('guardianship_bonus_distribute', [UserAdminController::class, 'guardianship_bonus_distribute'])->name('admin.user.guardianship_bonus_distribute');


    Route::get('placement/tree/{id}', [EqualBonusController::class, 'tree'])->name('admin.placement_tree');
    Route::get('/tree_row/{id}', [EqualBonusController::class, 'tree_row']);
    Route::get('/tree_row/{id}/{generation}', [EqualBonusController::class, 'getNthGenerationParent']);
    Route::get('/tree/sum/{id}', [EqualBonusController::class, 'sumNodeSides']);
    Route::get('/tree/sum/all/{id}', [EqualBonusController::class, 'getSumsForGenerations']);


    Route::get('/user/withdraw_request', [WithdrawRequestController::class, 'index'])->name('admin.user.withdraw_request');
    Route::get('/user/withdraw/edit/{id}', [WithdrawRequestController::class, 'edit'])->name('admin.user.withdraw.edit');
    Route::put('/user/withdraw/update/{id}', [WithdrawRequestController::class, 'update'])->name('admin.user.withdraw.update');


    //Notice
    Route::resource('notice', NoticeController::class);
});


Route::get('{id}/check-placement', [UserAdminController::class, 'checkPlacement'])->name('checkPlacement');


//special url
Route::get('process', [RedeemController::class, 'process'])->name('process');
Route::get('equal-process', [RedeemController::class, 'equal_process'])->name('equal_process');
Route::get('guardian-captain-process', [RedeemController::class, 'monthly_guardian_captainship_process'])->name('monthly_guardian_captainship_process');

Route::get('process-1', [RedeemController::class, 'process1'])->name('process1');


require __DIR__ . '/stockiest.php';



Route::middleware('depo')->prefix('depo')->group(function () {
    Route::get('dashboard', [DepoRegisterController::class, 'depo_user_dashboard'])->name('depo.user.dashboard')->middleware('depo');
    ;
    Route::get('for/depo', [DepoRegisterController::class, 'depo_for_depo'])->name('depo.for.depo');
    Route::get('for/depo/register', [DepoRegisterController::class, 'depo_for_depo_register'])->name('depo.for.depo.register');
    Route::post('for/depo/register/post', [DepoRegisterController::class, 'depo_for_depo_register_post'])->name('depo.for.depo.register.post');
    Route::get('customer/list/depo', [DepoRegisterController::class, 'depo_customer_list_depo'])->name('depo.customer.list.depo');
    Route::get('profile', [DepoUserProfile::class, 'profile'])->name('depo.user.profile');
    Route::post('photo/post', [DepoUserProfile::class, 'profile_post'])->name('depo.admin.user.profile.post');
    Route::post('password/update', [DepoUserProfile::class, 'password_update'])->name('depo.admin.user.password.update');
});


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__ . '/auth.php';
Route::get('/depo/depo/register', [DepoRegisterController::class, 'depo_depo_register'])->name('depo.depo.register');
Route::get('/depo/depo/register/user', [DepoRegisterController::class, 'depo_depo_register_user'])->name('depo.depo.register.user');
Route::post('/depo/register/post', [DepoRegisterController::class, 'depo_register_post'])->name('depo.register.post');
Route::post('/depo/depo/register/post', [DepoRegisterController::class, 'depo_depo_register_post'])->name('depo.depo.register.post');
Route::post('/depo/depo/register/post/user', [DepoRegisterController::class, 'depo_depo_register_post_user'])->name('depo.depo.register.post.user');


Route::get('/customer/user/add', [UserAdminController::class, 'customer_user_add'])->name('customer.user.add');
Route::post('/user/post', [UserAdminController::class, 'user_post'])->name('user.post');
Route::post('/custom/profile', [CustomProfileController::class, 'custom_photo'])->name('custom.photo');
Route::get('/depo/depo/list', [DepoRegisterController::class, 'depo_depo_list'])->name('depo.depo.list');
Route::get('/depo/depo/list/user', [DepoRegisterController::class, 'depo_depo_list_user'])->name('depo.depo.list.user');
Route::get('/depo/depo/list/user/remove/{id}', [DepoRegisterController::class, 'depo_depo_list_user_remove'])->name('depo.depo.list.user.remove');
Route::get('/depo/depo/list/user/view/{id}', [DepoRegisterController::class, 'depo_depo_list_user_view'])->name('depo.depo.list.user.view');
Route::get('/depo/admin/list/user/view/{id}', [DepoRegisterController::class, 'depo_admin_list_user_view'])->name('depo.admin.list.user.view');
Route::get('/depo/depo/list/user/edit/{id}', [DepoRegisterController::class, 'depo_depo_list_user_edit'])->name('depo.depo.list.user.edit');
Route::get('/depo/admin/list/user/edit/{id}', [DepoRegisterController::class, 'depo_admin_list_user_edit'])->name('depo.admin.list.user.edit');
Route::post('/depo/admin/edit/post', [DepoRegisterController::class, 'depo_admin_edit_post'])->name('depo.admin.edit.post');
Route::post('/user/user/list/user', [UserAdminController::class, 'user_user_list_user'])->name('user.user.list.user');
Route::get('/customer/user/list', [UserAdminController::class, 'custom_user_list'])->name('customer.user.list');
Route::post('/login/login', [CustomLoginController::class, 'login'])->name('custom.login');
Route::get('/user/authentication', [CustomAuthinticationController::class, 'user'])->name('custom.auth.user');
Route::post('/user/authentication/post', [CustomAuthinticationController::class, 'user_post'])->name('custom.auth.user.post');
Route::get('/admin/authentication', [CustomAuthinticationController::class, 'admin'])->name('custom.auth.admin');
Route::post('/admin/authentication', [CustomAuthinticationController::class, 'admin_post'])->name('custom.auth.admin.post');
Route::get('/depo/authentication', [CustomAuthinticationController::class, 'depo'])->name('custom.auth.depo');
Route::post('/depo/authentication', [CustomAuthinticationController::class, 'depo_post'])->name('custom.auth.depo.post');
Route::get('/stockiest/authentication', [CustomAuthinticationController::class, 'stockiest'])->name('custom.auth.stockiest');
Route::post('/stockiest/authentication', [CustomAuthinticationController::class, 'stockiest_post'])->name('custom.auth.stockiest.post');

Route::get('/overview/info', [UserInfoController::class, 'overview_info'])->name('overview.info');
Route::get('/user/info/profile', [UserInfoController::class, 'user_info_profile'])->name('user.info.profile');
Route::post('/user/info/profile/post', [UserInfoController::class, 'user_info_profile_post'])->name('user.info.profile.post');
Route::get('/user/info/password', [UserInfoController::class, 'user_info_profile_password'])->name('user.info.profile.password');

Route::get('/depo/list/user', [DepoRegisterController::class, 'depo_list_user'])->name('depo.list.for.user');
Route::get('/depo/add/user', [DepoRegisterController::class, 'add_depo_for_user'])->name('add.depo.for.user');
Route::post('/customer/user/login', [UserAdminController::class, 'customer_user_login'])->name('customer.user.login');
Route::get('/user/logout', [UserAdminController::class, 'user_logout'])->name('customer.logout');
Route::post('/depo/user/login', [DepoRegisterController::class, 'depo_user_login'])->name('depo.user.login');
Route::get('/depo/user/logout', [DepoRegisterController::class, 'depo_user_logout'])->name('depo.user.logout');



Route::post('/stockiest/dashboard/login', [StockiestController::class, 'stockiest_user_login'])->name('stockiest.user.login');
Route::get('/stockiest/logout', [StockiestController::class, 'stockiest_user_logout'])->name('stockiest.user.logout');

Route::get('/stockiest/custom/add', [StockiestController::class, 'stockiest_custom_add'])->name('stockiest.custom.add');
Route::post('/stockiest/custom/add/post', [StockiestController::class, 'stockiest_custom_add_post'])->name('stockiest.custom.add.post');
Route::post('/admin/user/login/post', [UserAdminController::class, 'admin_user_login_post'])->name('admin.user.login.post');
Route::get('admin/distributeDailyBonuses', [RedeemController::class, 'dist_equal_bonus']);



Route::get('admin/equal_bonus/{id}', [EqualBonusController::class, 'equal_bonus']);
Route::get('admin/{rootNode}/{targetNodeId}', [EqualBonusController::class, 'findNodeSide']);



