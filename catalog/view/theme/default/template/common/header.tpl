<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="robots" content="noindex">
    <meta property="og:locale" content="vi_VN">
    <meta property="og:type" content="website">
    <meta property="og:description" content="<?php echo $description; ?>">
    <meta property="og:url" content="<?php echo $base; ?>">
    <meta property="og:site_name" content="<?php echo $title; ?>">
    <meta property="og:image" content="<?php echo 'http://yhay.info/aliweb/image/catalog/logo.png'; ?>">
</head>
<body>
    <script src="/public/assets/js/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <link href="/public/assets/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <script src="/public/assets/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="/public/assets/css/load-font.css" rel="stylesheet" type="text/css">
    <!--link href="/public/assets/css/amination.css" rel="stylesheet"-->
    <link href="/public/assets/css/stylesheet.css" rel="stylesheet">
    <div class="menu-main">
            <nav id="menu-main" class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand logo" href="/"><img height="98%" src="https://cdn1.homeadvisor.com/images/consumer/home/ha-logo-title-sm.png" alt="ssss" title="Biệt thự vihomes"></a>
                    </div>
                    <style type="text/css">
                        #menu-search .form-control{
                            margin: 8px 0;
                        }
                        #menu-search.menu-nav li{
                            margin-left:5px;
                        }
                    </style>
                    <ul id="menu-search" class="nav navbar-nav menu-nav pull-left">
                        <li>
                            <select class="form-control" style="border-radius: 3px; padding: 5px; border: 1px solid #e0e0e0;">
                                <option>HCM</option>
                            </select>
                        </li>
                        <li>
                            <select class="form-control" style="border-radius: 3px; padding: 5px; border: 1px solid #e0e0e0;">
                                <option>Quận 1</option>
                                <option>Quận 2</option>
                                <option>Quận 3</option>
                                <option>Quận Thủ Đức</option>
                                <option>Quận Tân Bình</option>
                            </select>
                        </li>
                        <li><input id="search-map-input" type="text" class="form-control" placeholder="Nhập trường học, khu công nghiệp, công ty..." style="border-radius: 3px; padding: 10px; border: 1px solid #e0e0e0; width: 414px; margin: 8px 0;"></li>
                        <li><input type="text" class="form-control" placeholder="Giá" style="border-radius: 3px; padding: 10px; border: 1px solid #e0e0e0; width: 90px; margin: 8px 0;"></li>
                        <li><input type="text" class="form-control" placeholder="Diện tích" style="border-radius: 3px; padding: 10px; border: 1px solid #e0e0e0; width: 90px; margin: 8px 0;"></li>
                        <li><button class="form-control btn btn-primary" style="border-radius: 3px;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Tìm</button></li>
                    </ul>
                    <ul class="nav navbar-nav menu-nav">
                        <li><button href="<?php echo $menu_map; ?>" class="btn btn-primary" style="margin-right:5px; border-radius: 3px;">Đăng nhập</button></li>
                        <li><button href="<?php echo $list; ?>" class="btn btn-primary" style="border-radius: 3px;">Đăng ký</button></li>
                    </ul>
                </div>
            </nav>
    </div>