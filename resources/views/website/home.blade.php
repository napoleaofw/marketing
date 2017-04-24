@extends('website.layout.index')
@section('home')
<div id="modal-city" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="title">Escolha uma cidade</h4>
            </div>
            <div class="modal-body">
                <ul class="nav city-list">
                    <li class="city">
                        <a href="/dois-irmaos" class="link">Dois Irmãos</a>
                    </li>
                    <li class="city">
                        <a href="/morro-reuter" class="link">Morro Reuter</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div id="home" class="page-wrapper">
    <div class="container-fluid">
        <header class="row">
            <button type="button" class="navbar-toggle">
                <div class="menu-title">
                    <span>menu</span>
                </div>
                <div class="menu-icon">
                    <span></span>
                </div>
            </button>
            <nav class="navbar navbar-collapse hidden-xs">
                <div class="col-xs-12 header-content">
                    <ul class="nav">
                        <li class="col-xs-12 col-sm-2 text-left no-padding">
                            <a href="/" class="title">logo</a>
                        </li>
                        <li class="col-xs-12 col-sm-4 text-left no-padding">
                            <a href="#" data-toggle="modal" data-target="#modal-city">Você está em <span class="title">Dois Irmãos</span>.Você pode mudar a cidade aqui.</a>
                        </li>
                        <li class="col-xs-12 col-sm-4 no-padding form-search-container">
                            @include('website.layout.form-search')
                        </li>
                        <li class="col-xs-12 col-sm-2 text-right no-padding">
                            <a href="/login" class="title">login</a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <div class="row page-content">
            <section id="search-wrapper" class="col-xs-12 no-padding">
                <div id="search-background"></div>
                <div id="search-content">
                    <h1 class="title">frase principal para o website marketing regional<span class="typed"></span></h1>
                    <div class="col-xs-12 col-xs-offset-0 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-lg-4 col-lg-offset-4">
                        @include('website.layout.form-search')
                    </div>
                </div>
            </section>
            <section id="category-wrapper" class="col-xs-12">
                <h1 class="title title-margin">Categorias em Dois Irmãos</h1>
                <ul class="nav category-list">
                    @for($i=0;$i<50;$i++)
                    <li class="category col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class="box">
                            <div class="box-body">
                                <div class="category-content col-xs-12">
                                    <div class="category-icon stroke-default">
                                        @include('common.svg.category.alimentos-e-bebidas')
                                    </div>
                                    <div class="category-text">
                                        <a href="/dois-irmaos/category/alimentos-e-bebidas" class="link uppercase title" title="Alimentos e Bebidas">Alimentos e Bebidas</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="category col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class="box">
                            <div class="box-body">
                                <div class="category-content col-xs-12">
                                    <div class="category-icon stroke-default">
                                        @include('common.svg.category.animais')
                                    </div>
                                    <div class="category-text">
                                        <a href="/dois-irmaos/category/animais" class="link uppercase title" title="Animais">Animais</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    @endfor
                </ul>
            </section>
        </div>
    </div>
</div>
@stop