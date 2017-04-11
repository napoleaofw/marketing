@extends('website.layout.index')
@section('register')
<div id="register" class="page-wrapper">
    <div class="container-fluid">
        <div class="row page-content">
            <div class="register-box">
                <div class="register-box-body">
                    <form method="post">
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" placeholder="Nome completo">
                            <span class="glyphicon glyphicon-user form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="email" class="form-control" placeholder="E-mail">
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" placeholder="Senha">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" placeholder="Repita a senha">
                            <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <button type="submit" class="btn btn-primary btn-block btn-flat">Registrar</button>
                            </div>
                        </div>
                    </form>
                    <a href="/login" class="text-center">Eu já tenho uma conta</a>
                </div>
            </div>
        </div>
    </div>
</div>
@stop