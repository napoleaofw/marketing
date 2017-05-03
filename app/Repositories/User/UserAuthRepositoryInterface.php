<?php

namespace App\Repositories\User;

use App\Repositories\BaseRepositoryInterface;

interface UserAuthRepositoryInterface extends BaseRepositoryInterface {

    public function login($data);

}