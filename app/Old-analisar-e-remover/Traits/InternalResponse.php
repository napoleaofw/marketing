<?php

namespace App\Traits;

use Response;
use Validator;

trait InternalResponse
{

    protected $statusCode = 500;
    protected $dataResponse = [
        'data'     => [],
        'messages' => []
    ];

    protected function response() {
        return Response::make($this->dataResponse, $this->statusCode);
    }

    protected function setStatusCode($statusCode)
    {
        $this->statusCode = $statusCode;
    }

    protected function addResponse($attribute, $response)
    {
        $this->dataResponse[$attribute] = $response;
    }

    protected function transact($transaction)
    {
        try
        {
            $data = DB::transaction($transaction);
            if($data)
            {
                $this->setStatusCode(200);
                $this->addResponse('data', $data);
                $this->addResponse('messages', 'Solicitação concluída com sucesso.');
            }
            $this->addResponse('messages', 'Solicitação parcialmente concluída: ocorreu um erro no processamento dos dados.');
        }
        catch(\PDOException $e)
        {
            $this->addResponse('messages', 'Solicitação não concluída: ocorreu um erro no banco de dados.');
        }
        catch(\Exception $e)
        {
            $this->addResponse('messages', 'Solicitação não concluída: ocorreu um erro inesperado.');
        }
        finally
        {
            return $this->response();
        }
    }

    protected function validateData($data, $dataValidator)
    {
        $validator = Validator::make($data,
                                     $dataValidator['rules'],
                                     $dataValidator['messages'],
                                     $dataValidator['customAttributes']);
        if($validator->fails()) {
            $this->setStatusCode(422);
            $this->addResponse('messages', ['validation' => $validator->messages()->getMessages()]);
        }
        return $this->response();
    }

}