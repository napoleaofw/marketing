<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Ad\AdDataViewRepositoryInterface;
use App\Repositories\Ad\AdPhoneViewRepositoryInterface;
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
        if(!$cityNameUri) {
            $cityNameUri = 'dois-irmaos';
        }
        $cityRecord = $cityRepository->readByNameUri($cityNameUri);
        if(!$cityRecord) {
            abort(404);
        }
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

    public function ad(
        AdDataViewRepositoryInterface $adDataViewRepository,
        AdPhoneViewRepositoryInterface $adPhoneViewRepository,
        $cityNameUri,
        $adId
    ) {
        $adRecord = $adDataViewRepository->recordsByCityAd($cityNameUri, $adId);
        //$adRecord = AdDataViewModel::where('city_name_uri', $cityNameUri)->where('ad_title_uri', $adTitleUri)->first();
        if(!$adRecord) {
            abort(404);
        }
        $adPhoneRecordList = $adPhoneViewRepository->recordsByAd($adRecord->ad_id);
        //$adPhoneRecordList = AdPhoneViewModel::where('ad_id', $adRecord->ad_id)->get();
        $adRecord['adPhoneRecordList'] = $adPhoneRecordList;
        $data = [
            'pageName' => 'ad',
            'adRecord' => $adRecord
        ];
        return view('website.ad', $data);
    }

}