<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WithdrawRequest extends Model
{
    use HasFactory;
    protected $guarded=[];

    public function user()
    {
        return $this->belongsTo(CustomUser::class, 'user_id', 'id');
    }
    public function stockiest()
    {
        return $this->belongsTo(Stockiest::class, 'stockiest_id', 'id');
    }
}
