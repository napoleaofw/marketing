<header class="row main-header">
    <nav class="navbar">
        <div class="col-xs-12 header-content">
            <ul class="nav">
                <li class="col-xs-12 col-sm-3 text-left no-padding">
                    <a href="/" class="title">
                        Baita Guia
                    </a>
                </li>
                <li class="col-xs-12 col-sm-6 no-padding">
                    @include('website.layout.form-search')
                </li>
                <!--<li class="col-xs-12 col-sm-3 text-right no-padding">
                    <a href="/login" class="title">login</a>
                </li>-->
                @if(Auth::user())
                    <li class="col-xs-12 col-sm-3 text-right no-padding">
                        <a href="/logout" class="title">logout</a>
                    </li>
                @endif
            </ul>
        </div>
    </nav>
</header>