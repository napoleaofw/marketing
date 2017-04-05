<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdModel extends Model {

    protected $table = 'AD_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'person_id',
        'city_id',
        'title',
        'title_uri',
        'short_description',
        'description',
        'district',
        'address',
        'address_number',
        'address_complement',
        'postal_code',
        'map_latitude',
        'map_longitude'
    ];

    // public function recordsAdPhone() {
    //     return $this->hasMany('\App\Models\AdPhoneModel', 'ad_id', 'id');
    // }

    // public function recordCity() {
    //     return $this->hasOne('\App\Models\CityModel', 'id', 'city_id');
    // }

}