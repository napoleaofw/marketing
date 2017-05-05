<?php

namespace App\Http\Controllers\Website;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Repositories\User\UserAuthRepositoryInterface;
use Auth;

class UserController extends Controller {

    public function __construct() {}

    public function loginForm() {
        $data = [
            'pageName' => 'login'
        ];
        return view('website.login', $data);
    }

    public function login(
        Request $request,
        UserAuthRepositoryInterface $userRepository
    ) {
        $response = $userRepository->login($request->all());
        if($response->status() === 200) {
            return redirect('/');
        }
        $dataResponse = $response->getOriginalContent();
        $data = [
            'messages' => $dataResponse['messages'],
            'pageName' => 'login'
        ];
        return view('website.login', $data);
    }

    public function logout() {
        Auth::logout();
        return redirect('/');
    }
    
    // public function registerForm() {
    //     $data = [
    //         'pageName' => 'register'
    //     ];    
    //     return view('website.register', $data);
    // }

    // public function register(Request $request, UserAuthRepositoryInterface $userRepository) {
    //     $response = $userRepository->create($request->all());
    //     $dataResponse = $response->getOriginalContent();
    //     if($response->status() === 200) {
            
    //         // auth
    //         // redirect
    //     }
    //     $data = [
    //         'messages' => $dataResponse['messages'],
    //         'pageName' => 'register'
    //     ];
    //     return view('website.register', $data);
    // }

}