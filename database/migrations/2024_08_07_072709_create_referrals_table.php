<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateReferralsTable extends Migration
{
    public function up()
    {
        Schema::create('referrals', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); // Referrer
            $table->unsignedBigInteger('referred_id'); // Referee
            $table->integer('level')->default(1); // Level of referral
            $table->timestamps();

            $table->foreign('user_id')->references('id')->on('custom_users')->onDelete('cascade');
            $table->foreign('referred_id')->references('id')->on('custom_users')->onDelete('cascade');
        });
    }

    public function down()
    {
        Schema::dropIfExists('referrals');
    }
}

