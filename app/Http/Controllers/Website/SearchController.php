<?php

namespace App\Http\Controllers\Website;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Views\AdFilterViewModel;
use DB;

class SearchController extends Controller {

    public function __construct() {}

    public function process(Request $request) {
        $parameters = $request->all();
        $filters = [
            'city'        => [],
            'category'    => [],
            'subcategory' => [],
            'q'           => ''
        ];
        foreach($parameters as $parameter => $value) {
            if(!array_key_exists($parameter, $filters)){
                dd('parameter: '.$parameter);
                abort(404);
            }
            else {
                $filters[$parameter] = $parameter === 'q' ? '%'.$value.'%' : explode(',', $value);
            }
        }
        // DB::enableQueryLog();
        $adFilterViewModel = new AdFilterViewModel();
        if(count($filters['city']) > 0) {
            $adFilterViewModel = $adFilterViewModel->whereIn('city_name_uri', $filters['city']);
        }
        if(count($filters['category']) > 0) {
            $adFilterViewModel = $adFilterViewModel->whereIn('main_category_name_uri', $filters['category']);
        }
        if(count($filters['subcategory']) > 0) {
            $adFilterViewModel = $adFilterViewModel->whereIn('category_name_uri', $filters['subcategory']);
        }
        if(!empty($filters['q'])) {
            $adFilterViewModel = $adFilterViewModel->where('ad_title', 'LIKE', $filters['q']);
        }
        $adRecords = $adFilterViewModel->get();
        // dd(DB::getQueryLog());
        dd($adRecords);
        $data = [
            'pageName' => 'search'
        ];
        return view('website.search', $data);
    }

}