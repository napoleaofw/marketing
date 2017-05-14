<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepositoryInterface;

interface AdDataViewRepositoryInterface extends BaseRepositoryInterface {

    public function recordsByCityAd($cityNameUri, $adId);

}