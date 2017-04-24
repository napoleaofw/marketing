<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepository;
use App\Repositories\PhoneRepository;
use App\Models\AdModel;

class AdRepository extends BaseRepository implements AdRepositoryInterface {

	public function __construct() {
		parent::__construct(
			AdModel::class,
			[
				'rules' => [
					
				],
				'messages' => [],
				'customAttributes' => [
					
				]
			]
		);
	}

	public function create($data) {
		// return $this->model::create($data);
		/* modo de escrita
		 *	$userRepository
		 *	$userRepositoryList
		 */

		/* criar um extract data
			e um validate data */

		$adModel = AdModel::create($data);
		$phoneRepository->setTransactionStatus(false);
		$phoneRepository = $this->phoneRepository->createWithoutTransaction($phoneData);

	}

}

// Controller

// namespace App\Controllers;

// use App\Repositories\AdRepository;

// class AdController {

// 	private $adRepository;

// 	public function __construct(AdRepository $adRepository) {
// 		$this->adRepository = $adRepository;
// 	}

// 	public function save(Request $request) {
// 		$data = $request->all();
// 		$response = $this->adRepository->create($data);
// 	}

// }