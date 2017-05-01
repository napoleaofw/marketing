<?php

namespace App\Repositories;

use App\Services\InternalResponse\InternalResponseService;
use DB;
use Validator;

abstract class BaseRepository implements BaseRepositoryInterface {

	protected $model;
	protected $dataValidator;
	protected $transactionStatus;
	protected $internalResponse;

	protected function __construct($model, $dataValidator) {
		$this->model = $model;
		$this->dataValidator = $dataValidator;
		$this->transactionStatus = true;
		$this->internalResponse = new InternalResponseService();
	}

	protected function transact($transaction, $parameters) {
		return DB::transaction(function() use($transaction, $parameters) {
			return call_user_func_array($transaction, $parameters);
		});
	}

	protected function processTransaction($transaction, $parameters) {
		try {
			$data;
			if($this->transactionStatus) {
				$data = $this->transact($transaction, $parameters);
			}
			else {
				$data = call_user_func_array($transaction, $parameters);
			}
			$this->internalResponse->setData($data);
			$this->internalResponse->setStatusCode(200);
			$this->internalResponse->setMessages('success', ['Solicitação concluída com sucesso.']);
		}
		catch(\Exception $e) {
			$this->internalResponse->setStatusCode(500);
			$this->internalResponse->setMessages('error', ['Solicitação não concluída: ocorreu um erro inesperado.']);
		}
		return $this->internalResponse->make();
	}

	protected function validateData($data) {
		$validator = Validator::make($data,
									 $this->dataValidator['rules'],
									 $this->dataValidator['messages'],
									 $this->dataValidator['customAttributes']);
		if($validator->fails()) {
			$this->internalResponse->setStatusCode(422);
			$this->internalResponse->setMessages('validation', $validator->messages()->getMessages());
			return false;
		}
		return true;
	}

	protected function createRecord($data) {
		return $this->model::create($data);
	}

	protected function readRecord($id) {
		return $this->model::findOrFail($id);
	}

	protected function updateRecord($id, $data) {
		return $this->model::findOrFail($id)->fill($data)->save();
	}

	protected function deleteRecord($id) {
		return $this->model::findOrFail($id)->delete();
	}

	public function create($data) {
		return ($this->validateData($data) ? $this->processTransaction([$this, 'createRecord'], [$data]) : $this->internalResponse->make());
	}

	public function read($id) {
		return $this->processTransaction([$this, 'readRecord'], [$id]);
	}

	public function update($id, $data) {
		return ($this->validateData($data) ? $this->processTransaction([$this, 'updateRecord'], [$data]) : $this->internalResponse->make());
	}

	public function delete($id) {
		return $this->processTransaction([$this, 'deleteRecord'], [$id]);
	}

	public function count($filters) {
		$query = new $this->model();
		foreach($filters as $column => $values) {
			$query = $query->whereIn($column, $values);
		}
		return $query->count();
	}

	public function list($filters, $limit, $offset) {
		$query = new $this->model();
		foreach($filters as $column => $values) {
			$query = $query->whereIn($column, $values);
		}
		return $query->limit($limit)->offset($offset)->get();
	}

	public function records() {
		return $this->model::all();
	}

	public function getTransactionStatus() {
		return $this->transactionStatus;
	}

	public function enableTransaction() {
		$this->transactionStatus = true;
	}

	public function disableTransaction() {
		$this->transactionStatus = false;
	}

	public function getDataValidator() {
		return $this->dataValidator;
	}

	public function setDataValidator($dataValidator) {
		$this->dataValidator($dataValidator);
	}

	public function getModel() {
		return $this->model;
	}

	public function setModel($model) {
		$this->model = $model;
	}

}