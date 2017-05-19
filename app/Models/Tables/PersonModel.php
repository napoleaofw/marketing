<?php

namespace App\Models\Tables;

use Illuminate\Database\Eloquent\Model;

class PersonModel extends Model {

    protected $table = 'PERSON_TBL';
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

}