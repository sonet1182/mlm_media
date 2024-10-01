<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('total_bonus_points', function (Blueprint $table) {
            $table->id(); // Primary key, auto-incrementing
            $table->integer('user_id');
            $table->decimal('purchase_bonus', 15, 2)->default(0);
            $table->decimal('creating_bonus', 15, 2)->default(0);
            $table->decimal('refer_bonus', 15, 2)->default(0);
            $table->decimal('rank_reward_bonus', 15, 2)->default(0);
            $table->decimal('captainship_bonus', 15, 2)->default(0);
            $table->decimal('after_death_allowance', 15, 2)->default(0);
            $table->decimal('company_profit_share', 15, 2)->default(0);
            $table->timestamps(); // Created at & updated at timestamps
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('total_bonus_points');
    }
};
