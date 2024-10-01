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
        Schema::create('stockiests', function (Blueprint $table) {
             $table->id();
            $table->string('stockiest_name');
            $table->string('stockiest_contact_person_name');
            $table->string('contact_number');
            $table->string('stockiest_email_id');
            $table->string('stockiest_address');
            $table->integer('depo_id');
            $table->string('stockiest_arya');
            $table->string('stockiest_user_id');
            $table->string('stockiest_user_password');
            $table->string('stockiest_ref_id');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('stockiests');
    }
};
