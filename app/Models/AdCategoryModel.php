<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdCategoryModel extends Model {

    protected $table = 'AD_CATEGORY_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'ad_id',
        'category_id'
    ];
    
}