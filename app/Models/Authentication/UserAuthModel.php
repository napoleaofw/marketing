<?php

namespace App\Models\Authentication;

use Illuminate\Foundation\Auth\User as Authenticatable;

class UserAuthModel extends Authenticatable {

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
        'remember_token',
        'created_at',
        'updated_at'
    ];
    
}