@extends('website.layout.index')
@section('home')
<div id="city-selection" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <ul class="nav city-list">
                    @foreach($recordsCity as $recordCity)
                    <li class="city">
                        <a href="/{{$recordCity->name_uri}}" class="link">{{$recordCity->name}}</a>
                    </li>
                    @endforeach
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
                        <li class="col-xs-12 col-sm-8 no-padding">
                            <a href="#" class="title" data-toggle="modal" data-target="#city-selection">Você está em {{$cityName}}. Mude a cidade aqui.</a>
                        </li>
                        <li class="col-xs-12 col-sm-4 no-padding">
                            <a href="#" class="title">login</a>
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
                        <form method="post">
                            <div class="col-xs-12">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="O que você está procurando?">
                                    <div class="input-group-btn">
                                        <button type="submit" class="btn btn-default btn-flat">
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
            <section id="category-wrapper" class="col-xs-12">
                <h1 class="title title-margin">Categorias para {{$cityName}}</h1>
                <ul class="nav category-list">
                    @foreach($cityCategoryList as $cityCategory)
                    <li class="category col-xs-12 col-sm-6 col-md-4 col-lg-2">
                        <div class="box">
                            <div class="box-body">
                                <div class="category-content col-xs-12">
                                    <div class="category-icon stroke-default">
                                        @include('website.category.'.$cityCategory->category_name_uri)
                                    </div>
                                    <div class="category-text">
                                        <a href="#" class="link uppercase title" title="{{$cityCategory->category_name}}">{{$cityCategory->category_name}}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    @endforeach
                </ul>
            </section>
        </div>
    </div>
</div>
@stop