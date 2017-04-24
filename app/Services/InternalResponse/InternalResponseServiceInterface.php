<?php

namespace App\Services\InternalResponse;

use App\Services\BaseServiceInterface;

interface InternalResponseServiceInterface extends BaseServiceInterface {
	
	public function make();

	public function getData();

	public function setData($data);

	public function getMessages();

	public function setMessages($key, $messages);

	public function getStatusCode();

	public function setStatusCode($statusCode);
}