<?php

namespace App\Commands;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Support\Str;
use LaravelZero\Framework\Commands\Command;

use function Laravel\Prompts\select;

class Setup extends Command
{
    protected $signature = 'setup';

    protected $description = 'Command description';

    private $choices = [
        'php'   => null,
        'nginx' => null,
        'mysql' => null,
    ];

    public function handle()
    {
        $this->info(
            Str::random(24 )
        );
        // $this->choices['php'] = select(
        //     'What PHP version do you want to install?',
        //     ['8.1', '8.2', '8.3'],
        // );
        //
        // $this->php();
    }

    private function php(): void
    {
        $this->info("Installing PHP {$this->choices['php']}");

        $php = "php{$this->choices['php']}";

        exec('add-apt-repository --yes ppa:ondrej/php');
        exec("sed -i 's/mantic/jammy/g' /etc/apt/sources.list.d/ondrej-ubuntu-php-mantic.sources");
        exec('apt update');
        exec("apt install --yes --quiet --quiet {$php} {$php}-fpm");
        exec("service {$php} start");
    }

    private function mysql()
    {
    }

    public function schedule(Schedule $schedule): void
    {
        // $schedule->command(static::class)->everyMinute();
    }
}
