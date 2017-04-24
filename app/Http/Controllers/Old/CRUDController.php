<?php

namespace App\Http\Controllers;

use App\Models\Tables\UserModel;
use App\Models\TestModel;
use DB;
use Exception;
use Response;
use Validator;

abstract class CRUDController extends Controller {

    protected $data;
    protected $dataResponse;
    protected $validator;

    protected function __construct($data, $validatorData) {
        $this->data = $data;
        $this->dataResponse = [
            'data'     => [],
            'messages' => []
        ];
        $this->validator = Validator::make($data,
                                            $validatorData['rules'],
                                            $validatorData['messages'],
                                            $validatorData['customAttributes']);
    }

    protected function create() {
        try {
            if($this->validator->fails()) {
                $this->dataResponse['messages']['validation'] = $this->validator->messages()->getMessages();
                dd(Response::make($this->dataResponse, 422));
            }
            $transaction = DB::transaction(function() {
                return $this->createRecord();
            });
            if($transaction) {
                return Response::make($transaction, 200);
            }
            // return Response::make(??DATA??, 500);
            dd('response error');
        }
        catch(\PDOException $e) {
            dd($e);
            // return Response::make(??DATA??, 500);
        }
        catch(\Exception $e) {
            dd(500);
            // return Response::make(??DATA??, 500);
        }
    }

    abstract protected function createRecord();
    abstract protected function readRecord();
    abstract protected function updateRecord();
    abstract protected function deleteRecord();

}