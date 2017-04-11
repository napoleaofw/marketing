<?php

namespace App\Http\Controllers;

use App\Models\AdCategoryViewModel;
use App\Models\AdDataViewModel;
use App\Models\AdMainCategoryViewModel;
use App\Models\AdPhoneViewModel;
use App\Models\CategoryModel;
use App\Models\CityModel;
use App\Models\CityCategoryViewModel;
use App\Exceptions;
use Illumnate\Http\Request;
use Illuminate\Support\Collection;
use DB;
use Session;

class HomeController extends Controller {

    private $_data;
    private $_defaultCity = 'dois-irmaos';

    public function __construct() {
        // parent::__construct();
    }

    public function index($cityNameUri=null) {
        if(!$cityNameUri) {
            $cityNameUri = $this->_defaultCity;
        }
        $recordCity = CityModel::where('name_uri', $cityNameUri)->firstOrFail();
        $recordsCityCategoryView = CityCategoryViewModel::where('city_name_uri', $cityNameUri)->orderBy('category_name_uri')->get();
        $recordsCity = CityModel::all()->sortBy('name');
        $this->_data['cityCategoryList'] = $recordsCityCategoryView;
        $this->_data['cityName'] = $recordCity->name;
        $this->_data['pageName'] = 'home';
        $this->_data['recordsCity'] = $recordsCity;
        return view('website.'.$this->_data['pageName'], $this->_data);
    }

    public function login() {
        $this->_data['pageName'] = 'login';
        return view('website.'.$this->_data['pageName'], $this->_data);
    }

    public function register() {
        $this->_data['pageName'] = 'register';
        return view('website.'.$this->_data['pageName'], $this->_data);
    }

    public function ad($cityNameUri=null, $adTitleUri=null) {
        $recordCity = CityModel::where('name_uri', $cityNameUri)->firstOrFail();
        $recordAd = AdDataViewModel::where('city_id', $recordCity->id)->where('ad_title_uri', $adTitleUri)->firstOrFail();
        $recordsAdPhone = AdPhoneViewModel::where('ad_id', $recordAd->ad_id)->get();
        $this->_data['pageName'] = 'ad';
        $this->_data['recordAd'] = $recordAd;
        $this->_data['recordsAdPhone'] = $recordsAdPhone;
        return view('website.'.$this->_data['pageName'], $this->_data);
    }

    public function search($cityNameUri, $categoryNameUri) {
        $recordCity = CityModel::where('name_uri', $cityNameUri)->firstOrFail();
        $recordCategory = CategoryModel::where('name_uri', $categoryNameUri)->firstOrFail();
        $recordsAdMainCategory = AdMainCategoryViewModel::where('main_category_id', $recordCategory->id)->get();
        $recordsAd = Collection::make([]);
        foreach($recordsAdMainCategory as $recordAdMainCategory) {
            $recordsAd->push(AdDataViewModel::where('ad_id', $recordAdMainCategory->ad_id)->get());
        }
        dd($recordsAd->forPage(1, 10));
        // $recordsAd = AdCategoryViewModel::where('city_id', $recordCity->id)->where('category_id', $recordCategory->id)->orderBy('ad_title_uri')->get();
        // $recordsCategory = CategoryModel::where('category_id', null)->orderBy('name_uri')->get();
        // $recordsCity = CityModel::orderBy('name_uri')->get();
        // $this->_data['pageName'] = 'search';
        // $this->_data['recordsAd'] = $recordsAd;
        // $this->_data['filter'] = [
        //     'recordsCategory' => $recordsCategory,
        //     'recordsCity' => $recordsCity
        // ];
        return view('website.'.$this->_data['pageName'], $this->_data);
    }

}