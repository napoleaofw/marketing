<?php

namespace App\Services\InternalResponse;

use App\Services\BaseService;
use Response;

class InternalResponseService extends BaseService implements InternalResponseServiceInterface {

	private $data;
	private $messages;
	private $statusCode;
	private $internalResponse;

	public function __construct() {
		parent::__construct();
	}

	private function makeContent() {
		return [
			'data'     => $this->data,
			'messages' => $this->messages
		];
	}

	public function make() {
		return ($this->internalResponse = Response::make($this->makeContent(), $this->statusCode));
	}

	public function getData() {
		return $this->data;
	}

	public function setData($data) {
		$this->data = $data;
	}

	public function getMessages() {
		return $this->messages;
	}

	public function setMessages($key, $messages) {
		$this->messages[$key] = $messages;
	}

	public function getStatusCode() {
		return $this->statusCode;
	}

	public function setStatusCode($statusCode) {
		$this->statusCode = $statusCode;
	}

}