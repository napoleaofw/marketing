<?php

namespace App\Models\Tables;

use Illuminate\Database\Eloquent\Model;

class AdPhoneModel extends Model {

    protected $table = 'AD_PHONE_TBL';
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