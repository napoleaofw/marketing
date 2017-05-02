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
Route::get('/searching', function() {
    $recordsAd = \App\Models\Views\AdDataViewModel::where('city_name_uri', 'dois-irmaos')->get();
    foreach($recordsAd as $key => $recordAd) {
        $recordsPhone = \App\Models\Views\AdPhoneViewModel::where('ad_id', $recordAd->ad_id)->first();
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
Route::get('/login', 'Website\UserController@loginForm');
Route::post('/login', 'Website\UserController@login');
// Route::get('/register', 'Website\UserController@registerForm');
// Route::post('/register', 'Website\UserController@register');
Route::get('/', 'WebsiteController@home');
Route::get('/{cityNameUri}', 'WebsiteController@home');
// Route::get('/ad', function() {
//     $data = [
//         'pageName' => 'ad'
//     ];
//     return view('website.'.$data['pageName'], $data);
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
*/