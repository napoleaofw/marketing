<?php

namespace App\Models\Views;

use Illuminate\Database\Eloquent\Model;

class AdDataViewModel extends Model {

    protected $table = 'AD_DATA_VIEW';
    protected $fillable = [];
    
	public function getFirstPartAddress() {
        $firstPartAddress = $this->ad_address;
        if($this->ad_address_number) {
            $firstPartAddress .= ', ' . $this->ad_address_number;
        }
        if($this->ad_address_complement) {
            $firstPartAddress .= ', ' . $this->ad_address_complement;
        }
         $firstPartAddress .= ' - ' . $this->ad_district;
        return $firstPartAddress;
	}

	public function getLastPartAddress() {
        $lastPartAddress = $this->city_name . ' / ' . $this->state_acronym;
        if($this->ad_postal_code) {
            $lastPartAddress .= ' -  CEP: ' . $this->ad_postal_code;
        }
        return $lastPartAddress;
	}

	public function getFullAddress() {
		return $this->getFirstPartAddress() . ' - ' . $this->getLastPartAddress();
	}

}