<?php

namespace App\Console\Commands;

use App\Http\Controllers\Admin\EqualBonusController;
use Illuminate\Console\Command;

class DistributeDailyBonuses extends Command
{
    protected $signature = 'bonuses:distribute-daily'; // Command signature
    protected $description = 'Distribute daily bonuses based on yesterday\'s sales';

    // public function __construct()
    // {
    //     parent::__construct();
    // }

    public function handle()
    {
        // Create an instance of the class where distributeDailyBonuses is defined
        $controller = new EqualBonusController(); // Replace with your actual class
        $controller->distributeDailyBonuses();

        $this->info('Daily bonuses distributed.');
    }
}
