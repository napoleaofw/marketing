<form action="/search" method="get">
    <div class="col-xs-12">
        <div class="input-group">
            <input name="q" type="text" class="form-control" placeholder="O que você está procurando?">
            @if(isset($currentCity))
                <input name="city" type="hidden" value="{{$currentCity->name_uri}}">
            @else
                @foreach($uriParameters as $parameter => $values)
                    <input name="{{$parameter}}" type="hidden" value="{{$values}}">
                @endforeach
            @endif
            <div class="input-group-btn">
                <button type="submit" class="btn btn-default btn-flat">
                    <i class="fa fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</form>