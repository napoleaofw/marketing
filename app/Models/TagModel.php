<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TagModel extends Model {

    protected $table = 'TAG_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'name'
    ];

}