<header class="row main-header">
    <nav class="navbar">
        <div class="container-fluid">
            <div class="navbar-header">
                <a href="/" class="title">Baita Guia</a>
                <button class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar">
                    <div class="menu-title">
                        <span>menu</span>
                    </div>
                    <div class="menu-icon">
                        <span></span>
                    </div>
                </button>
            </div>
            <div id="main-navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    @if(Auth::user())
                        <li class="col-xs-12 col-sm-6 no-padding form-search-container">
                            @include('website.layout.form-search')
                        </li>
                        <li class="col-xs-12 col-sm-2 col-sm-offset-4 text-right no-padding">
                            <a href="/logout" class="title">logout</a>
                        </li>
                    @else
                        <li class="col-xs-12 col-sm-8 no-padding form-search-container">
                            @include('website.layout.form-search')
                        </li>
                    @endif
                </ul>
            </div>
        </div>
    </nav>
</header>