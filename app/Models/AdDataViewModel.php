<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AdDataViewModel extends Model {

    protected $table = 'AD_DATA_VIEW';
    protected $fillable = [];

    public function getFullAddress() {
        $fullAddress = $this->ad_address;
        if($this->ad_address_number) {
            $fullAddress .= ', ' . $this->ad_address_number;
        }
        if($this->ad_address_complement) {
            $fullAddress .= ', ' . $this->ad_address_complement;
        }
        $fullAddress .= ', ' . $this->ad_district . ' - ' . $this->city_name . ' - ' . $this->state_acronym;
        if($this->ad_postal_code) {
            $fullAddress .= ', CEP: ' . $this->ad_postal_code;
        }
        return $fullAddress;
    }

}