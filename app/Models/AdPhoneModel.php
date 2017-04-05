<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdPhoneModel extends Model {

    protected $table = 'AD_PHONE_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'ad_id',
        'phone_id',
        'sequence'
    ];

    public function recordPhone() {
        return $this->hasOne('\App\Models\PhoneModel', 'id', 'phone_id');
    }

}