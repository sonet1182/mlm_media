<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class Stockiest extends Authenticatable
{
    use HasFactory, Notifiable;
    protected $guarded=[];
    protected $guard='stockiest';
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function user_refer()
    {
        return $this->belongsTo(CustomUser::class, 'stockiest_ref_id', 'id');
    }
    public function stockiest_refer()
    {
        return $this->belongsTo(Stockiest::class, 'stockiest_ref_id');
    }
    public function depo_refer()
    {
        return $this->belongsTo(Depo::class, 'stockiest_ref_id');
    }


}
