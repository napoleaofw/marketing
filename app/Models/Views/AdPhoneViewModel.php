<?php

namespace App\Models\Views;

use Illuminate\Database\Eloquent\Model;

class AdPhoneViewModel extends Model {

    protected $table = 'AD_PHONE_VIEW';
    protected $fillable = [];

    public function getFormattedPhone() {
        $formattedPhone = '';
        $phone = $this->phone_phone;
        if(strlen($phone) >= 12) {
            $formattedPhone = '+' . substr($phone, 0, 2) . ' ';
            $phone = substr($phone, 2);
        }
        if(strlen($phone) >= 10) {
            $formattedPhone .= '(' . substr($phone, 0, 2) . ') ';
            $phone = substr($phone, 2);
        }
        if(strlen($phone) === 9) {
            $formattedPhone .= substr($phone, 0, 1) . ' ';
            $phone = substr($phone, 1);
        }
        if(strlen($phone) === 8) {
            $formattedPhone .= substr($phone, 0, 4) . '-' . substr($phone, 4);
        }
        return $formattedPhone;
    }

}

// 5551998763249 | +55 (51) 9 9876-3249
// 555198763249  | +55 (51) 9876-3249
// 555135645418  | +55 (51) 3564-5418
// 51998763249   | (51) 9 9876-3249
// 5198763249    | (51) 9876-3249
// 5135645418    | (51) 3564-5418
// 998763249     | 9 9876-3249
// 98763249      | 9876-3249
// 35645418      | 3564-5418