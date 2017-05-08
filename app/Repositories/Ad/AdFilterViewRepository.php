<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepository;
use App\Models\Views\AdFilterViewModel;
use App\Models\Views\AdDataViewModel;
use App\Models\Views\AdPhoneViewModel;
use Auth;

class AdFilterViewRepository extends BaseRepository implements AdFilterViewRepositoryInterface {

	public function __construct() {
		parent::__construct(
			AdFilterViewModel::class,
			[]
		);
	}

	public function count($filters) {
		$newFilters = [];
		$columns = [
			'city'        => 'city_name_uri',
			'category'    => 'main_category_name_uri',
			'subcategory' => 'category_name_uri',
			'q'           => 'ad_title'
		];
		foreach($filters as $column => $values) {
			$newFilters[$columns[$column]] = $values;
			unset($filters[$column]);
		}
		$query = new $this->model();
		foreach($newFilters as $column => $values) {
			if($column !== $columns['q'])
				$query = $query->whereIn($column, $values);
			else
				$query = $query->where($column, 'LIKE', $values);
		}
		return $query->count();
	}

	public function recordList($filters, $limit, $offset) {
		$newFilters = [];
		$columns = [
			'city'        => 'city_name_uri',
			'category'    => 'main_category_name_uri',
			'subcategory' => 'category_name_uri',
			'q'           => 'ad_title'
		];
		foreach($filters as $column => $values) {
			$newFilters[$columns[$column]] = $values;
			unset($filters[$column]);
		}
		$query = new $this->model();
		foreach($newFilters as $column => $values) {
			if($column !== $columns['q'])
				$query = $query->whereIn($column, $values);
			else
				$query = $query->where($column, 'LIKE', $values);
		}
		if(!Auth::user()) {
			$query = $query->where('ad_review', 'n')->where('ad_delete', 'n');
		}
		$adFilterRecordList = $query->limit($limit)->offset($offset)->orderBy('ad_review')->orderBy('ad_delete')->orderBy('ad_title')->get();
		$adRecordList = [];
		foreach($adFilterRecordList as $adFilterRecord) {
			$adRecord = AdDataViewModel::where('ad_id', $adFilterRecord->ad_id)->firstOrFail();
			$phoneRecordList = AdPhoneViewModel::where('ad_id', $adRecord->ad_id)->first();
			$adRecord['phoneRecordList'] = !!$phoneRecordList ? [$phoneRecordList] : [];
			array_push($adRecordList, $adRecord);
		}
		return $adRecordList;
	}

}