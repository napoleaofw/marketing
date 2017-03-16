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
    return redirect('home');
});

Route::get('/home', function () {
    return view('website.home', [
        'pagename' => 'home'
    ]);
});

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
});