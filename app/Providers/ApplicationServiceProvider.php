<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Services\InternalResponse\InternalResponseServiceInterface;
use App\Services\InternalResponse\InternalResponseService;

class ApplicationServiceProvider extends ServiceProvider {

    /**
     * Indicates if loading of the provider is deferred.
     *
     * @var bool
     */
    protected $defer = true;

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot() {
        //
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register() {
        // dd('register ApplicationServiceProvider');
        $this->app->bind(InternalResponseServiceInterface::class, InternalResponseService::class);
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides() {
        return [
            InternalResponseServiceInterface::class
        ];
    }

}