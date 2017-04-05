<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CategoryTagModel extends Model {

    protected $table = 'CATEGORY_TAG_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'category_id',
        'tag_id'
    ];

}