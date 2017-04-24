<?php

namespace App\Providers\Services;

use Illuminate\Support\ServiceProvider;
use App\Services\InternalResponse\InternalResponseServiceInterface;
use App\Services\InternalResponse\InternalResponseService;

class InternalResponseServiceProvider extends ServiceProvider {

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
        // $this->app->bind(InternalResponseServiceInterface::class, InternalResponseService::class);
        $this->app->bind('App\Services\InternalResponse\InternalResponseServiceInterface', 'App\Services\InternalResponse\InternalResponseService');
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides() {
        // return [InternalResponseService::class];
        return ['App\Services\InternalResponse\InternalResponseService'];
    }

}