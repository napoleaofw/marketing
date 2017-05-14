<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepositoryInterface;

interface AdPhoneViewRepositoryInterface extends BaseRepositoryInterface {

    public function recordsByAd($id);

}