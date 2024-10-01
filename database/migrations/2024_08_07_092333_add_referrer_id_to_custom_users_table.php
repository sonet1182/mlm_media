<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddReferrerIdToCustomUsersTable extends Migration
{
    public function up()
    {
        Schema::table('custom_users', function (Blueprint $table) {
            $table->unsignedBigInteger('referrer_id')->nullable()->after('id');
            $table->foreign('referrer_id')->references('id')->on('custom_users')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::table('custom_users', function (Blueprint $table) {
            $table->dropForeign(['referrer_id']);
            $table->dropColumn('referrer_id');
        });
    }
}

