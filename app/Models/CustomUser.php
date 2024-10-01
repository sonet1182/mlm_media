<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class CustomUser extends Authenticatable
{
    use HasFactory, Notifiable;
    protected $guarded = ['id'];
    protected $guard = 'customUser';
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function referrals()
    {
        return $this->hasMany(Referral::class, 'user_id');
    }

    public function referredBy()
    {
        return $this->belongsTo(CustomUser::class, 'referrer_id');
    }

    public function allReferrals()
    {
        return $this->referrals()->with('referredUser.allReferrals');
    }


    public function parent()
    {
        return $this->belongsTo(CustomUser::class, 'parent_id');
    }

    public function childrenA()
    {
        return $this->hasOne(CustomUser::class, 'placement_a', 'id');
    }

    public function childrenB()
    {
        return $this->hasOne(CustomUser::class, 'placement_b', 'id');
    }

    public function stockiest()
    {
        return $this->belongsTo(Stockiest::class, 'stockiest_id');
    }

    public function purchase()
    {
        return $this->hasMany(rp_redeemed_c_user::class, 'c_user_id');
    }

    public function active_purchase()
    {
        return $this->hasMany(rp_redeemed_c_user::class, 'c_user_id')->where('type', 'activate');
    }



    public function ref_parent()
    {
        return $this->belongsTo(CustomUser::class, 'referrer_id');
    }

    // Define recursive method to get ancestors
    public function getAncestors()
    {
        $ancestors = collect();  // Use a collection to store the ancestors

        $current = $this->ref_parent;  // Start with the parent

        // Recursively add parents to the ancestors collection
        while ($current) {
            $ancestors->push($current);
            $current = $current->ref_parent;
        }

        return $ancestors;
    }
}
