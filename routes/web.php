<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the 'web' middleware group. Now create something great!
|
*/

Route::get('/', function() {
    $data = [
        'pageName' => 'home'
    ];
    return view('website.'.$data['pageName'], $data);
});
Route::get('/searching', function() {
    $recordsAd = \App\Models\AdDataViewModel::where('city_name_uri', 'dois-irmaos')->get();
    foreach($recordsAd as $key => $recordAd) {
        $recordsPhone = \App\Models\AdPhoneViewModel::where('ad_id', $recordAd->ad_id)->first();
        if(count($recordsPhone) > 0) {
            $recordAd['recordsPhone'] = $recordsPhone;
        }
        else {
            $recordsAd->forget($key);
        }
    }
    $data = [
        'recordsAd' => $recordsAd,
        'pageName' => 'search'
    ];
    return view('website.'.$data['pageName'], $data);
});
Route::get('/search', 'Website\SearchController@process');
// Route::get('/search', function() {
//     $parameters = request()->all();
//     $filters = [
//         'city'        => [],
//         'category'    => [],
//         'subcategory' => [],
//         'facility'    => [],
//         'q'           => ''
//     ];
//     foreach($parameters as $parameter => $value) {
//         if(!array_key_exists($parameter, $filters)){
//             dd('parameter: '.$parameter);
//             abort(404);
//         }
//         else {
//             $filters[$parameter] = $parameter === 'q' ? $value : explode(',', $value);
//         }
//     }
//     $adModel = new \App\Models\AdModel();
//     $adCategoryViewModel = new \App\Models\AdCategoryViewModel();
//     $adCategoryViewModel = $adCategoryViewModel->whereIn('category_name_uri', $filters['category']);
//     $adCategoryViewModel = $adCategoryViewModel->whereIn('main_category_name_uri', $filters['subcategory']);
//     dd($filters);
// });
Route::get('/ad', function() {
    $data = [
        'pageName' => 'ad'
    ];
    return view('website.'.$data['pageName'], $data);
});
Route::get('/login', 'Website\UserController@loginForm');
Route::post('/login', 'Website\UserController@login');
Route::get('/register', 'Website\UserController@registerForm');
Route::post('/register', 'Website\UserController@register');

// Route::get('/', function() {
    
// });

/*Route::get('/user', 'UserController@create');

Route::get('/login', 'Website\UserController@loginForm');
Route::post('/login', 'Website\UserController@login');
Route::get('/register', 'Website\UserController@registerForm');
Route::post('/register', 'Website\UserController@register');
Route::get('/', 'WebsiteController@index');
Route::get('/{cityNameUri}', 'WebsiteController@index');
Route::get('/{cityNameUri}/{adTitleUri}', 'WebsiteController@ad');
Route::get('/{cityNameUri}/category/{categoryNameUri}', 'WebsiteController@search');

Route::get('/ads', function () {
    return view('website.ads', [
        'pagename' => 'ads'
    ]);
});

Route::get('/ads-advanced', function () {
    return view('website.ads-advanced', [
        'pagename' => 'ads-advanced'
    ]);
});

Route::get('/search', function () {
    return view('website.search', [
        'pagename' => 'search'
    ]);
});*/