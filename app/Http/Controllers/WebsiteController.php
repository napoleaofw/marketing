<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\City\CityRepositoryInterface;
use App\Repositories\CityCategoryView\CityCategoryViewRepositoryInterface;
use Auth;

class WebsiteController extends Controller {

    public function __construct() {}

    public function home(
        CityRepositoryInterface $cityRepository,
        CityCategoryViewRepositoryInterface $cityCategoryViewRepository,
        $cityNameUri = null
    ) {
        dd(Auth::user());
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

}