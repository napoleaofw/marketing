<?php

namespace App\Http\Controllers;

use App\Models\Tables\UserModel;
use DB;
use Exception;
use Hash;
use Response;
use Validator;

class UserController extends CRUDController {

    public function __construct($data=[
        'email' => 'test3@test.com',
        'password' => 'test123',
        'repeatPassword' => 'test123'
    ]) {
        parent::__construct($data, [
            'rules' => [
                'email'          => 'required|unique:USER_TBL,email|email|max:50|min:10',
                'password'       => 'required|max:20|min:5',
                'repeatPassword' => 'required|same:password'
            ],
            'messages' => [],
            'customAttributes' => [
                'email'          => '"E-mail"',
                'password'       => '"Senha"',
                'repeatPassword' => '"Repita a senha"'
            ]
        ]);
    }
    
    protected function createRecord() {
        $recordUser = new UserModel();
        $recordUser->email = $this->_data['email'];
        $recordUser->password = Hash::make($this->_data['password']);
        $recordUser->save();
        return $recordUser;
    }
    
    protected function readRecord() {}
    protected function updateRecord() {}
    protected function deleteRecord() {}

}