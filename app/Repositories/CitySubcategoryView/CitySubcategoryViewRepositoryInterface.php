<?php

namespace App\Repositories\CitySubcategoryView;

use App\Repositories\BaseRepositoryInterface;

interface CitySubcategoryViewRepositoryInterface extends BaseRepositoryInterface {
    
    public function recordsByCityCategoryList($cityList, $categoryList);

}