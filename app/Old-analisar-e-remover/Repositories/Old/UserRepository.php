<?php

namespace App\Repositories;

class UserRepository extends Repository {

    public function __construct() {
        parent::__construct();
        $this->dataValidator = [
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
        ];
    }
    
    protected function create($data) {
        $recordUser = new UserModel();
        $recordUser->email = $data['email'];
        $recordUser->password = Hash::make($data['password']);
        $recordUser->save();
        return $recordUser;
    }

    protected function read($data) {
        return UserModel::findOrFail($data['id']);
    }

    protected function update($data) {
        $recordUser = $this->read($data);
        $recordUser->email = $data['email'];
        $recordUser->password = Hash::make($data['password']);
        $recordUser->save();
        return $recordUser;
    }

    protected function delete($data) {
        $recordUser = $this->read($data);
        $recordUser->delete();
        return $recordUser;
    }

}