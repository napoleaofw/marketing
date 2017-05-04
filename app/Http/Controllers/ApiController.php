<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Repositories\Ad\AdRepositoryInterface;
use Response;

class ApiController extends Controller {

    public function __construct() {}

    public function adMarkFor(
        Request $request,
        AdRepositoryInterface $adRepository
    ) {
        $response;
        $input = $request->all();
        if($input['id'] && $input['action']) {
            if($input['action'] === 'review') {
                $response = $adRepository->markForReview($input['id']);
            }
            elseif($input['action'] === 'delete') {
                $response = $adRepository->markForDelete($input['id']);
            }
            else {
                $response = Response::make([
                    'data' => [],
                    'messages' => ['Solicitação não concluída: ação inválida.']
                ], 422);
            }
        }
        else {
            $response = Response::make([
                'data' => [],
                'messages' => ['Solicitação não concluída: dados inválidos.']
            ], 422);
        }
        $dataResponse = $response->getOriginalContent();
        $dataResponse['html'] = view('website.layout.messages')->render();
        return Response::json($dataResponse, $response->status());
    }

}