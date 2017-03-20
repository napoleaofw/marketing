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
                            <h3 class="title search-filter-title">Categorias</h3>
                            <ul class="nav search-filter-list">
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox1" type="checkbox">nome da categoria
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox2" type="checkbox">nome da categoria
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox3" type="checkbox">nome da categoria
                                    </a>
                                </li>
                            </ul>
                        </section>
                        <section class="search-filter-section">
                            <h3 class="title search-filter-title">Subcategorias</h3>
                            <ul class="nav search-filter-list">
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox4" type="checkbox">nome da subcategoria
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox5" type="checkbox">nome da subcategoria
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox6" type="checkbox">nome da subcategoria
                                    </a>
                                </li>
                            </ul>
                        </section>
                        <section class="search-filter-section">
                            <h3 class="title search-filter-title">Facilidades</h3>
                            <ul class="nav search-filter-list">
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox7" type="checkbox">nome da facilidade
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox8" type="checkbox">nome da facilidade
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox9" type="checkbox">nome da facilidade
                                    </a>
                                </li>
                            </ul>
                        </section>
                        <section class="search-filter-section">
                            <h3 class="title search-filter-title">Estados</h3>
                            <ul class="nav search-filter-list">
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox10" type="checkbox">nome do estado
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox11" type="checkbox">nome do estado
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox12" type="checkbox">nome do estado
                                    </a>
                                </li>
                            </ul>
                        </section>
                        <section class="search-filter-section">
                            <h3 class="title search-filter-title">Cidades</h3>
                            <ul class="nav search-filter-list">
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox13" type="checkbox">nome da cidade
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox14" type="checkbox">nome da cidade
                                    </a>
                                </li>
                                <li class="search-filter">
                                    <a href="#" class="search-filter-link">
                                        <input id="checkbox15" type="checkbox">nome da cidade
                                    </a>
                                </li>
                            </ul>
                        </section>
                    </div>
                </div>
            </section>
            <section id="search-result-section" class="col-xs-12 col-sm-7 col-md-8 col-lg-7">
                <ul class="default-list search-result-list">
                    <li class="search-result">
                        <div class="box">
                            <div class="box-header no-padding">
                                <div class="search-result-image-container">
                                    <img class="search-result-image ads-cover-image" src="https://almsaeedstudio.com/themes/AdminLTE/dist/img/photo2.png">
                                    <img class="search-result-image ads-profile-image" src="https://almsaeedstudio.com/themes/AdminLTE/dist/img/photo1.png">
                                    <div class="search-result-image-effect"></div>
                                </div>
                                <div class="col-xs-12 box-header-content">
                                    <div class="row">
                                        <section class="col-xs-6 ads-title-section">
                                            <h2 class="title ads-title"><a href="#" class="default-color ads-title-link">nome do estabelecimento</a></h2>
                                        </section>
                                        <section class="col-xs-6 ads-avaliation-section">
                                            <span class="ads-avaliation-total"><a href="#" class="default-color ads-avaliation-link">7 avaliações</a></span>
                                            <ul class="default-list ads-avaliation-list">
                                                <li class="ads-avaliation" title="Excelente">
                                                    <i class="fa fa-star-o"></i>
                                                </li>
                                                <li class="ads-avaliation" title="Muito bom">
                                                    <i class="fa fa-star-o"></i>
                                                </li>
                                                <li class="ads-avaliation" title="Bom">
                                                    <i class="fa fa-star-o"></i>
                                                </li>
                                                <li class="ads-avaliation" title="Razoável">
                                                    <i class="fa fa-star-o"></i>
                                                </li>
                                                <li class="ads-avaliation" title="Ruim">
                                                    <i class="fa fa-star-o"></i>
                                                </li>
                                            </ul>
                                        </section>
                                    </div>
                                </div>
                            </div>
                            <div class="box-body no-padding">
                                <div class="col-xs-12 box-body-content">
                                    <div class="row section-group">
                                        <div class="col-xs-6">
                                            <section class="ads-address-section">
                                                <p class="ads-address">
                                                    <span class="ads-icon-container"><i class="fa fa-map-marker"></i></span>Avenida Moema, 594, Indianópolis, São Paulo - SP
                                                </p>
                                                <span class="ads-icon-container"><i class="fa fa-map-o"></i></span><a href="#" class="ads-map">Como chegar?</a>
                                            </section>
                                            <section class="ads-phone-section">
                                                <ul class="default-list ads-phone-list">
                                                    <li class="ads-phone">
                                                        <span class="ads-icon-container"><i class="fa fa-phone"></i></span>(11) 4329-9878
                                                    </li>
                                                    <li class="ads-phone">
                                                        <span class="ads-icon-container"><i class="fa fa-phone"></i></span>(11) 4329-9878
                                                    </li>
                                                    <li class="ads-phone">
                                                        <span class="ads-icon-container"><i class="fa fa-phone"></i></span>(11) 4329-9878
                                                    </li>
                                                </ul>
                                                <span class="see-more"><a href="#">ver telefone(s)</a></span>
                                            </section>
                                        </div>
                                        <div class="col-xs-6">
                                            <section class="ads-facility-section">
                                                <ul class="default-list ads-facility-list">
                                                    <li class="ads-facility">
                                                        <i class="fa fa-wifi" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-truck" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-taxi" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-shower" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-plug" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-newspaper-o" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-shopping-cart" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-cutlery" title="nome da facilidade"></i>
                                                    </li>
                                                    <li class="ads-facility">
                                                        <i class="fa fa-diamond" title="nome da facilidade"></i>
                                                    </li>
                                                </ul>
                                            </section>
                                            <section class="ads-payment-method-section">
                                                <ul class="default-list ads-payment-method-list">
                                                    <li class="ads-payment-method">
                                                        <span class="ads-icon-container">
                                                            <i class="fa fa-credit-card" title="nome da forma de pagamento"></i>
                                                        </span>
                                                    </li>
                                                    <li class="ads-payment-method">
                                                        <span class="ads-icon-container">
                                                            <i class="fa fa-money" title="nome da forma de pagamento"></i>
                                                        </span>
                                                    </li>
                                                    <li class="ads-payment-method">
                                                        <span class="ads-icon-container">
                                                            <i class="fa fa-barcode" title="nome da forma de pagamento"></i>
                                                        </span>
                                                    </li>
                                                </ul>
                                        </div>
                                    </div>
                                    <div class="row section-group">
                                        <section class="col-xs-12 ads-short-about-section">
                                            <p class="ads-short-about"><span class="ads-icon-container"><i class="fa fa-quote-left"></i></span>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sagittis ornare tellus, id maximus neque elementum id. Nulla vitae placerat erat, finibus condimentum sem. Suspendisse sagittis nibh eros.<span class="ads-icon-container"><i class="fa fa-quote-right"></i></span></p>
                                        </section>
                                    </div>
                                    <div class="row section-group">
                                        <div class="col-xs-12">
                                            <section class="ads-business-hour-section">
                                                <p><span class="ads-icon-container"><i class="fa fa-clock-o"></i></span><span class="ads-business-hour-open">Aberto agora </span>(08:30 - 18:00)</p>
                                            </section>
                                        </div>
                                    </div>
                                    <div class="row section-group">
                                        <div class="col-xs-8">
                                            <section class="ads-link-section">
                                                <ul class="default-list ads-link-list">
                                                    <li class="ads-link">
                                                        <a href="#">acessar website</a>
                                                    </li>
                                                    <li class="ads-link">
                                                        <a href="#">enviar e-mail</a>
                                                    </li>
                                                </ul>
                                            </section>
                                        </div>
                                        <div class="col-xs-4">
                                            <section class="ads-more-details-section">
                                                <a href="#" class="ads-more-details-link link-effect">Mais detalhes</a>
                                            </section>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <div class="col-xs-3 pagination-container">
                    <ul class="nav pagination">
                        <li class="active">
                            <a href="#">1</a>
                        </li>
                        <li>
                            <a href="#">2</a>
                        </li>
                        <li>
                            <a href="#">3</a>
                        </li>
                    </ul>
                </div>
            </section>
        </div>
    </div>
</div>
@stop