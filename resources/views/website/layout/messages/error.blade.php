@if(isset($messages['error']))
    <div class="alert alert-danger alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <h4><i class="icon fa fa-ban"></i> Erro</h4>
        <ul>
            @foreach($messages['error'] as $message)
                <li>{{$message}}</li>
            @endforeach
        </ul>
    </div>
@endif