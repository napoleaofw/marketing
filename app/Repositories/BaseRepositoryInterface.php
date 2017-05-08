<?php

namespace App\Repositories;

interface BaseRepositoryInterface {

	public function create($data);

	public function read($id);

	public function update($id, $data);

	public function delete($id);

	public function count($filters);

	public function recordList($filters, $limit, $offset);

	public function records();

	public function getTransactionStatus();

	public function enableTransaction();

	public function disableTransaction();

	public function getDataValidator();

	public function setDataValidator($dataValidator);

	public function getModel();

	public function setModel($model);

}