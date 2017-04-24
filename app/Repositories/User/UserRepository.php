<?php

namespace App\Repositories\User;

use App\Repositories\BaseRepository;
use App\Models\Tables\UserModel;
use Hash;

class UserRepository extends BaseRepository implements UserRepositoryInterface {

	public function __construct() {
		parent::__construct(
			UserModel::class,
			[
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
			]
		);
	}

	protected function createRecord($data) {
		$userRecord = new $this->model();
		$userRecord->email = $data['email'];
		$userRecord->password = Hash::make($data['password']);
		$userRecord->save();
		return $userRecord;
	}

	protected function updateRecord($id, $data) {
		$userRecord = $this->read($id);
		$userRecord->email = $data['email'];
		$userRecord->password = Hash::make($data['password']);
		$userRecord->save();
		return $userRecord;
	}

}