<?php

namespace App\Repositories\User;

use App\Repositories\BaseRepository;
use App\Models\Authentication\UserAuthModel;
use Auth;
use Hash;

class UserAuthRepository extends BaseRepository implements UserAuthRepositoryInterface {

	public function __construct() {
		parent::__construct(
			UserAuthModel::class,
			[
				'rules' => [
					'email'    => 'required|email',
					'password' => 'required'
				],
				'messages' => [],
				'customAttributes' => [
					'email'    => '"E-mail"',
					'password' => '"Senha"'
				]
			]
		);
	}

    protected function loginRecord($data) {
		$userRecord = $this->model::where('email', $data['email'])->first();
		if($userRecord) {
			if(Hash::check($data['password'], $userRecord->password)) {
                Auth::login($userRecord);
                return $userRecord;
			}
			$this->internalResponse->setStatusCode(401);
			$this->internalResponse->setMessages('error', ['Senha incorreta para o usuário ' . $data['email'] . '.']);
            $this->internalResponse->make();
		}
		else {
			$this->internalResponse->setStatusCode(401);
			$this->internalResponse->setMessages('error', ['O usuário '. $data['email'] . ' não existe.']);
            $this->internalResponse->make();
		}
    }

    public function login($data) {
		return ($this->validateData($data) ? $this->processTransaction([$this, 'loginRecord'], [$data]) : $this->internalResponse->make());
    }

}