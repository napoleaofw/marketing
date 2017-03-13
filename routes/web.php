<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/home', function () {
    return view('website.layout.home', [
        "pagename" => "home"
    ]);
});

Route::get('/ads', function () {
    return view('website.layout.ads', [
        "pagename" => "ads"
    ]);
});

Route::get('/old', function () {
    return view('website.layout.old.webpage');
});