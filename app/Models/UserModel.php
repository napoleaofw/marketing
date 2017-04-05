<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserModel extends Model {

    protected $table = 'USER_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'email',
        'password',
        'remember_token'
    ];

}