<?php

namespace App\Repositories\CitySubcategoryView;

use App\Repositories\BaseRepository;
use App\Models\Views\CitySubcategoryViewModel;

class CitySubcategoryViewRepository extends BaseRepository implements CitySubcategoryViewRepositoryInterface {

	public function __construct() {
		parent::__construct(
			CitySubcategoryViewModel::class,
			[]
		);
    }

	public function recordsByCityCategoryList($cityList, $categoryList) {
		return $this->model::whereIn('city_id', $cityList)->whereIn('category_id', $categoryList)->orderBy('subcategory_name_uri')->get();
	}

}