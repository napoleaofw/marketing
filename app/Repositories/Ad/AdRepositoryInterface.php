<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepositoryInterface;

interface AdRepositoryInterface extends BaseRepositoryInterface {

    public function create($data);

	public function markForReview($id);

	public function markForDelete($id);

}