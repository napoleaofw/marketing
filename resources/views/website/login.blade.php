@extends('website.layout.index')
@section('login')
<div id="login" class="page-wrapper">
    <div class="container-fluid">
        <div class="row page-content">
            <div class="login-box">
                <div class="login-box-body">
                    <form method="post">
                        <div class="form-group has-feedback">
                            <input type="email" class="form-control" placeholder="E-mail">
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" placeholder="Senha">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <button type="submit" class="btn btn-primary btn-block btn-flat">Entrar</button>
                            </div>
                        </div>
                    </form>
                    <a href="#">Esqueci minha senha</a><br>
                    <a href="/register" class="text-center">Registrar uma nova conta</a>
                </div>
            </div>
        </div>
    </div>
</div>
@stop