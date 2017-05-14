<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepository;
use App\Models\Views\AdPhoneViewModel;

class AdPhoneViewRepository extends BaseRepository implements AdPhoneViewRepositoryInterface {

	public function __construct() {
		parent::__construct(
			AdPhoneViewModel::class,
			[]
		);
	}

	public function recordsByAd($id) {
        $adPhoneRecordList = $this->model::where('ad_id', $id)->get();
        foreach($adPhoneRecordList as $adPhoneRecord) {
            $adPhoneRecord['formattedPhone'] = $adPhoneRecord->getFormattedPhone();
        }
        return $adPhoneRecordList;
    }

}