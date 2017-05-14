@extends('website.layout.index')
@section('ad')
<div id="ads" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <section id="ads-more-info" class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
                <div class="box">
                    <div class="box-body">
                        <h1 id="ads-name" class="title">{{$adRecord->ad_title}}</h1>
                        <section id="ads-address-section">
                            <h3 class="title">
                                Endereço
                            </h3>
                            <p class="ads-address">
                                <span class="ads-icon-container"><i class="fa fa-map-signs"></i></span>{{$adRecord->getFirstPartAddress()}}
                            </p>
                            <p class="ads-address">
                                <span class="ads-icon-container"><i class="fa fa-map-marker"></i></span>{{$adRecord->getLastPartAddress()}}
                            </p>
                            <span class="ads-icon-container"><i class="fa fa-map-o"></i></span><a href="http://www.google.com/maps/place/{{$adRecord->ad_map_latitude}},{{$adRecord->ad_map_longitude}}" target="_blank" class="ads-map">Como chegar?</a>
                        </section>
                        @if(count($adRecord['adPhoneRecordList']) > 0)
                        <section id="ads-phone-section">
                            <h3 class="title">
                                Telefone
                            </h3>
                            <ul class="default-list ads-phone-list">
                                @foreach($adRecord['adPhoneRecordList'] as $adPhoneRecord)
                                <li class="ads-phone">
                                    <a href="tel:{{$adPhoneRecord->formattedPhone}}">
                                        <span class="ads-icon-container"><i class="fa fa-phone"></i></span>{{$adPhoneRecord->formattedPhone}}
                                    </a>
                                </li>
                                @endforeach
                            </ul>
                        </section>
                        @endif
                        @if($adRecord->ad_description)
                        <section id="ads-about-section">
                            <h3 class="title">Sobre</h3>
                            <p>
                                <span class="icon-container"><i class="fa fa-quote-left"></i></span>
                                {{$adRecord->ad_description}}
                                <span class="icon-container"><i class="fa fa-quote-right"></i></span>
                            </p>
                        </section>
                        @endif
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
@stop