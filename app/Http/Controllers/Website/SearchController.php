<?php

namespace App\Http\Controllers\Website;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Repositories\Ad\AdFilterViewRepository;
// use App\Models\Views\AdFilterViewModel;
// use DB;

class SearchController extends Controller {

    private $parameters;

    public function __construct() {
        $this->parameters = [
            'city' => [
                'filter'     => true,
                'filterName' => 'city_name_uri'
            ],
            'category' => [
                'filter' => true,
                'filterName' => 'category_name_uri'
            ],
            'subcategory' => [
                'filter' => true,
                'filterName' => 'subcategory_name_uri'
            ],
            'q' => [
                'filter' => true,
                'filterName' => 'ad_title_uri'
            ],
            'page' => [
                'filter' => false
            ]
        ];
    }

    public function process(Request $request, AdFilterViewRepository $adFilterViewRepository) {
        $filters = [];
        $parameters = $request->all();
        foreach($parameters as $parameter => $value) {
            if(!array_key_exists($parameter, $this->parameters)){
                abort(404);
            }
            else {
                if($this->parameters[$parameter]['filter'] === true) {
                    $filters[$this->parameters[$parameter]['filterName']] = $parameter == 'q' ? '%' . $value . '%' : explode(',', $value);
                }
            }
        }
        whiskas.com.br/search?city=dois-irmaos,morro-reuter&category=animais&subcategory=veterinarios&q=animais%20loucos&page=2
        $limit = 25;
        $offset = ($parameters['page'] || 1) * $limit;
        // validate page as number...
        $adRecords = $adFilterViewRepository->list($filters, $limit, $offset);
        // DB::enableQueryLog();
        // $adFilterViewModel = new AdFilterViewModel();
        // if(count($filters['city']) > 0) {
        //     $adFilterViewModel = $adFilterViewModel->whereIn('city_name_uri', $filters['city']);
        // }
        // if(count($filters['category']) > 0) {
        //     $adFilterViewModel = $adFilterViewModel->whereIn('main_category_name_uri', $filters['category']);
        // }
        // if(count($filters['subcategory']) > 0) {
        //     $adFilterViewModel = $adFilterViewModel->whereIn('category_name_uri', $filters['subcategory']);
        // }
        // if(!empty($filters['q'])) {
        //     $adFilterViewModel = $adFilterViewModel->where('ad_title', 'LIKE', $filters['q']);
        // }
        // $adRecords = $adFilterViewModel->get();
        // dd(DB::getQueryLog());
        // dd($adRecords);
        $data = [
            'pageName' => 'search'
        ];
        return view('website.search', $data);
    }

}