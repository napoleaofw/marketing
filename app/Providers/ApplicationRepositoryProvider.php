<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Repositories\Ad\AdRepositoryInterface;
use App\Repositories\Ad\AdRepository;
use App\Repositories\Ad\AdFilterViewRepositoryInterface;
use App\Repositories\Ad\AdFilterViewRepository;
use App\Repositories\Category\CategoryRepositoryInterface;
use App\Repositories\Category\CategoryRepository;
use App\Repositories\City\CityRepositoryInterface;
use App\Repositories\City\CityRepository;
use App\Repositories\CityCategoryView\CityCategoryViewRepositoryInterface;
use App\Repositories\CityCategoryView\CityCategoryViewRepository;
use App\Repositories\User\UserRepositoryInterface;
use App\Repositories\User\UserRepository;
use App\Repositories\User\UserAuthRepositoryInterface;
use App\Repositories\User\UserAuthRepository;

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
        // dd('register ApplicationRepositoryProvider');
        $this->app->bind(AdRepositoryInterface::class, AdRepository::class);
        $this->app->bind(AdFilterViewRepositoryInterface::class, AdFilterViewRepository::class);
        $this->app->bind(CategoryRepositoryInterface::class, CategoryRepository::class);
        $this->app->bind(CityRepositoryInterface::class, CityRepository::class);
        $this->app->bind(CityCategoryViewRepositoryInterface::class, CityCategoryViewRepository::class);
        $this->app->bind(UserRepositoryInterface::class, UserRepository::class);
        $this->app->bind(UserAuthRepositoryInterface::class, UserAuthRepository::class);
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
            CategoryRepositoryInterface::class,
            CityRepositoryInterface::class,
            CityCategoryViewRepositoryInterface::class,
            UserRepositoryInterface::class,
            UserAuthRepositoryInterface::class
        ];
    }

}