@extends('website.layout.index')
@section('ads')
<div id="ads" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <section id="ads-more-info" class="col-xs-12 col-sm-7 col-md-8 col-lg-7 col-lg-offset-2">
                <div class="box">
                    <div class="box-body">
                        <h1 id="ads-name" class="title">nome do estabelecimento</h1>
                        <section id="ads-address">
                            <h3 class="title">
                                Endereço
                            </h3>
                            <p>Avenida Moema, 594, Indianópolis, São Paulo - SP, CEP: 04077-022</p>
                        </section>
                        <section id="ads-phone">
                            <h3 class="title">
                                Telefone
                            </h3>
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
                        <section id="ads-about">
                            <h3 class="title">Sobre</h3>
                            <p>
                                <span class="icon-container"><i class="fa fa-quote-left"></i></span>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce sagittis ornare tellus, id maximus neque elementum id. Nulla vitae placerat erat, finibus condimentum sem. Suspendisse sagittis nibh eros. Praesent vel commodo est. Fusce et felis vehicula, hendrerit nunc eget, lobortis purus. Aenean ullamcorper facilisis lacus, id venenatis metus blandit id. In malesuada lacinia odio, vel feugiat nisi vehicula id. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque efficitur imperdiet odio id finibus. Praesent bibendum tempus lectus, sed auctor libero volutpat ut. Nulla nunc nisl, varius vitae tortor et, facilisis mollis tellus. Nulla auctor lacus ligula, at ultricies odio vehicula ac. Suspendisse ligula dolor, ultricies vitae cursus non, rutrum interdum tellus. Donec condimentum placerat efficitur. Proin imperdiet elementum malesuada. Fusce gravida justo nec urna laoreet, ut porta turpis tempus.
                                <span class="icon-container"><i class="fa fa-quote-right"></i></span>
                            </p>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
@stop