<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Repositories\Ad\AdRepositoryInterface;
use App\Repositories\Ad\AdRepository;
use App\Repositories\Ad\AdFilterViewRepositoryInterface;
use App\Repositories\Ad\AdFilterViewRepository;
use App\Repositories\City\CityRepositoryInterface;
use App\Repositories\City\CityRepository;
use App\Repositories\User\UserRepositoryInterface;
use App\Repositories\User\UserRepository;

class ApplicationRepositoryProvider extends ServiceProvider {

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
        $this->app->bind(AdFilterViewRepositoryInterface::class, AdFilterViewRepository::class);
        $this->app->bind(CityRepositoryInterface::class, CityRepository::class);
        $this->app->bind(UserRepositoryInterface::class, UserRepository::class);
    }

    /**
     * Get the services provided by the provider.
     *
     * @return array
     */
    public function provides() {
        return [
            AdRepositoryInterface::class,
            AdFilterViewRepositoryInterface::class,
            CityRepositoryInterface::class,
            UserRepositoryInterface::class
        ];
    }

}