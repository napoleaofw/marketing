<?php

namespace App\Repositories\City;

use App\Repositories\BaseRepository;
use App\Models\Tables\CityModel;

class CityRepository extends BaseRepository implements CityRepositoryInterface {

	public function __construct() {
		parent::__construct(
			CityModel::class,
			[]
		);
	}

	public function records() {
		return $this->model::orderBy('name')->get();
	}

}