<header class="row main-header">
    <button type="button" class="navbar-toggle">
        <span>menu</span>
        <div class="menu-icon"><span></span></div>
    </button>
    <nav class="navbar hidden-xs">
        <div class="col-xs-12 header-content">
            <ul class="nav">
                <li class="col-xs-12 col-sm-3 text-left no-padding">
                    <a href="/" class="title">logo</a>
                </li>
                <li class="col-xs-12 col-sm-6 no-padding">
                    @include('website.layout.form-search')
                </li>
                <li class="col-xs-12 col-sm-3 text-right no-padding">
                    <a href="/login" class="title">login</a>
                </li>
            </ul>
        </div>
    </nav>
</header>