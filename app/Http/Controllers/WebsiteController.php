<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Ad\AdRepositoryInterface;
use App\Repositories\Ad\AdFilterViewRepositoryInterface;
use App\Repositories\Ad\AdDataViewRepositoryInterface;
use App\Repositories\Ad\AdPhoneViewRepositoryInterface;
use App\Repositories\Category\CategoryRepository;
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

    public function edit(
        AdDataViewRepositoryInterface $adDataViewRepository,
        AdPhoneViewRepositoryInterface $adPhoneViewRepository,
        AdFilterViewRepositoryInterface $adFilterViewRepository,
        CityRepositoryInterface $cityRepository,
        CategoryRepository $categoryRepository,
        $adId=null
    ) {
        if(!Auth::user()) {
            abort(404);
        }
        $data = [];
        if(!session('data')) {
            if($adId) {
                $response = $adDataViewRepository->read($adId);
                if($response->status() !== 200) {
                    abort(404);
                }
                $dataResponse = $response->getOriginalContent();
                $adRecord = $dataResponse['data'];
                $adRecord['adPhoneRecordList'] = $adPhoneViewRepository->recordsByAd($adId);
                $cityRecordList = $cityRepository->records();
                $adCategoryData = $adFilterViewRepository->dataByAd($adRecord->ad_id);
                $categoryRecordList = $categoryRepository->records();
                $subcategoryRecordList = $categoryRepository->recordsByCategory($adCategoryData->main_category_id);
            }
            else {
                $adRecord = [];
                $cityRecordList = $cityRepository->records();
                $adCategoryData = [];
                $categoryRecordList = $categoryRepository->records();
                $subcategoryRecordList = [];
            }
            $data = [
                'adRecord' => $adRecord,
                'adCategoryData' => $adCategoryData,
                'cityRecordList' => $cityRecordList,
                'categoryRecordList' => $categoryRecordList,
                'subcategoryRecordList' => $subcategoryRecordList,
                'pageName' => 'edit'
            ];
        }
        else {
            $data = session('data');
        }
        return view('website.edit', $data);
    }

    private function createTitleUri($title) {
        $clean = iconv('UTF-8', 'ASCII//TRANSLIT', $title);
        $clean = preg_replace("/[^a-zA-Z0-9\/_|+ -]/", '', $clean);
        $clean = strtolower(trim($clean, '-'));
        $clean = preg_replace("/[\/_|+ -]+/", '-', $clean);
        return $clean;
    }

    public function save(
        Request $request,
        AdRepositoryInterface $adRepository,
        AdDataViewRepositoryInterface $adDataViewRepository,
        AdPhoneViewRepositoryInterface $adPhoneViewRepository,
        AdFilterViewRepositoryInterface $adFilterViewRepository,
        CityRepositoryInterface $cityRepository,
        CategoryRepository $categoryRepository,
        $adId = null
    ) {
        $create = false;
        if(!$adId) {
            $create = true;
        }
        $input = $request->all();
        $dataAdRecord = [
            'id'                 => $adId,
            'city_id'            => $input['city'],
            'title'              => $input['title'],
            'title_uri'          => $this->createTitleUri($input['title']),
            'short_description'  => $input['short_description'],
            'description'        => $input['description'],
            'district'           => $input['district'],
            'address'            => $input['address'],
            'address_number'     => $input['address_number'],
            'address_complement' => $input['address_complement'],
            'postal_code'        => $input['postal_code'],
            'map_latitude'       => $input['map_latitude'],
            'map_longitude'      => $input['map_longitude'],
            'category'           => [
                'id' => isset($input['subcategory']) && $input['subcategory'] ? $input['subcategory'] : $input['category']
            ],
            'phone'              => $input['phone']
        ];
        $response = $adRepository->processSave($dataAdRecord);
        $dataResponse = $response->getOriginalContent();
        $messages = $dataResponse['messages'];
        if($response->status() === 200) {
            $adId = $dataResponse['data']->id;
            $adRecord = $adDataViewRepository->read($adId)->getOriginalContent()['data'];
            $adRecord['adPhoneRecordList'] = $adPhoneViewRepository->recordsByAd($adId);
            $cityRecordList = $cityRepository->records();
            $adCategoryData = $adFilterViewRepository->dataByAd($adRecord->ad_id);
            $categoryRecordList = $categoryRepository->records();
            $subcategoryRecordList = $categoryRepository->recordsByCategory($adCategoryData->main_category_id);
        }
        else {
            $oldInput = $input;
            $adRecord = [];
            $cityRecordList = $cityRepository->records();
            $adCategoryData = [];
            $categoryRecordList = $categoryRepository->records();
            if($oldInput['category']) {
                $subcategoryRecordList = $categoryRepository->recordsByCategory($oldInput['category']);
            }
            else {
                $subcategoryRecordList = [];
            }
        }
        $data = [
            'oldInput' => isset($oldInput) ? $oldInput : [],
            'messages' => $messages,
            'adRecord' => $adRecord,
            'adCategoryData' => $adCategoryData,
            'cityRecordList' => $cityRecordList,
            'categoryRecordList' => $categoryRecordList,
            'subcategoryRecordList' => $subcategoryRecordList,
            'pageName' => 'edit'
        ];
        if($create) {
            if($response->status() === 200) {
                return redirect('/edit/'.$adId)->with('data', $data);
            }
            return view('website.edit', $data);
        }
        return view('website.edit', $data);
    }

}