@extends('website.layout.index')
@section('search')
<div id="search" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <div class="col-xs-12 col-lg-10 col-lg-offset-1">
                <h1 class="title title-margin">Resultados da pesquisa</h1>
                @if(Auth::user())
                    <div class="ad-tools pull-right">
                        <button type="button" class="btn btn-box-tool" title="Novo anúncio" data-toggle="tooltip">
                            <a href="/create">
                                <i class="fa fa-plus"></i>
                            </a>
                        </button>
                    </div>
                @endif
            </div>
            <section id="search-group-filter-section" class="col-xs-12 col-sm-5 col-md-4 col-lg-3 col-lg-offset-1">
                <div class="box">
                    <div class="box-body">
                        @if(count($categoryRecordList) > 0)
                            <section class="search-filter-section">
                                <div class="search-filter-header">
                                    <h3 class="title search-filter-title">Categorias</h3>
                                    <div class="ad-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="search-filter-body">
                                    <ul class="nav search-filter-list">
                                        @foreach($categoryRecordList as $categoryRecord)
                                            <li class="search-filter">
                                                <a href="/{{$categoryRecord->uri}}" class="search-filter-link">
                                                    <input type="checkbox" {{$categoryRecord->checked ? 'checked' : ''}}>{{$categoryRecord->category_name}}
                                                </a>
                                            </li>
                                        @endforeach
                                    </ul>
                                </div>
                            </section>
                        @endif
                        @if(count($subcategoryRecordList) > 0)
                            <section class="search-filter-section">
                                <div class="search-filter-header">
                                    <h3 class="title search-filter-title">Subcategorias</h3>
                                    <div class="ad-tools pull-right">
                                        <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="search-filter-body">
                                    <ul class="nav search-filter-list">
                                        @foreach($subcategoryRecordList as $subcategoryRecord)
                                            <li class="search-filter">
                                                <a href="{{$subcategoryRecord->uri}}" class="search-filter-link">
                                                    <input type="checkbox" {{$subcategoryRecord->checked ? 'checked' : ''}}>{{$subcategoryRecord->subcategory_name}}
                                                </a>
                                            </li>
                                        @endforeach
                                    </ul>
                                </div>
                            </section>
                        @endif
                        <section class="search-filter-section">
                            <div class="search-filter-header">
                                <h3 class="title search-filter-title">Cidades</h3>
                                <div class="ad-tools pull-right">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                        <i class="fa fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="search-filter-body">
                                <ul class="nav search-filter-list">
                                    @foreach($cityRecordList as $cityRecord)
                                        <li class="search-filter">
                                            <a href="/{{$cityRecord->uri}}" class="search-filter-link">
                                                <input type="checkbox" {{$cityRecord->checked ? 'checked' : ''}}>{{$cityRecord->name}}
                                            </a>
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        </section>
                    </div>
                </div>
            </section>
            <section id="search-result-section" class="col-xs-12 col-sm-7 col-md-8 col-lg-7">
                @if(Auth::user())
                    <input type="hidden" name="_token" value="{{csrf_token()}}">
                @endif
                @if(count($adRecordList) > 0)
                    <ul class="row default-list search-result-list">
                        @foreach($adRecordList as $adRecord)
                            <li class="col-xs-12 col-md-6 search-result" data-id="{{$adRecord->ad_id}}">
                                <div class="box">
                                    <div class="box-body no-padding">
                                        <div class="col-xs-12 box-body-content">
                                            @if(Auth::user())
                                                <div class="box-tools pull-right">
                                                    <button type="button" class="btn btn-box-tool" title="Editar" data-toggle="tooltip">
                                                        <a href="/edit/{{$adRecord->ad_id}}">
                                                            <i class="fa fa-pencil"></i>
                                                        </a>
                                                    </button>
                                                    <button type="button" class="btn btn-box-tool {{$adRecord->ad_review === 'y' ? 'text-green' : ''}}" title="Revisar" data-toggle="tooltip" data-action="review">
                                                        <i class="fa fa-wrench"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-box-tool {{$adRecord->ad_delete === 'y' ? 'text-red' : ''}}" title="Deletar" data-toggle="tooltip" data-action="delete">
                                                        <i class="fa fa-times"></i>
                                                    </button>
                                                </div>
                                            @endif
                                            <div class="row section-group">
                                                <div class="col-xs-12">
                                                    <section class="ads-title-section">
                                                        <h2 class="title"><a href="{{'/'.$adRecord->city_name_uri.'/'.$adRecord->ad_id}}" class="default-color ads-title-link">{{$adRecord->ad_title}}</a></h2>
                                                    </section>
                                                    <section class="ads-address-section">
                                                        <p class="ads-address">
                                                            <span class="ads-icon-container"><i class="fa fa-map-signs"></i></span>{{$adRecord->getFirstPartAddress()}}
                                                        </p>
                                                        <p class="ads-address">
                                                            <span class="ads-icon-container"><i class="fa fa-map-marker"></i></span>{{$adRecord->getLastPartAddress()}}
                                                        </p>
                                                        <span class="ads-icon-container"><i class="fa fa-map-o"></i></span><a href="http://www.google.com/maps/place/{{$adRecord->ad_map_latitude}},{{$adRecord->ad_map_longitude}}" target="_blank" class="ads-map">Como chegar?</a>
                                                    </section>
                                                    <section class="ads-phone-section">
                                                        <ul class="default-list ads-phone-list">
                                                            @foreach($adRecord['phoneRecordList'] as $phoneRecord)
                                                                <li class="ads-phone">
                                                                    <a href="tel:{{$phoneRecord->getFormattedPhone()}}" class="link">
                                                                        <span class="ads-icon-container"><i class="fa fa-phone"></i></span>{{$phoneRecord->getFormattedPhone()}}
                                                                    </a>
                                                                </li>
                                                            @endforeach
                                                        </ul>
                                                    </section>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        @endforeach
                    </ul>
                @else
                    <div class="col-xs-12">
                        <p>Nenhum resultado encontrado.</p>
                    </div>
                @endif
                @if(count($pagination) > 0)
                    <div class="col-xs-3 pagination-container">
                        <ul class="nav pagination">
                            @foreach($pagination as $page)
                                <li class="{{$page['active'] ? 'active' : ''}}">
                                    <a href="{{$page['active'] ? '#' : $page['uri']}}">{{$page['text']}}</a>
                                </li>
                            @endforeach
                        </ul>
                    </div>
                @endif
            </section>
        </div>
    </div>
</div>
@stop