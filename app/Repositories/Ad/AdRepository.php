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

		$adRecord = AdModel::create($data);
		$phoneRepository->setTransactionStatus(false);
		$phoneRepository = $this->phoneRepository->createWithoutTransaction($phoneData);
	}

	protected function markForReviewRecord($id) {
		$adRecord = $this->readRecord($id);
		if($adRecord->review === 'y') {
			$adRecord->review = 'n';
		}
		else {
			$adRecord->review = 'y';
		}
		return $adRecord->save();
	}

	protected function markForDeleteRecord($id) {
		$adRecord = $this->readRecord($id);
		if($adRecord->delete === 'y') {
			$adRecord->delete = 'n';
		}
		else {
			$adRecord->delete = 'y';
		}
		return $adRecord->save();
	}

	public function markForReview($id) {
		return $this->processTransaction([$this, 'markForReviewRecord'], [$id]);
	}

	public function markForDelete($id) {
		return $this->processTransaction([$this, 'markForDeleteRecord'], [$id]);
	}

	public function readByTitleUri($titleUri) {
		return $this->model::where('title_uri', $titleUri)->first();
	}

}