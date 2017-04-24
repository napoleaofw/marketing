@extends('website.layout.index')
@section('login')
<div id="login" class="page-wrapper">
    <div class="container-fluid">
        <div class="row page-content">
            <div class="login-box">
                <div class="login-box-body">
                    @if(Session::has('transaction_error'))
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <h4><i class="icon fa fa-ban"></i> Erro.</h4>
                        {{Session::get('transaction_error')}}
                    </div>
                    @endif
                    @if(count($errors) > 0)
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                        <h4><i class="icon fa fa-ban"></i> Atenção!</h4>
                        <ul>
                            @foreach($errors->all() as $error)
                            <li>{{$error}}</li>
                            @endforeach
                        </ul>
                    </div>
                    @endif
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