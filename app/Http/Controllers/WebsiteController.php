<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\CityRepository;
use App\Repositories\UserRepository;

class WebsiteController extends Controller {

    private $userRepository;
    private $cityRepository;

    public function __construct(CityRepository $cityRepository, UserRepository $userRepository) {
        $this->userRepository = $userRepository;
        $this->cityRepository = $cityRepository;
    }

    public function home($cityNameUri=null) {
        if(!$cityNameUri) {
            $cityNameUri = 'dois-irmaos';
        }
        ///// here continue
        $recordCity = CityModel::where('name_uri', $cityNameUri)->firstOrFail();
        $recordsCityCategoryView = CityCategoryViewModel::where('city_name_uri', $cityNameUri)->orderBy('category_name_uri')->get();
        $recordsCity = CityModel::all()->sortBy('name');
        $this->_data['cityCategoryList'] = $recordsCityCategoryView;
        $this->_data['cityName'] = $recordCity->name;
        $this->_data['pageName'] = 'home';
        $this->_data['recordsCity'] = $recordsCity;
        $data = [
            'cityCategoryList' => ,
            'cityName'         => ,
            'pageName'         => ,
            'recordsCity'      => 
        ];
        return view('website.'.$this->_data['pageName'], $data);
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

    public function register(Request $request) {
        dd($this->userRepository);
        $response = $this->userRepository->createRecord($request->all());
        dd($response);
    }

}