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
        Schema::create('depos', function (Blueprint $table) {
            $table->id();
            $table->string('depo_name');
            $table->string('contact_person_name');
            $table->string('contact_number');
            $table->string('depo_email_id');
            $table->string('depo_address');
            $table->string('depo_arya');
             $table->string('depo_user_id')->unique();
            $table->string('depo_user_password');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('depos');
    }
};
