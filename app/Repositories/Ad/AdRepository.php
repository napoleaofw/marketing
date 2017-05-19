<?php

namespace App\Repositories\Ad;

use App\Repositories\BaseRepository;
use App\Repositories\PhoneRepository;
use App\Models\Tables\AdModel;
use App\Models\Tables\AdCategoryModel;
use App\Models\Tables\AdPhoneModel;
use App\Models\Tables\PersonModel;
use App\Models\Tables\PhoneModel;
use App\Models\Tables\UserModel;

class AdRepository extends BaseRepository implements AdRepositoryInterface {

	public function __construct() {
		parent::__construct(
			AdModel::class,
			[
				'rules' => [
					'title'              => 'required|max:100',
					'city_id'            => 'required',
					'short_description'  => 'max:250',
					'description'        => 'max:800',
					'district'           => 'required|max:80',
					'address'            => 'required|max:100',
					'address_number'     => 'max:50',
					'address_complement' => 'max:50',
					'postal_code'        => 'numeric|digits_between:6,20|nullable',
					'map_latitude'       => 'numeric|digits_between:1,10|nullable',
					'map_longitude'      => 'numeric|digits_between:1,11|nullable',
					'category.id'        => 'required',
					'phone.1'            => 'numeric|digits_between:8,20|nullable',
					'phone.2'            => 'numeric|digits_between:8,20|nullable',
					'phone.3'            => 'numeric|digits_between:8,20|nullable',
					'phone.4'            => 'numeric|digits_between:8,20|nullable',
					'phone.5'            => 'numeric|digits_between:8,20|nullable',
				],
				'messages' => [],
				'customAttributes' => [
					'title'              => 'Título',
					'city_id'            => 'Cidade',
					'short_description'  => 'Descrição resumida',
					'description'        => 'Descrição',
					'district'           => 'Bairro',
					'address'            => 'Endereço',
					'address_number'     => 'Número',
					'address_complement' => 'Complemento',
					'postal_code'        => 'CEP',
					'map_latitude'       => 'Latitude',
					'map_longitude'      => 'Longitude',
					'category.id'        => 'Categoria',
					'phone.1'            => 'Telefone 1',
					'phone.2'            => 'Telefone 2',
					'phone.3'            => 'Telefone 3',
					'phone.4'            => 'Telefone 4',
					'phone.5'            => 'Telefone 5'
				]
			]);
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

	public function processRecord($data) {
		$userRecord = UserModel::where('email', 'contato.wnap@gmail.com')->first();
		$personRecord = PersonModel::where('user_id', $userRecord->id)->first();
		$data['person_id'] = $personRecord->id;
		$categoryData = $data['category'];
		$phoneData = $data['phone'];
		unset($data['category']);
		unset($data['phone']);
		$adRecord;
		if($data['id']) {
			$adRecord = AdModel::find($data['id']);
			$adRecord->fill($data)->save();
			$phoneRecordList = AdPhoneModel::where('ad_id', $adRecord->id)->get();
			$phoneDeletedList = [];
			foreach($phoneRecordList as $phoneRecord) {
				$phoneId = $phoneRecord->phone_id;
				$phoneRecord->delete();
				$phoneRecord = PhoneModel::find($phoneId)->delete();
			}
			foreach($phoneData as $key => $phone) {
				if($phone) {
					$phoneRecord = PhoneModel::create([
						'phone' => $phone
					]);
					AdPhoneModel::create([
						'ad_id'    => $adRecord->id,
						'phone_id' => $phoneRecord->id,
						'sequence' => $key
					]);
				}
			}
			AdCategoryModel::where('ad_id', $adRecord->id)->delete();
			AdCategoryModel::create([
				'ad_id'       => $adRecord->id,
				'category_id' => $categoryData['id'],
			]);
		}
		else {
			$adRecord = AdModel::create($data);
			foreach($phoneData as $key => $phone) {
				if($phone) {
					$phoneRecord = PhoneModel::create([
						'phone' => $phone
					]);
					AdPhoneModel::create([
						'ad_id'    => $adRecord->id,
						'phone_id' => $phoneRecord->id,
						'sequence' => $key
					]);
				}
			}
			AdCategoryModel::create([
				'ad_id'       => $adRecord->id,
				'category_id' => $categoryData['id'],
			]);
		}
		return $adRecord;
	}

	public function processSave($data) {
		return ($this->validateData($data) ? $this->processTransaction([$this, 'processRecord'], [$data]) : $this->internalResponse->make());
	}

}