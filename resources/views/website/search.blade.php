@extends('website.layout.index')
@section('search')
<div id="search" class="page-wrapper">
    <div class="container-fluid">
        @include('website.layout.header')
        <div class="row">
            <section id="search-filters" class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
                <div class="box">
                    <div class="box-body">
                        <h1 id="" class="title">nome do estabelecimento</h1>
                        <section id="">
                            <h2 class="title">
                                Apresentação
                            </h2>
                        </section>
                    </div>
                </div>
            </section>
            <section id="search-results" class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
                <div class="box">
                    <div class="box-body">
                        <ul class="default-list search-results-list">
                            <li class="search-result">
                                <a href="#">
                                    <div class="search-result-image-container">
                                        <img class="search-result-image" src="https://almsaeedstudio.com/themes/AdminLTE/dist/img/photo2.png">
                                        <div class="search-result-background-effect"></div>
                                    </div>
                                    <div class="box">
                                        <div class="box-body">
                                            <div class="search-result-content">
                                                <h1 id="search-result-name" class="title">nome do estabelecimento</h1>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </section>
        </div>
    </div>
</div>
@stop