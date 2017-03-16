@extends('website.layout.index')
@section('ads')
<div id="ads" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row">
            <section id="ads-quick-info" class="col-xs-12 col-sm-5 col-md-4 col-lg-3 col-lg-offset-1">
                <div class="ads-image-container">
                    <img id="ads-profile-image" src="https://almsaeedstudio.com/themes/AdminLTE/dist/img/photo1.png">
                </div>
                <div class="box">
                    <div class="box-body">
                        <h1 id="ads-name" class="title">nome do estabelecimento</h1>
                        <section id="ads-presentation">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-id-card-o"></i></span>
                                Apresentação
                            </h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                        </section>
                        <section id="ads-address">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-map-marker"></i></span>
                                Endereço
                            </h2>
                            <p>Avenida Moema, 594, Indianópolis, São Paulo - SP, CEP: 04077-022</p>
                        </section>
                        <section id="ads-phone">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-phone"></i></span>
                                Telefone
                            </h2>
                            <ul class="nav">
                                <li>
                                    <a href="tel:(11)4329-5652">(11) 4329-5652</a>
                                </li>
                                <li>
                                    <a href="tel:(11)4329-5652">(11) 4329-5652</a>
                                </li>
                                <li>
                                    <a href="tel:(11)4329-5652">(11) 4329-5652</a>
                                </li>
                            </ul>
                        </section>
                        <section id="ads-website">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-globe"></i></span>
                                Website
                            </h2>
                            <ul class="nav">
                                <li>
                                    <a href="websitelocal.com.br">websitelocal.com.br</a>
                                </li>
                                <li>
                                    <a href="websitelocal.com.br">websitelocal.com.br</a>
                                </li>
                                <li>
                                    <a href="websitelocal.com.br">websitelocal.com.br</a>
                                </li>
                            </ul>
                        </section>
                        <section id="ads-email">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-envelope-o"></i></span>
                                E-mail
                            </h2>
                            <ul class="nav">
                                <li>
                                    <a href="mailto:restaurante@local.com.br">restaurante@local.com.br</a>
                                </li>
                                <li>
                                    <a href="mailto:restaurante@local.com.br">restaurante@local.com.br</a>
                                </li>
                                <li>
                                    <a href="mailto:restaurante@local.com.br">restaurante@local.com.br</a>
                                </li>
                                <li>
                                    <a href="mailto:restaurante@local.com.br">restaurante@local.com.br</a>
                                </li>
                            </ul>
                        </section>
                        <section id="ads-business-hour">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-clock-o"></i></span>
                                Horário de atendimento
                            </h2>
                            <ul class="default-list">
                                <li>
                                    <p>Dom à Sab 00:00 às 23:45</p>
                                </li>
                                <li>
                                    <p>Dom à Sab 00:00 às 23:45</p>
                                </li>
                                <li>
                                    <p>Dom à Sab 00:00 às 23:45</p>
                                </li>
                                <li>
                                    <p>Dom à Sab 00:00 às 23:45</p>
                                </li>
                                <li>
                                    <p>Dom à Sab 00:00 às 23:45</p>
                                </li>
                            </ul>
                        </section>
                        <section id="ads-map">
                            <h2 class="title">
                                <span class="icon-container"><i class="fa fa-map-o"></i></span>
                                Mapa
                            </h2>
                            <div>
                                map here
                            </div>
                        </section>
                    </div>
                </div>
            </section>
            <section id="ads-more-info" class="col-xs-12 col-sm-7 col-md-8 col-lg-7">
                <div class="ads-image-container">
                    <img id="ads-cover-image" src="https://almsaeedstudio.com/themes/AdminLTE/dist/img/photo2.png">
                </div>
                <div class="box">
                    <div class="box-body">
                        <section id="ads-about">
                            <h2 class="title">Sobre</h2>
                            <p>
                                <span class="icon-container"><i class="fa fa-quote-left"></i></span>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sagittis ornare tellus, id maximus neque elementum id. Nulla vitae placerat erat, finibus condimentum sem. Suspendisse sagittis nibh eros. Praesent vel commodo est. Fusce et felis vehicula, hendrerit nunc eget, lobortis purus. Aenean ullamcorper facilisis lacus, id venenatis metus blandit id. In malesuada lacinia odio, vel feugiat nisi vehicula id. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque efficitur imperdiet odio id finibus. Praesent bibendum tempus lectus, sed auctor libero volutpat ut. Nulla nunc nisl, varius vitae tortor et, facilisis mollis tellus. Nulla auctor lacus ligula, at ultricies odio vehicula ac. Suspendisse ligula dolor, ultricies vitae cursus non, rutrum interdum tellus. Donec condimentum placerat efficitur. Proin imperdiet elementum malesuada. Fusce gravida justo nec urna laoreet, ut porta turpis tempus.
                                <span class="icon-container"><i class="fa fa-quote-right"></i></span>
                            </p>
                        </section>
                        <section id="ads-payment-methods">
                            <h2 class="title">Formas de pagamento</h2>
                            <ul class="default-list">
                                <li>
                                    <p>Dinheiro</p>
                                </li>
                                <li>
                                    <p>Visa</p>
                                </li>
                                <li>
                                    <p>Mastercard</p>
                                </li>
                                <li>
                                    <p>American Express</p>
                                </li>
                            </ul>
                        </section>
                        <section id="ads-facilities">
                            <h2 class="title">Serviços oferecidos</h2>
                            <ul class="default-list">
                                <li>
                                    <p>Alimentos e Bebidas - Alimentos</p>
                                </li>
                                <li>
                                    <p>Jantar</p>
                                </li>
                                <li>
                                    <p>Aberto 24 horas</p>
                                </li>
                                <li>
                                    <p>Proibido Fumar</p>
                                </li>
                                <li>
                                    <p>Área para crianças</p>
                                </li>
                                <li>
                                    <p>Ar Condicionado</p>
                                </li>
                                <li>
                                    <p>Buffet</p>
                                </li>
                                <li>
                                    <p>Wi-Fi</p>
                                </li>
                                <li>
                                    <p>Música ambiente</p>
                                </li>
                                <li>
                                    <p>Almoço</p>
                                </li>
                            </ul>
                        </section>
                        <section id="ads-photos">
                            <h2 class="title">Fotos</h2>
                            <ul class="default-list">
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="https://imagesapt.apontador-assets.com/fit-in/320x240/85cc585c72a5444a9925ee56342a125a/masp-14727425838177928.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="https://imagesapt.apontador-assets.com/fit-in/320x240/dc7eab874fd54b708440b1baf0dac9dc/hotel-unique-21013344190667287.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="https://imagesapt.apontador-assets.com/fit-in/320x240/2307326eef5d4975a350b26bf5a1288f/c40486140d5f2d5f28-3515711645403130.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="http://newpoi-assets.apontador.com.br.s3.amazonaws.com/assets/home/images/home_apontador_mais_bg.png">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="http://newpoi-assets.apontador.com.br.s3.amazonaws.com/assets/home/images/home_topo_bg2.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="https://imagesapt.apontador-assets.com/fit-in/320x240/85cc585c72a5444a9925ee56342a125a/masp-14727425838177928.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="https://imagesapt.apontador-assets.com/fit-in/320x240/dc7eab874fd54b708440b1baf0dac9dc/hotel-unique-21013344190667287.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="https://imagesapt.apontador-assets.com/fit-in/320x240/2307326eef5d4975a350b26bf5a1288f/c40486140d5f2d5f28-3515711645403130.jpg">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="http://newpoi-assets.apontador.com.br.s3.amazonaws.com/assets/home/images/home_apontador_mais_bg.png">
                                        </div>
                                    </a>
                                </li>
                                <li class="col-xs-3 col-sm-2 no-padding">
                                    <a href="#" class="square">
                                        <div class="square-wrapper">
                                            <img class="ads-photo" src="http://newpoi-assets.apontador.com.br.s3.amazonaws.com/assets/home/images/home_topo_bg2.jpg">
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
@stop