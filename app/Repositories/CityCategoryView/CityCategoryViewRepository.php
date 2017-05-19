<?php

namespace App\Repositories\CityCategoryView;

use App\Repositories\BaseRepository;
use App\Models\Views\CityCategoryViewModel;

class CityCategoryViewRepository extends BaseRepository implements CityCategoryViewRepositoryInterface {

	public function __construct() {
		parent::__construct(
			CityCategoryViewModel::class,
			[]
		);
    }

	public function recordsByCityNameUri($cityNameUri) {
		return $this->model::where('city_name_uri', $cityNameUri)->orderBy('category_name_uri')->get();
	}

	public function recordsByCityList($cityList) {
		return $this->model::select('category_id', 'category_name', 'category_name_uri')->whereIn('city_id', $cityList)->groupBy('category_id', 'category_name', 'category_name_uri')->orderBy('category_name_uri')->get();
	}

}