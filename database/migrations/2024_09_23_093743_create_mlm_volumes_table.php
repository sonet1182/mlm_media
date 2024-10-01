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
        Schema::create('mlm_volumes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->decimal('left_leg_volume', 15, 2)->default(0);    // Total volume for the left leg
            $table->decimal('right_leg_volume', 15, 2)->default(0);   // Total volume for the right leg
            $table->decimal('left_leg_carried_over', 15, 2)->default(0);  // Carried over volume for left leg
            $table->decimal('right_leg_carried_over', 15, 2)->default(0); // Carried over volume for right leg
            $table->timestamps();
        
            $table->foreign('user_id')->references('id')->on('custom_users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mlm_volumes');
    }
};
