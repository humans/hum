<?php

namespace App\Commands;

use Illuminate\Console\Scheduling\Schedule;
use LaravelZero\Framework\Commands\Command;

use function Laravel\Prompts\select;

class Setup extends Command
{
    protected $signature = 'setup';

    protected $description = 'Command description';

    public function handle()
    {
        $php = select(
            'What PHP version do you want to install?',
            ['8.1', '8.2', '8.3'],
        );

        $this->info("Installing PHP {$php}");

        // exec('apt install --yes --quiet --quiet php');
    }

    public function schedule(Schedule $schedule): void
    {
        // $schedule->command(static::class)->everyMinute();
    }
}
