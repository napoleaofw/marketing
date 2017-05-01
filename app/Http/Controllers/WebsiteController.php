<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\City\CityRepositoryInterface;
use App\Repositories\CityCategoryView\CityCategoryViewRepositoryInterface;
use App\Repositories\User\UserRepositoryInterface;

class WebsiteController extends Controller {

    public function __construct() {}

    public function home(
        CityRepositoryInterface $cityRepository,
        CityCategoryViewRepositoryInterface $cityCategoryViewRepository,
        $cityNameUri = null
    ) {
        if(!$cityNameUri) {
            $cityNameUri = 'dois-irmaos';
        }
        $cityRecord = $cityRepository->readByNameUri($cityNameUri);
        $cityRecordList = $cityRepository->records();
        $cityCategoryViewRecordList = $cityCategoryViewRepository->recordsByCityNameUri($cityNameUri);
        $data = [
            'cityCategoryRecordList' => $cityCategoryViewRecordList,
            'currentCity'            => $cityRecord,
            'pageName'               => 'home',
            'cityRecordList'         => $cityRecordList
        ];
        return view('website.home', $data);
    }

    public function loginForm() {
        $data = [
            'pageName' => 'login'
        ];
        return view('website.login', $data);
    }

    public function login(Request $request) {
        dd('login post success');
    }

    public function registerForm() {
        $data = [
            'pageName' => 'register'
        ];    
        return view('website.register', $data);
    }

    public function register(
        Request $request,
        UserRepositoryInterface $userRepository
    ) {
        dd($userRepository);
        $response = $userRepository->createRecord($request->all());
        dd($response);
    }

}