<?php

namespace App\Repositories\User;

use App\Repositories\Repository;

class UserRepository extends Repository implements UserRepositoryInterface
{

    public function __construct()
    {
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

    public function create($data)
    {
        $validatorResponse = $this->validateData($data, $this->getDataValidator());
        if($this->statusCode !== 200) {
            return $validatorResponse;
        }
        return $this->transact(function($data)
        {
            $recordUser = new UserModel();
            $recordUser->email = $data['email'];
            $recordUser->password = Hash::make($data['password']);
            $recordUser->save();
            return $recordUser;
        });
    }

    public function read($id)
    {
        return $this->transact(function($id)
        {
            return UserModel::findOrFail($id);
        });
    }

    public function update($id, $data)
    {
        $validatorResponse = $this->validateData($data, $this->getDataValidator());
        if($validatorResponse->statusCode !== 200) {
            return $validatorResponse;
        }
        return $this->transact(function($id, $data)
        {
            $recordUser = $this->read($id);
            $recordUser->email = $data['email'];
            $recordUser->password = Hash::make($data['password']);
            $recordUser->save();
            return $recordUser;
        });
    }

    public function delete($id)
    {
        return $this->transact(function($id)
        {
            $recordUser = $this->read($id);
            $recordUser->delete();
            return $recordUser;
        });
    }

}