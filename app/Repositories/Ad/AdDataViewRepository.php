<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepository;
use App\Models\Views\AdDataViewModel;

class AdDataViewRepository extends BaseRepository implements AdDataViewRepositoryInterface {

	public function __construct() {
		parent::__construct(
			AdDataViewModel::class,
			[]
		);
	}

	public function recordsByCityAd($cityNameUri, $adId) {
        return $this->model::where('city_name_uri', $cityNameUri)->where('ad_id', $adId)->first();
    }

	protected function readRecord($id) {
		return $this->model::where('ad_id', $id)->firstOrFail();
	}

}