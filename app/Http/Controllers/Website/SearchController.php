<?php

namespace App\Http\Controllers\Website;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Repositories\Ad\AdFilterViewRepositoryInterface;
use App\Repositories\Category\CategoryRepositoryInterface;
use App\Repositories\City\CityRepositoryInterface;

class SearchController extends Controller {

    private $parameters;

    public function __construct() {
        $this->parameters = [
            'city' => [
                'filter' => true,
            ],
            'category' => [
                'filter' => true,
            ],
            'subcategory' => [
                'filter' => true,
            ],
            'q' => [
                'filter' => true,
            ],
            'page' => [
                'filter' => false
            ]
        ];
    }

    private function explodeParameters($parameters) {
        foreach($parameters as $parameter => $values) {
            $parameters[$parameter] = explode(',', $values);
        }
        return  $parameters;
    }

    private function createUri($parameters) {
        $uri = 'search?';
        foreach($parameters as $parameter => $values) {
            if(is_array($values))
                $uri .= count($values) > 0 ? $parameter . '=' . implode(',', $values) . '&' : '';
            else
                $uri .= count($values) > 0 ? $parameter . '=' . $values . '&' : '';
        }
        $uri = substr($uri, 0, strlen($uri) - 1);
        return $uri;
    }

    public function process(
        Request $request,
        AdFilterViewRepositoryInterface $adFilterViewRepository,
        CategoryRepositoryInterface $categoryRepository,
        CityRepositoryInterface $cityRepository
    ) {
        $filters = [];
        $parameters = $request->all();
        foreach($parameters as $parameter => $value) {
            if(!array_key_exists($parameter, $this->parameters) || ($parameter === 'page' && (!ctype_digit($value) || $value == 0))) {
                abort(404);
            }
            else {
                if($this->parameters[$parameter]['filter'] === true) {
                    $filters[$parameter] = $parameter == 'q' ? '%' . $value . '%' : explode(',', $value);
                }
            }
        }
        $page = isset($parameters['page']) ? $parameters['page'] : 1;
        $limit = 25;
        $offset = ($page - 1) * $limit;
        $totalPages = $adFilterViewRepository->count($filters);
        $adRecordList = $adFilterViewRepository->list($filters, $limit, $offset);
        $categoryRecordList = $categoryRepository->records();
        foreach($categoryRecordList as $categoryRecord) {
            $uriParameters = $this->explodeParameters($parameters);
            if(isset($uriParameters['page']))
                unset($uriParameters['page']);
            if(!isset($uriParameters['category']))
                $uriParameters['category'] = [];
            $key = array_search($categoryRecord->name_uri, $uriParameters['category']);
            if($key === FALSE) {
                array_push($uriParameters['category'], $categoryRecord->name_uri);
               $categoryRecord['checked'] = false;
            }
            else {
               unset($uriParameters['category'][$key]);
               $categoryRecord['checked'] = true;
            }
            $categoryRecord['uri'] = $this->createUri($uriParameters);
        }
        $cityRecordList = $cityRepository->records();
        foreach($cityRecordList as $cityRecord) {
            $uriParameters = $this->explodeParameters($parameters);
            if(isset($uriParameters['page']))
                unset($uriParameters['page']);
            if(!isset($uriParameters['city']))
                $uriParameters['city'] = [];
            $key = array_search($cityRecord->name_uri, $uriParameters['city']);
            if($key === FALSE) {
                array_push($uriParameters['city'], $cityRecord->name_uri);
               $cityRecord['checked'] = false;
            }
            else {
                unset($uriParameters['city'][$key]);
               $cityRecord['checked'] = true;
            }
            $cityRecord['uri'] = $this->createUri($uriParameters);
        }
        $lastPage = ceil($totalPages / $limit);
        if($page > $lastPage) {
            abort(404);
        }
        $pagination = [];
        $uriParameters = $this->explodeParameters($parameters);
        $uriParameters['page'] = 1;
        if(($page - 2) > 1) {
            array_push($pagination, [
                'active' => false,
                'text'   => 'Primeira',
                'uri'    => $this->createUri($uriParameters)
            ]);
        }
        $start = ($page - 2) > 1 ? ($page - 2) : 1;
        $end = ($page + 2) < $lastPage ? ($page + 2) : $lastPage;
        for($i = $start; $i <= $end; $i++) {
            $uriParameters['page'] = $i;
            array_push($pagination, [
                'active' => ($page == $i),
                'text'   => $i,
                'uri'    => $this->createUri($uriParameters)
            ]);
        }
        $uriParameters['page'] = $lastPage;
        if(($page + 2) < $lastPage) {
            array_push($pagination, [
                'active' => false,
                'text'   => 'Última',
                'uri'    => $this->createUri($uriParameters)
            ]);
        }
        $uriParameters = $this->explodeParameters($parameters);
        $searchUri = $this->createUri($uriParameters);
        $data = [
            'pageName'              => 'search',
            'adRecordList'          => $adRecordList,
            'categoryRecordList'    => $categoryRecordList,
            'subcategoryRecordList' => [],
            'cityRecordList'        => $cityRecordList,
            'pagination'            => $pagination,
            'searchUri'             => $searchUri
        ];
        return view('website.search', $data);
    }

}