@extends('website.layout.index')
@section('register')
<div id="register" class="page-wrapper">
    <div class="container-fluid">
        <div class="row page-content">
            <div class="register-box">
                <div class="register-box-body">
                    @include('website.layout.messages')
                    <form method="post">
                        <input type="hidden" name="_token" value="{{csrf_token()}}">
                        <div class="form-group has-feedback">
                            <input name="email" type="email" class="form-control" placeholder="E-mail">
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input name="password" type="password" class="form-control" placeholder="Senha">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                        <div class="form-group has-feedback">
                            <input name="repeatPassword" type="password" class="form-control" placeholder="Repita a senha">
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