<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepository;
use App\Models\Views\AdFilterViewModel;

class AdFilterViewRepository extends BaseRepository implements AdFilterViewRepositoryInterface {

	public function __construct() {
		parent::__construct(
			AdFilterViewModel::class,
			[]
		);
	}

}