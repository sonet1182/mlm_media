<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class rp_redeemed_c_user extends Model
{
    use HasFactory;
    protected $guarded = [];


    public function users(){
        return $this->belongsTo(CustomUser::class, 'c_user_id', 'id');
    }

    public function transactions(){
        return $this->belongsTo(Transaction::class,'transaction_id', 'id');
    }

    public function beneficiary(){
        return $this->hasMany(Redeem_Beneficiary::class, 'rp_redeemed_id', 'id');
    }
}
