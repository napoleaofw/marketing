<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CategoryModel extends Model {

    protected $table = 'CATEGORY_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'category_id',
        'name',
        'name_uri'
    ];

}