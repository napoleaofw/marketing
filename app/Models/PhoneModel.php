<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PhoneModel extends Model {

    protected $table = 'PHONE_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'phone',
        'identification'
    ];

}