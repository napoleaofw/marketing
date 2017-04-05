<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PersonModel extends Model {

    protected $table = 'PERSON_TBL';
    protected $primaryKey = 'id';
    protected $fillable = [
        'user_id',
        'type',
        'first_name',
        'last_name',
        'cpf',
        'birth_date',
        'company_name',
        'trading_name',
        'cnpj',
        'state_registration',
        'foundation_date'
    ];

}