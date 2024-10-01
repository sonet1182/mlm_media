<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('custom_users', function (Blueprint $table) {
            $table->id();
            $table->string('customer_name');
            $table->string('customer_contact_number');
            $table->string('customer_email');
            $table->string('customer_address');
            $table->string('stockiest_id');
            $table->string('user_ref_id');
            $table->string('place_user_id');
            $table->string('placement_side');
            $table->string('user_id');
            $table->string('password');
            $table->string('photo');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('custom_users');
    }
};
