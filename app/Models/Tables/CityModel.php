<?php

namespace App\Models\Tables;

use Illuminate\Database\Eloquent\Model;

class CityModel extends Model {

    protected $table = 'CITY_TBL';
    protected $primaryKey = 'id';
    protected $guarded = [
        'id',
        'created_at',
        'updated_at'
    ];
    protected $hidden = [
        'created_at',
        'updated_at'
    ];

    public function recordState() {
        return $this->hasOne('\App\Models\StateModel', 'id', 'state_id');
    }

}