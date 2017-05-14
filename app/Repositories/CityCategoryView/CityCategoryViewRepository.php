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
		return $this->model::whereIn('city_id', $cityList)->orderBy('category_name_uri')->get();
	}

}