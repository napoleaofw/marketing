<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdTagModel extends Model {

    protected $table = 'AD_TAG_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'ad_id',
        'tag_id'
    ];

}