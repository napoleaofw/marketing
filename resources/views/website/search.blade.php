@extends('website.layout.index')
@section('search')
<div id="search" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <section id="search-group-filter-section" class="col-xs-12 col-sm-5 col-md-4 col-lg-3 col-lg-offset-1">
                <div class="box">
                    <div class="box-body">
                        <section class="search-filter-section">
                            <div class="search-filter-header">
                                <h3 class="title search-filter-title">Categorias</h3>
                            </div>
                            <div class="search-filter-body">
                                <ul class="nav search-filter-list">
                                    @foreach($categoryRecordList as $categoryRecord)
                                        <li class="search-filter">
                                            <a href="/{{$categoryRecord->uri}}" class="search-filter-link">
                                                <input type="checkbox" {{$categoryRecord->checked ? 'checked' : ''}}>{{$categoryRecord->name}}
                                            </a>
                                        </li>
                                    @endforeach
                                </ul>
                            </div>
                        </section>
                        @if(count($subcategoryRecordList) > 0)
                            <section class="search-filter-section">
                                <div class="search-filter-header">
                                    <h3 class="title search-filter-title">Subcategorias</h3>
                                </div>
                                <div class="search-filter-body">
                                    <ul class="nav search-filter-list">
                                        @foreach($subcategoryRecordList as $subcategoryRecord)
                                            <li class="search-filter">
                                                <a href="{{$subcategoryRecord->name_uri}}" class="search-filter-link">
                                                    <input id="checkbox4" type="checkbox">{{$subcategoryRecord->name}}
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
                <ul class="row default-list search-result-list">
                    @foreach($adRecordList as $adRecord)
                    <li class="col-xs-12 col-md-6 search-result">
                        <div class="box">
                            <div class="box-body no-padding">
                                <div class="col-xs-12 box-body-content">
                                    <div class="row section-group">
                                        <div class="col-xs-12">
                                            <section class="ads-title-section">
                                                <h2 class="title ads-title"><a href="#" class="default-color ads-title-link">{{$adRecord->ad_title}}</a></h2>
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
                                                            <span class="ads-icon-container"><i class="fa fa-phone"></i></span>{{$phoneRecord->getFormattedPhone()}}
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