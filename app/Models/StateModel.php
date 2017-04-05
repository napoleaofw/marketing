<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StateModel extends Model {

    protected $table = 'STATE_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'country_id',
        'name',
        'name_uri',
        'acronym'
    ];

}