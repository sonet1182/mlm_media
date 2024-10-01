<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentGateway extends Model
{
    use HasFactory;
    protected $guarded = [];


    public function users(){
        return $this->belongsTo(CustomUser::class, 'id', 'c_user_id');
    }
}
