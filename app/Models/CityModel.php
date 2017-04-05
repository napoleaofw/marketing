<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CityModel extends Model {

    protected $table = 'CITY_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'state_id',
        'name',
        'name_uri',
        'acronym'
    ];

    public function recordState() {
        return $this->hasOne('\App\Models\StateModel', 'state_id', 'id');
    }

}