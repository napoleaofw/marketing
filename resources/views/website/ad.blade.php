@extends('website.layout.index')
@section('ad')
<div id="ads" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <section id="ads-more-info" class="col-xs-12 col-sm-7 col-md-8 col-lg-7 col-lg-offset-2">
                <div class="box">
                    <div class="box-body">
                        <h1 id="ads-name" class="title">{{$recordAd->ad_title}}</h1>
                        <section id="ads-address">
                            <h3 class="title">
                                Endereço
                            </h3>
                            <p>{{$recordAd->getFullAddress()}}</p>
                        </section>
                        @if(count($recordsAdPhone) > 0)
                        <section id="ads-phone">
                            <h3 class="title">
                                Telefone
                            </h3>
                            <ul class="nav">
                                @foreach($recordsAdPhone as $recordAdPhone)
                                <li>
                                    <a href="tel:">{{$recordAdPhone->phone_phone}}</a>
                                </li>
                                @endforeach
                            </ul>
                        </section>
                        @endif
                        @if($recordAd->ad_description)
                        <section id="ads-about">
                            <h3 class="title">Sobre</h3>
                            <p>
                                <span class="icon-container"><i class="fa fa-quote-left"></i></span>
                                {{$recordAd->ad_description}}
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