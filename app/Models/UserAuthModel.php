<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;

class UserAuthModel extends Authenticatable {

    protected $table = 'USER_TBL';
    protected $primaryKey = 'id';
    protected $redirectTo = '/';
    protected $guard = 'user';

    /**
    * The attributes that are mass assignable.
    *
    * @var array
    */
    protected $fillable = ['email'];

    /**
    * The attributes that should be hidden for arrays.
    *
    * @var array
    */
    protected $hidden = [
        'password',
        'remember_token'
    ];

}