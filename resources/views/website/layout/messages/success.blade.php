@if(isset($messages['success']))
    <div class="alert alert-success alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <h4><i class="icon fa fa-ban"></i> Sucesso</h4>
        <ul>
            @foreach($messages['success'] as $message)
                <li>{{$message}}</li>
            @endforeach
        </ul>
    </div>
@endif