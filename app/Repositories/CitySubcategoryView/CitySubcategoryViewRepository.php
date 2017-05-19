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
		return $this->model::select('category_id', 'category_name', 'category_name_uri', 'subcategory_id', 'subcategory_name', 'subcategory_name_uri')->whereIn('city_id', $cityList)->whereIn('category_id', $categoryList)->groupBy('category_id', 'category_name', 'category_name_uri', 'subcategory_id', 'subcategory_name', 'subcategory_name_uri')->orderBy('subcategory_name_uri')->get();
	}

}