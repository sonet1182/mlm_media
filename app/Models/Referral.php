<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Referral extends Model
{
    protected $fillable = ['user_id', 'referred_id', 'level'];

    public function user()
    {
        return $this->belongsTo(CustomUser::class, 'user_id');
    }

    public function referredUser()
    {
        return $this->belongsTo(CustomUser::class, 'referred_id');
    }
}

