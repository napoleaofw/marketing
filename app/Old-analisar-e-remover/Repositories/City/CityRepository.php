<?php

namespace App\Repositories\City;

use App\Repositories\Repository;

class CityRepository extends Repository implements CityRepositoryInterface
{

    public function __construct()
    {
        $this->dataValidator = [
        ];
    }

    public function create($data)
    {
    }

    public function read($id)
    {
        return $this->transact(function($id)
        {
            return CityModel::findOrFail($id);
        });
    }

    public function update($id, $data)
    {
    }

    public function delete($id)
    {
    }

}