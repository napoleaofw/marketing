<?php

namespace App\Repositories;

use App\Traits\InternalResponse;

abstract class Repository implements RepositoryInterface
{

    use InternalResponse;

    protected $dataValidator;

    public function __construct(){}

    abstract public function create($data);

    abstract public function read($id);

    abstract public function update($id, $data);

    abstract public function delete($id);

    public function getDataValidator()
    {
        return $this->dataValidator;
    }

}