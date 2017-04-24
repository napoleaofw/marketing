<?php

namespace App\Http\Controllers;

use App\Models\AdCategoryViewModel;
use App\Models\AdDataViewModel;
use App\Models\AdMainCategoryViewModel;
use App\Models\AdPhoneViewModel;
use App\Models\CategoryModel;
use App\Models\CityModel;
use App\Models\CityCategoryViewModel;
use App\Models\UserAuthModel;
use App\Models\UserModel;
use App\Exceptions;
use Illuminate\Http\Request;
use Illuminate\Support\Collection;
use Auth;
use DB;
use Exception;
use Hash;
use Session;

class HomeController extends Controller {

    private $_data;
    private $_defaultCity = 'dois-irmaos';
    private $_request;

    public function __construct(Request $request) {
        // parent::__construct();
        $this->_request  = $request;
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
        try {
            $input = $this->_request->all();
            if(!isset($input['email']) || !isset($input['password'])) {
                throw new Exception();
            }
            $rules = [
                'email'    => 'required|email',
                'password' => 'required'
            ];
            $names = [
                'email'    => '"E-mail"',
                'password' => '"Senha'
            ];
            $this->validate($this->_request, $rules, [], $names);
            $this->_request->flash();
            $auth = UserAuthModel::where('email', $input['email'])->first();
            if($auth) {       
                if(Hash::check($input['password'], $auth->password)) {
                    Auth::login($auth);
                    return redirect('/');
                }
                Session::flash('transaction_error', 'Senha incorreta para o usuário "'.$input['email'].'".');
            }
            else {
                Session::flash('transaction_error', 'Nenhum usuário foi encontrado com este endereço de e-mail.');
            }
        }
        catch(\Exception $e) {
            Session::flash('transaction_error', 'Erro inesperado. Recarregue a página e tente novamente.'.$e);
        }
        return redirect('/login');
    }

    public function formLogin() {
        $this->_data['pageName'] = 'login';
        return view('website.'.$this->_data['pageName'], $this->_data);
    }

    public function register() {
        try {
            $input = $this->_request->all();
            if(!isset($input['email']) || !isset($input['password']) || !isset($input['repeat_password'])) {
                throw new Exception();
            }
            $rules = [
                'email'           => 'required|unique:USER_TBL,email|email|max:100|min:10',
                'password'        => 'required|max:100|min:5',
                'repeat_password' => 'required|same:password'
            ];
            $names = [
                'email'           => '"E-mail"',
                'password'        => '"Senha"',
                'repeat_password' => '"Confirme a senha"'
            ];
            $this->validate($request, $rules, [], $names);
            $this->_request->flash();
            $auth = DB::transaction(function() use ($input) {
                $recordUser = UserModel::create([
                    'email'    => $input['email'],
                    'password' => Hash::make($input['password'])
                ]);
                $auth = UserAuthModel::find($recordUser->id);
                return $auth;
            });
            Auth::login($auth);
            return redirect('/');
        }
        catch(\PDOException $e) {
            Session::flash('transaction_error', 'Ocorreu um erro na tentativa de salvar os dados.');
        }
        catch(\Exception $e) {
            Session::flash('transaction_error', 'Erro inesperado.');
        }
        return redirect('/register');

    }

    public function formRegister() {
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