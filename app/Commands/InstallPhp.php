<?php

namespace App\Commands;

use Illuminate\Console\Scheduling\Schedule;
use LaravelZero\Framework\Commands\Command;

use function Laravel\Prompts\select;

class InstallPhp extends Command
{
    protected $signature = 'install:php';

    protected $description = 'Command description';

    public function handle()
    {
        $version = select(
            'What PHP version do you want to install?',
            ['8.1', '8.2', '8.3'],
        );

        $this->info("Installing PHP {$version['php']}");

        $php = "php{$version['php']}";

        exec('add-apt-repository --yes ppa:ondrej/php');
        exec("sed -i 's/mantic/jammy/g' /etc/apt/sources.list.d/ondrej-ubuntu-php-mantic.sources");
        exec('apt update');
        exec("apt install --yes --quiet --quiet {$php} {$php}-fpm");
        exec("service {$php} start");
    }

    public function schedule(Schedule $schedule): void
    {
    }
}
