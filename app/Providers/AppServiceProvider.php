<?php

namespace App\Providers;

use App\Models\Setting;
use Illuminate\Support\Facades\View;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\ServiceProvider;
use Filament\Facades\Filament;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        //
    }

    public function boot(): void
    {
        Filament::serving(function () {
            Filament::registerRenderHook(
                'panels::auth.logout.after',
                fn () => redirect('/')
            );
        });

        if (Schema::hasTable('settings')) {
            View::share('settings', Setting::first());
        }
    }
}