<?php

namespace App\Repositories\CityCategoryView;

use App\Repositories\BaseRepositoryInterface;

interface CityCategoryViewRepositoryInterface extends BaseRepositoryInterface {
	
    public function recordsByCityNameUri($cityNameUri);

	public function recordsByCityList($cityList) ;
    
}