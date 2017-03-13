<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <title>marketing</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway|Sansita&amp;subset=latin-ext">
        <link rel="stylesheet" href="/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="/vendor/fontawesome/css/fontawesome.min.css">
        <link rel="stylesheet" href="/vendor/old/AdminLTE-2.3.6/dist/css/adminltewnap.css">
        <link rel="stylesheet" href="/vendor/old/AdminLTE-2.3.6/dist/css/skins/wnap-blue.css">
        <link rel="stylesheet" href="/css/old/website.css">
    </head>
    <body class="skin-blue layout-top-nav">
        <div id="home" class="wrapper">
            <!--<header class="main-header">
                <nav class="navbar navbar-static-top">
                    <div class="navbar-custom-menu">
                        <ul class="nav navbar-nav">
                            <li class="dropdown user user-menu">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <img src="" class="user-image"></img>
                                    <span class="hidden-xs">Nome do Usuário</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </header>-->
            <div class="content-wrapper container-fluid">
                <section id="search" class="row">
                    <div id="search-presentation" class="col-xs-12">
                        <h1><span id="search-typed"></span><span id="typed"></span></h1>
                    </div>
                    <div id="search-text" class="col-xs-12 col-xs-offset-0 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
                        <form>
                            <div class="col-xs-12 col-sm-5">
                                <input class="form-control input-lg" type="text" placeholder="O que você está procurando?">
                            </div>
                            <div class="col-xs-12 col-sm-5">
                                <input class="form-control input-lg" type="text" placeholder="Onde você deseja encontrar?">
                            </div>
                            <div class="col-xs-12 col-sm-2">
                                <button type="submit" class="btn btn-block btn-default btn-flat btn-lg"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                    </div>
                    <div id="search-category" class="col-xs-12 col-xs-offset-0 col-sm-10 col-sm-offset-1 col-md-8 col-md-offset-2 col-lg-6 col-lg-offset-3">
                        <ul id="categories">
                            <li class="category col-xs-4 col-lg-2">
                                <a href="#">
                                    <i class="fa fa-coffee"></i>
                                    <span>Cafés</span>
                                </a>
                            </li>
                            <li class="category col-xs-4 col-lg-2">
                                <a href="#">
                                    <i class="fa fa-coffee"></i>
                                    <span>Restaurantes</span>
                                </a>
                            </li>
                            <li class="category col-xs-4 col-lg-2">
                                <a href="#">
                                    <i class="fa fa-coffee"></i>
                                    <span>Hotéis</span>
                                </a>
                            </li>
                            <li class="category col-xs-4 col-lg-2">
                                <a href="#">
                                    <i class="fa fa-coffee"></i>
                                    <span>Turismo</span>
                                </a>
                            </li>
                            <li class="category col-xs-4 col-lg-2">
                                <a href="#">
                                    <i class="fa fa-coffee"></i>
                                    <span>PetShops</span>
                                </a>
                            </li>
                            <li class="category col-xs-4 col-lg-2">
                                <a href="#">
                                    <i class="fa fa-coffee"></i>
                                    <span>Mais categorias</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </section>
                <section id="highlights">
                    <div class="col-xs-12">
                        <h2>Destaques</h2>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <div class"content">
                            <div class="box box-widget widget-category">
                                <div class="widget-category-header bg-black">
                                    <h3 class="widget-record-name">Elizabeth Pierce</h3>
                                    <h5 class="widget-category-name">Web Designer</h5>
                                </div>
                                <div class="widget-category-image">
                                    <img class="img-circle" src="data:image/gif;base64,R0lGODlhMAAwAPUAAFJNSevp6KGblo6KhczMzIR9er66t5mZmXBqZd3a2K+sqpWRjfPy8mFaVYaEgtbT0I6Li3d0ceXj4sbDwKelpIeCfWZmZre1tJOLh5qUjvf499fW1YBzccS/vYl9e+/v76Sdm3RwbFhTUGRgXMXEw6ulo9/e3tXRz7y3tNvY1ouFg7+9vH14dLayrpSMi4uCfqWhn+Ph4IR6dmNdWa+rqHlzbubm5srHxXNualxYVFZRTbKtq3p0cWhjX+vr6lRPSyH5BAQHAP8ALAAAAAAwADAAAAb/wI9wSCwKGZokY7lMahjGqHQ6XNo2txVqu1oRNrHPkkqeajYljErlcmUOB5Cc0rrFxuW8mILAsQoVFQMDCwsZb3AHMAZ3emQaBA09fTg1LH8vKgNthYcZIDZQjlIaB5KTOKmVloAVaxgZGBijZDwjPbipPLu7MjIvmy4sMysatFEMGyO3PTM5MxY4PH8FBSwhPQ0jIKLHRRo3zzO4CxURCM0z6j0hKjQECRLd3kIaKyLqMwgpMTEmCQATmJBgI0AAEycS0PtmQEe+GTcEDvSBx4aNGAkePFhIBNyPHCBzGAg40KBJGBNMaAzA8ciGHDr+AKAQMIGNCQ4CSJCAgEKM/5UthyAQseIEiAEZAdrYMcLEQAQwVD7wEfSDBhciUEwgMOGE13gGQvSL0WLCBq9Vrd7QsaNDBwIEND7YgAXghgRnCaSYx5FBBAFuScA9ITeFXI0EbshLq6HDgA4GOpC4Mfgw4hsn0la5oCVyB8pw4RowQIAEiQB8q26YMNrz5Bs3JLsNYExzvTMktKBo7RYyaTtPNGt4AAPG2ywGtijHDEPFgg5pobTw4AtDibeh4T6YIABCIQw0KPYNIECGh0yvBNDwjKKEJ08LdqR2xID8rzUqZGEoZMiTgP8ACpDBBLUdw0AJBQyiICfvBegggIvRAo4gg7ThQn/vHfIggBkYUP/gKALkZyF/GZa4oQChjKLBCS/IYuGIJTb4YAYnfFiGBju0qN+LF3YSYwYOZoDCfFRkoIl+LvKIoYkcljAKAwm8AMwgSGKg5I8aAphiHuAUgB+VVVoJI5aHJECkERoYIAN+moCJ5Ig+/kiAjWbs8At6aygYpiz8LfkeCXSSUsKdeOap545XZliMHgyAYJ6UUrLZ5gBV8uiGJxh4yGh5HpwHaaFthqnkdxecaUQG5nXqKaSSUlqpkhi0YGoRGXCgqqqftupmkhaqMKQjJnB6a6e5srkrrztsyaUNMLwwLLHFfukqkhmcRssJFDjggLPPfgpqfrJoC8MJVI1yAgwOXFJSwLPQejvlABlQQIIJ5Y5iAwEXwLDAANoGUoEvAMsQCCwC0EHCBhK05INKWVxwAQ0UUFBccQpwhlkCMbBUFRNQ+OCDRSBb5DFVHNt2BMcoM0FPEAA7">
                                </div>
                                <div class="box-body">
                                    <h2>marketing</h2>
                                </div>
                                <div class="footer">
                                    <div class="row">
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">3,200</h5>
                                                <span class="description-text">Sales</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">13,000</h5>
                                                <span class="description-text">Followers</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="description-block">
                                                <h5 class="description-header">35</h5>
                                                <span class="description-text">Products</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <div class"content">
                            <div class="box box-widget widget-category">
                                <div class="widget-category-header bg-black">
                                    <h3 class="widget-record-name">Elizabeth Pierce</h3>
                                    <h5 class="widget-category-name">Web Designer</h5>
                                </div>
                                <div class="widget-category-image">
                                    <img class="img-circle" src="data:image/gif;base64,R0lGODlhMAAwAPUAAFJNSevp6KGblo6KhczMzIR9er66t5mZmXBqZd3a2K+sqpWRjfPy8mFaVYaEgtbT0I6Li3d0ceXj4sbDwKelpIeCfWZmZre1tJOLh5qUjvf499fW1YBzccS/vYl9e+/v76Sdm3RwbFhTUGRgXMXEw6ulo9/e3tXRz7y3tNvY1ouFg7+9vH14dLayrpSMi4uCfqWhn+Ph4IR6dmNdWa+rqHlzbubm5srHxXNualxYVFZRTbKtq3p0cWhjX+vr6lRPSyH5BAQHAP8ALAAAAAAwADAAAAb/wI9wSCwKGZokY7lMahjGqHQ6XNo2txVqu1oRNrHPkkqeajYljErlcmUOB5Cc0rrFxuW8mILAsQoVFQMDCwsZb3AHMAZ3emQaBA09fTg1LH8vKgNthYcZIDZQjlIaB5KTOKmVloAVaxgZGBijZDwjPbipPLu7MjIvmy4sMysatFEMGyO3PTM5MxY4PH8FBSwhPQ0jIKLHRRo3zzO4CxURCM0z6j0hKjQECRLd3kIaKyLqMwgpMTEmCQATmJBgI0AAEycS0PtmQEe+GTcEDvSBx4aNGAkePFhIBNyPHCBzGAg40KBJGBNMaAzA8ciGHDr+AKAQMIGNCQ4CSJCAgEKM/5UthyAQseIEiAEZAdrYMcLEQAQwVD7wEfSDBhciUEwgMOGE13gGQvSL0WLCBq9Vrd7QsaNDBwIEND7YgAXghgRnCaSYx5FBBAFuScA9ITeFXI0EbshLq6HDgA4GOpC4Mfgw4hsn0la5oCVyB8pw4RowQIAEiQB8q26YMNrz5Bs3JLsNYExzvTMktKBo7RYyaTtPNGt4AAPG2ywGtijHDEPFgg5pobTw4AtDibeh4T6YIABCIQw0KPYNIECGh0yvBNDwjKKEJ08LdqR2xID8rzUqZGEoZMiTgP8ACpDBBLUdw0AJBQyiICfvBegggIvRAo4gg7ThQn/vHfIggBkYUP/gKALkZyF/GZa4oQChjKLBCS/IYuGIJTb4YAYnfFiGBju0qN+LF3YSYwYOZoDCfFRkoIl+LvKIoYkcljAKAwm8AMwgSGKg5I8aAphiHuAUgB+VVVoJI5aHJECkERoYIAN+moCJ5Ig+/kiAjWbs8At6aygYpiz8LfkeCXSSUsKdeOap545XZliMHgyAYJ6UUrLZ5gBV8uiGJxh4yGh5HpwHaaFthqnkdxecaUQG5nXqKaSSUlqpkhi0YGoRGXCgqqqftupmkhaqMKQjJnB6a6e5srkrrztsyaUNMLwwLLHFfukqkhmcRssJFDjggLPPfgpqfrJoC8MJVI1yAgwOXFJSwLPQejvlABlQQIIJ5Y5iAwEXwLDAANoGUoEvAMsQCCwC0EHCBhK05INKWVxwAQ0UUFBccQpwhlkCMbBUFRNQ+OCDRSBb5DFVHNt2BMcoM0FPEAA7">
                                </div>
                                <div class="box-body">
                                    <h2>marketing</h2>
                                </div>
                                <div class="footer">
                                    <div class="row">
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">3,200</h5>
                                                <span class="description-text">Sales</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">13,000</h5>
                                                <span class="description-text">Followers</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="description-block">
                                                <h5 class="description-header">35</h5>
                                                <span class="description-text">Products</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <div class"content">
                            <div class="box box-widget widget-category">
                                <div class="widget-category-header bg-black">
                                    <h3 class="widget-record-name">Elizabeth Pierce</h3>
                                    <h5 class="widget-category-name">Web Designer</h5>
                                </div>
                                <div class="widget-category-image">
                                    <img class="img-circle" src="data:image/gif;base64,R0lGODlhMAAwAPUAAFJNSevp6KGblo6KhczMzIR9er66t5mZmXBqZd3a2K+sqpWRjfPy8mFaVYaEgtbT0I6Li3d0ceXj4sbDwKelpIeCfWZmZre1tJOLh5qUjvf499fW1YBzccS/vYl9e+/v76Sdm3RwbFhTUGRgXMXEw6ulo9/e3tXRz7y3tNvY1ouFg7+9vH14dLayrpSMi4uCfqWhn+Ph4IR6dmNdWa+rqHlzbubm5srHxXNualxYVFZRTbKtq3p0cWhjX+vr6lRPSyH5BAQHAP8ALAAAAAAwADAAAAb/wI9wSCwKGZokY7lMahjGqHQ6XNo2txVqu1oRNrHPkkqeajYljErlcmUOB5Cc0rrFxuW8mILAsQoVFQMDCwsZb3AHMAZ3emQaBA09fTg1LH8vKgNthYcZIDZQjlIaB5KTOKmVloAVaxgZGBijZDwjPbipPLu7MjIvmy4sMysatFEMGyO3PTM5MxY4PH8FBSwhPQ0jIKLHRRo3zzO4CxURCM0z6j0hKjQECRLd3kIaKyLqMwgpMTEmCQATmJBgI0AAEycS0PtmQEe+GTcEDvSBx4aNGAkePFhIBNyPHCBzGAg40KBJGBNMaAzA8ciGHDr+AKAQMIGNCQ4CSJCAgEKM/5UthyAQseIEiAEZAdrYMcLEQAQwVD7wEfSDBhciUEwgMOGE13gGQvSL0WLCBq9Vrd7QsaNDBwIEND7YgAXghgRnCaSYx5FBBAFuScA9ITeFXI0EbshLq6HDgA4GOpC4Mfgw4hsn0la5oCVyB8pw4RowQIAEiQB8q26YMNrz5Bs3JLsNYExzvTMktKBo7RYyaTtPNGt4AAPG2ywGtijHDEPFgg5pobTw4AtDibeh4T6YIABCIQw0KPYNIECGh0yvBNDwjKKEJ08LdqR2xID8rzUqZGEoZMiTgP8ACpDBBLUdw0AJBQyiICfvBegggIvRAo4gg7ThQn/vHfIggBkYUP/gKALkZyF/GZa4oQChjKLBCS/IYuGIJTb4YAYnfFiGBju0qN+LF3YSYwYOZoDCfFRkoIl+LvKIoYkcljAKAwm8AMwgSGKg5I8aAphiHuAUgB+VVVoJI5aHJECkERoYIAN+moCJ5Ig+/kiAjWbs8At6aygYpiz8LfkeCXSSUsKdeOap545XZliMHgyAYJ6UUrLZ5gBV8uiGJxh4yGh5HpwHaaFthqnkdxecaUQG5nXqKaSSUlqpkhi0YGoRGXCgqqqftupmkhaqMKQjJnB6a6e5srkrrztsyaUNMLwwLLHFfukqkhmcRssJFDjggLPPfgpqfrJoC8MJVI1yAgwOXFJSwLPQejvlABlQQIIJ5Y5iAwEXwLDAANoGUoEvAMsQCCwC0EHCBhK05INKWVxwAQ0UUFBccQpwhlkCMbBUFRNQ+OCDRSBb5DFVHNt2BMcoM0FPEAA7">
                                </div>
                                <div class="box-body">
                                    <h2>marketing</h2>
                                </div>
                                <div class="footer">
                                    <div class="row">
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">3,200</h5>
                                                <span class="description-text">Sales</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">13,000</h5>
                                                <span class="description-text">Followers</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="description-block">
                                                <h5 class="description-header">35</h5>
                                                <span class="description-text">Products</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                        <div class"content">
                            <div class="box box-widget widget-category">
                                <div class="widget-category-header bg-black">
                                    <h3 class="widget-record-name">Elizabeth Pierce</h3>
                                    <h5 class="widget-category-name">Web Designer</h5>
                                </div>
                                <div class="widget-category-image">
                                    <img class="img-circle" src="data:image/gif;base64,R0lGODlhMAAwAPUAAFJNSevp6KGblo6KhczMzIR9er66t5mZmXBqZd3a2K+sqpWRjfPy8mFaVYaEgtbT0I6Li3d0ceXj4sbDwKelpIeCfWZmZre1tJOLh5qUjvf499fW1YBzccS/vYl9e+/v76Sdm3RwbFhTUGRgXMXEw6ulo9/e3tXRz7y3tNvY1ouFg7+9vH14dLayrpSMi4uCfqWhn+Ph4IR6dmNdWa+rqHlzbubm5srHxXNualxYVFZRTbKtq3p0cWhjX+vr6lRPSyH5BAQHAP8ALAAAAAAwADAAAAb/wI9wSCwKGZokY7lMahjGqHQ6XNo2txVqu1oRNrHPkkqeajYljErlcmUOB5Cc0rrFxuW8mILAsQoVFQMDCwsZb3AHMAZ3emQaBA09fTg1LH8vKgNthYcZIDZQjlIaB5KTOKmVloAVaxgZGBijZDwjPbipPLu7MjIvmy4sMysatFEMGyO3PTM5MxY4PH8FBSwhPQ0jIKLHRRo3zzO4CxURCM0z6j0hKjQECRLd3kIaKyLqMwgpMTEmCQATmJBgI0AAEycS0PtmQEe+GTcEDvSBx4aNGAkePFhIBNyPHCBzGAg40KBJGBNMaAzA8ciGHDr+AKAQMIGNCQ4CSJCAgEKM/5UthyAQseIEiAEZAdrYMcLEQAQwVD7wEfSDBhciUEwgMOGE13gGQvSL0WLCBq9Vrd7QsaNDBwIEND7YgAXghgRnCaSYx5FBBAFuScA9ITeFXI0EbshLq6HDgA4GOpC4Mfgw4hsn0la5oCVyB8pw4RowQIAEiQB8q26YMNrz5Bs3JLsNYExzvTMktKBo7RYyaTtPNGt4AAPG2ywGtijHDEPFgg5pobTw4AtDibeh4T6YIABCIQw0KPYNIECGh0yvBNDwjKKEJ08LdqR2xID8rzUqZGEoZMiTgP8ACpDBBLUdw0AJBQyiICfvBegggIvRAo4gg7ThQn/vHfIggBkYUP/gKALkZyF/GZa4oQChjKLBCS/IYuGIJTb4YAYnfFiGBju0qN+LF3YSYwYOZoDCfFRkoIl+LvKIoYkcljAKAwm8AMwgSGKg5I8aAphiHuAUgB+VVVoJI5aHJECkERoYIAN+moCJ5Ig+/kiAjWbs8At6aygYpiz8LfkeCXSSUsKdeOap545XZliMHgyAYJ6UUrLZ5gBV8uiGJxh4yGh5HpwHaaFthqnkdxecaUQG5nXqKaSSUlqpkhi0YGoRGXCgqqqftupmkhaqMKQjJnB6a6e5srkrrztsyaUNMLwwLLHFfukqkhmcRssJFDjggLPPfgpqfrJoC8MJVI1yAgwOXFJSwLPQejvlABlQQIIJ5Y5iAwEXwLDAANoGUoEvAMsQCCwC0EHCBhK05INKWVxwAQ0UUFBccQpwhlkCMbBUFRNQ+OCDRSBb5DFVHNt2BMcoM0FPEAA7">
                                </div>
                                <div class="box-body">
                                    <h2>marketing</h2>
                                </div>
                                <div class="footer">
                                    <div class="row">
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">3,200</h5>
                                                <span class="description-text">Sales</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4 border-right">
                                            <div class="description-block">
                                                <h5 class="description-header">13,000</h5>
                                                <span class="description-text">Followers</span>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="description-block">
                                                <h5 class="description-header">35</h5>
                                                <span class="description-text">Products</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <script src="/vendor/jquery/js/jquery.min.js"></script>
        <script src="/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--<script src="/vendor/typed/js/typed.min.js"></script>-->
        <script src="/vendor/typed/js/typed-modified.js"></script>
        <script src="/js/website.js"></script>
    </body>
</html>