@extends('website.layout.index')
@section('search')
<div id="search" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row page-content">
            <section id="search-filters" class="col-xs-12 col-sm-5 col-md-4 col-lg-3 col-lg-offset-1">
                <div class="box">
                    <div class="box-body">
                        <h1 id="" class="title">Opções de pesquisa</h1>
                        <section id="search-category">
                            <h2 class="title">Categorias</h2>
                            <ul class="nav">
                                <li class="filter">
                                    <input id="checkbox1" type="checkbox">
                                    <a href="#">nome da categoria</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox2" type="checkbox">
                                    <a href="#">nome da categoria</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox3" type="checkbox">
                                    <a href="#">nome da categoria</a>
                                </li>
                            </ul>
                        </section>
                        <section id="search-subcategory">
                            <h2 class="title">Subcategorias</h2>
                            <ul class="nav">
                                <li class="filter">
                                    <input id="checkbox4" type="checkbox">
                                    <a href="#">nome da subcategoria</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox5" type="checkbox">
                                    <a href="#">nome da subcategoria</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox6" type="checkbox">
                                    <a href="#">nome da subcategoria</a>
                                </li>
                            </ul>
                        </section>
                        <section id="facility">
                            <h2 class="title">Facilidades</h2>
                            <ul class="nav">
                                <li class="filter">
                                    <input id="checkbox7" type="checkbox">
                                    <a href="#">nome da facilidade</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox8" type="checkbox">
                                    <a href="#">nome da facilidade</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox9" type="checkbox">
                                    <a href="#">nome da facilidade</a>
                                </li>
                            </ul>
                        </section>
                        <section id="state">
                            <h2 class="title">Estados</h2>
                            <ul class="nav">
                                <li class="filter">
                                    <input id="checkbox10" type="checkbox">
                                    <a href="#">nome do estado</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox11" type="checkbox">
                                    <a href="#">nome do estado</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox12" type="checkbox">
                                    <a href="#">nome do estado</a>
                                </li>
                            </ul>
                        </section>
                        <section id="city">
                            <h2 class="title">Cidades</h2>
                            <ul class="nav">
                                <li class="filter">
                                    <input id="checkbox13" type="checkbox">
                                    <a href="#">nome da cidade</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox14" type="checkbox">
                                    <a href="#">nome da cidade</a>
                                </li>
                                <li class="filter">
                                    <input id="checkbox15" type="checkbox">
                                    <a href="#">nome da cidade</a>
                                </li>
                            </ul>
                        </section>
                        <button id="find" class="btn btn-default btn-block btn-flat">encontrar</button>
                    </div>
                </div>
            </section>
            <section id="search-results" class="col-xs-12 col-sm-7 col-md-8 col-lg-7">
                <ul class="default-list search-results-list">
                    <li class="search-result">
                        <a href="#">
                            <div class="box">
                                <div class="box-header no-padding">
                                    <div class="search-result-image-container">
                                        <img class="search-result-image" src="https://almsaeedstudio.com/themes/AdminLTE/dist/img/photo2.png">
                                        <div class="search-result-background-effect"></div>
                                    </div>
                                </div>
                                <div class="box-body">
                                    <div class="search-result-content">
                                        <h1 id="search-result-name" class="title">nome do estabelecimento</h1>
                                    </div>
                                </div>
                            </div>
                        </a>
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