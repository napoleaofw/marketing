<?php

namespace App\Http\Controllers;

use App\Models\AdDataViewModel;
use App\Models\AdPhoneViewModel;
use App\Models\CityModel;
use App\Models\CityCategoryViewModel;
use App\Exceptions;
use Illumnate\Http\Request;
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
        $this->_data['cityCategoryList'] = $recordsCityCategoryView;
        $this->_data['cityName'] = $recordCity->name;
        $this->_data['pageName'] = 'home';
        return view('website.home', $this->_data);
    }

    public function ad($cityNameUri=null, $adTitle=null) {
        $recordCity = CityModel::where('name_uri', $cityNameUri)->firstOrFail();
        $recordAd = AdDataViewModel::where('city_id', $recordCity->id)->where('ad_title_uri', $adTitle)->firstOrFail();
        $recordsAdPhone = AdPhoneViewModel::where('ad_id', $recordAd->ad_id)->get();
        $this->_data['pageName'] = 'ad';
        $this->_data['recordAd'] = $recordAd;
        $this->_data['recordsAdPhone'] = $recordsAdPhone;
        return view('website.ad', $this->_data);
    }

}