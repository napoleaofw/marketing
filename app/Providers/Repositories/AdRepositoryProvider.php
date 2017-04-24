<?php

namespace App\Providers\Repositories;

use Illuminate\Support\ServiceProvider;
use App\Repositories\Ad\AdRepositoryInterface;
use App\Repositories\Ad\AdRepository;

class AdRepositoryProvider extends ServiceProvider {

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
        $this->app->bind(AdRepositoryInterface::class, AdRepository::class);
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides() {
        return [AdRepository::class];
    }

}