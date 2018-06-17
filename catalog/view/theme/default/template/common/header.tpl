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
    <link href="/public/assets/css/layout.css" rel="stylesheet" media="screen"/>
    <link href="/public/assets/css/boostrap-custom.css" rel="stylesheet" media="screen"/>
    <link href="/public/assets/css/load-font.css" rel="stylesheet" type="text/css">
    <!--link href="/public/assets/css/amination.css" rel="stylesheet"-->
    <link href="/public/assets/css/stylesheet.css" rel="stylesheet">
    <div class="menu-main" style="position: fixed; top: :0px; left: 0px; width: 100%">
        <nav id="menu-main" class="navbar" style="padding: 10px 0px;">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" id="menu-toggle" onclick="openNav()" data-toggle="tooltip" data-placement="right" title="Nhấp chuột để xem các dịc vụ khác">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand logo" style="text-decoration: none; margin-right: 20px; margin-left:5px; margin-top: 3px;" href="/">
                        <span style="font-weight: bold; font-size: 32px; color: #00BA51; display:block;">MAP</span>
                        <i style="display:block; font-size: 14px; color: #7b7b7b; font-weight: bold;">conphong.com</i>
                    </a>
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
                    <li><input id="search-map-input" type="text" class="form-control" placeholder="Nhập trường học, khu công nghiệp, công ty..." style="width: 300px; margin: 8px 0;" data-toggle="tooltip" data-placement="bottom" title="Nhập tên trường, công ty, khu công nghiệp hay một địa điểm bạn cần tiềm kiếm."></li>
                    <li><input type="text" class="form-control" placeholder="Giá" style="width: 90px; margin: 8px 0;"></li>
                    <li><input type="text" class="form-control" placeholder="Diện tích" style="width: 90px; margin: 8px 0;"></li>
                    <li><button class="form-control btn btn-primary" style="border-radius: 3px;"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Tìm</button></li>
                </ul>
                <ul class="nav navbar-nav menu-nav pull-right" style="margin-top: 7px; margin-bottom: 7px;">
                    <li><button href="<?php echo $menu_map; ?>" data-toggle="modal" data-target="#addRoom" class="btn btn-primary" style="margin-right:5px; border-radius: 3px;"><i class="glyphicon glyphicon-plus"></i> Thêm phòng trọ</button></li>
                    <li><button href="<?php echo $list; ?>" class="btn btn-primary" style="border-radius: 3px;"><i class="glyphicon glyphicon-user"></i> Đăng nhập / Đăng ký</button></li>
                </ul>
            </div>
        </nav>
    </div>
    <div id="mySidenav" class="sidenav" onmouseleave="closeNav()">
        <a href="#">Thuê nhà nguyên căn</a>
        <a href="#">Vận chuyển</a>
        <a href="#">Dụng cụ phòng trọ</a>
        <a href="#">Giới thiệu</a>
        <div class="sidenav-footer">
            Copyright @ conphong.com, Data from google
        </div>
    </div>
    <div id="inner-body" style=" position: relative">
        <script>
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
                document.getElementById("mySidenav").style.left = "0";
                document.getElementById("inner-body").style.marginLeft = "250px";
            }
            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
                document.getElementById("mySidenav").style.left = "-250px";
                document.getElementById("inner-body").style.marginLeft = "0";
            }
            console.log(document.body);
        </script>
    </div>