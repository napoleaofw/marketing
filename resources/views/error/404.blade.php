@extends('website.layout.index')
@section('error')
<div id="error-404" class="page-wrapper">
    <div class="container-fluid">
        <div class="row page-content">
            <div class="col-xs-12 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
                <div class="error-content">
                    <p>404</p><p class="title">Página não encontrada.</p>
                    <a href="/">Clique aqui para retornar à página principal.</a>
                </div>
            </div>
        </div>
    </div>
</div>
@stop