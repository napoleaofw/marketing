<?php

namespace App\Repositories;

use App\Models\Tables\UserModel;
use App\Models\TestModel;
use DB;
use Exception;
use Response;
use Validator;

abstract class Repository {

    protected $data;
    protected $dataResponse;
    protected $dataValidator;
    protected $validator;

    protected function __construct() {
        $this->dataResponse = [
            'data'     => [],
            'messages' => []
        ];
    }

    private function createValidator() {
        $this->validator = Validator::make($this->data,
                                           $this->dataValidator['rules'],
                                           $this->dataValidator['messages'],
                                           $this->dataValidator['customAttributes']);
    }

    // private function validate() {
    //     $this->createValidator();
    //     if($this->validator->fails()) {
    //         $this->dataResponse['messages']['validation'] = $this->validator->messages()->getMessages();
    //         return Response::make($this->dataResponse, 422);
    //     }
    // }

    private function transact($data) {
    //private function transact($data, $action, $validateData=null) {
        try {
            $this->data = $data;
            // if(function_exists($validateData)) {
            //     $validateData();
            // }
            $this->createValidator();
            if($this->validator->fails()) {
                $this->dataResponse['messages']['validation'] = $this->validator->messages()->getMessages();
                return Response::make($this->dataResponse, 422);
            }
            $transaction = DB::transaction(function() {
                // return $action;
                return $this->create();
            });
            if($transaction) {
                array_push($this->dataResponse['data'], $transaction);
                array_push($this->dataResponse['messages'], 'Solicitação concluída com sucesso.');
                return Response::make($this->dataResponse, 200);
            }
            array_push($this->dataResponse['messages'], 'Solicitação não concluída: ocorreu um erro no processamento dos dados.');
            return Response::make($this->dataResponse, 500);
        }
        catch(\PDOException $e) {
            array_push($this->dataResponse['messages'], 'Solicitação não concluída: ocorreu um erro no banco de dados.');
            return Response::make($this->dataResponse, 500);
        }
        catch(\Exception $e) {
            array_push($this->dataResponse['messages'], 'Solicitação não concluída: ocorreu um erro inesperado.');
            return Response::make($this->dataResponse, 500);
        }
    }

    public function createRecord($data) {
        //$this->transact($data, $this->create, $this->validate);
        return $this->transact($data);
    }

    public function readRecord($data) {
        return $this->transact($data, $this->read);
    }

    public function updateRecord($data) {
        return $this->transact($data, $this->update, $this->validate);
    }

    public function deleteRecord($data) {
        return $this->transact($data, $this->delete);
    }

    abstract protected function create($data);
    abstract protected function read($data);
    abstract protected function update($data);
    abstract protected function delete($data);

}