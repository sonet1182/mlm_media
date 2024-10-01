<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Redeem_Beneficiary extends Model
{
    use HasFactory;
    protected $guarded = [];

    public function redeem_c_user()
    {
        return $this->belongsTo(rp_redeemed_c_user::class, 'rp_redeemed_id', 'id');
    }

    public function custom_user()
    {
        return $this->belongsTo(CustomUser::class, 'rp_beneficiary_id', 'id');
    }

    public function stockiest()
    {
        return $this->belongsTo(Stockiest::class, 'rp_beneficiary_id', 'id');
    }
    public function depo()
    {
        return $this->belongsTo(Depo::class, 'rp_beneficiary_id', 'id');
    }
}
