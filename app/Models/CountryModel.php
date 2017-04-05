<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CountryModel extends Model {

    protected $table = 'COUNTRY_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'name',
        'name_uri',
        'acronym'
    ];

}