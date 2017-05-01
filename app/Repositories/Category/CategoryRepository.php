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

}