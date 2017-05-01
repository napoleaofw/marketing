<form action="/search?{{isset($cityNameUri) ? 'city=$cityNameUri' : ''}}" method="get">
    <div class="col-xs-12">
        <div class="input-group">
            <input name="q" type="text" class="form-control" placeholder="O que você está procurando?">
            <div class="input-group-btn">
                <button type="submit" class="btn btn-default btn-flat">
                    <i class="fa fa-search"></i>
                </button>
            </div>
        </div>
    </div>
</form>