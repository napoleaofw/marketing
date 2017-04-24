@if(isset($messages['validation']))
    <div class="alert alert-danger alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <h4><i class="icon fa fa-ban"></i> Atenção!</h4>
        <ul>
            @foreach($messages['validation'] as $field => $fieldMessages)
                @foreach($fieldMessages as $message)
                    <li>{{$message}}</li>
                @endforeach
            @endforeach
        </ul>
    </div>
@endif