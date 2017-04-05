<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserPreferenceModel extends Model {

    protected $table = 'USER_PREFERENCE_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'user_id',
        'preference_name',
        'preference_value'
    ];

}