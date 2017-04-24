<?php

namespace App\Models\Tables;

use Illuminate\Database\Eloquent\Model;

class UserModel extends Model {

    protected $table = 'USER_TBL';
    protected $primaryKey = 'id';
    protected $guarded = [
        'id',
        'password',
        'created_at',
        'updated_at'
    ];
    protected $hidden = [
        'password',
        'created_at',
        'updated_at'
    ];

}