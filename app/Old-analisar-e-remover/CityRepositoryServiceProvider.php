<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class CityRepositoryServiceProvider extends ServiceProvider {

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
        $this->app->bind('App\Repositories\City\CityRepositoryInterface', 'App\Repositories\City\CityRepository');
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides() {
        return ['App\Repositories\City\CityRepository'];
    }

}