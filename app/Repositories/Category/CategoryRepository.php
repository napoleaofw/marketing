<?php

namespace App\Repositories\Category;

use App\Repositories\BaseRepository;
use App\Models\Tables\CategoryModel;

class CategoryRepository extends BaseRepository implements CategoryRepositoryInterface {

	public function __construct() {
		parent::__construct(
			CategoryModel::class,
			[]
		);
	}

	public function records() {
		return $this->model::whereNull('category_id')->orderBy('name')->get();
	}

	// public function recordsByCity($cityList) {
	// 	return null;
	// 	// return $this->model::whereNull('category_id')->
	// 	// // I think I'll need to use views here... I don't know yet
	// 	// ->orderBy('name')->get();
	// }

	// public function subcategoryRecordList($idList) {
	// 	return $this->model::whereIn('category_id', $idList)->get();
	// }

}