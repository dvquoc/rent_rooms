<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]>
<html dir="ltr" lang="vi" class="ie8"><![endif]-->
<!--[if IE 9 ]>
<html dir="ltr" lang="vi" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="ltr" lang="vi>">
<!--<![endif]-->
<head>
    <title><?php echo $title ?></title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="robots" content="noindex">
    <meta name="description" content="<?php echo $meta_description; ?>">
    <meta name="keywords" content="SATELLITE">

    <link rel="shortcut icon" href="https://www.renderitcreative.com/wp-content/uploads/2016/05/renderitcreative_new-favicon-05.2016-1.png" type="image/x-icon">
    <link rel="canonical" href="https://thachpham.com/wordpress/wordpress-development/wordpress-loop-cac-tham-quan-trong.html">
    <link rel="publisher" href="https://plus.google.com/b/113591657045991604117/+Thachpham">
    <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>

    <meta property="og:locale" content="vi_VN">
    <meta property="og:type" content="article">
    <meta property="og:description" content="<?php echo $description; ?>">
    <meta property="og:url" content="<?php echo $base; ?>">
    <meta property="og:site_name" content="<?php echo $title; ?>">
    <meta property="og:image" content="<?php echo 'http://yhay.info/aliweb/image/catalog/logo.png'; ?>">
</head>
<body class="<?php echo $classPage ?>">

    <link href="/public/assets/css/layout.css" rel="stylesheet" media="screen"/>
    <link href="/public/assets/css/boostrap-custom.css" rel="stylesheet" media="screen"/>
    <!--link href="/public/assets/css/load-font.css" rel="stylesheet" type="text/css" -->
    <!--
    <link href="/admin-rooms/view/javascript/bootstrap/opencart/opencart.css" type="text/css" rel="stylesheet" />
    <link type="text/css" href="/admin-rooms/view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
    <link href="/public/assets/css/amination.css" rel="stylesheet"-->
    <link href="/public/assets/css/stylesheet.css" rel="stylesheet"> 
    <link rel="stylesheet" href="/public/assets/js/font-awesome/css/font-awesome.min.css">
    <link href="/public/assets/js/jquery/owl-carousel/owl.carousel.min.css" rel="stylesheet">
    <?php foreach ($styles as $style) { ?>
    <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>

    <script src="/public/assets/js/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="/public/assets/js/bootstrap/js/bootstrap.min.js" defer type="text/javascript"></script>
    <!-- script src="/public/assets/js/jquery/jquery.validate.min.js" type="text/javascript"></script -->
    <script src="/public/assets/js/common.js" type="text/javascript"></script>
    <!--script src='https://www.google.com/recaptcha/api.js'></script-->
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=drawing,places&region=vn&language=vi&key=AIzaSyBAqWDJPR4hUAraN1rwQIEzP0lAtfu8OmI" type="text/javascript"></script>
    <?php foreach ($scripts as $script) { ?>
        <script type="text/javascript" src="<?php echo $script; ?>"></script>
    <?php } ?>
        <nav id="menu-main" class="navbar" style="padding: 5px 0px;">
            <div class="<?php echo $classPage !='find-map' ? 'container' : 'container-fluid' ?>">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" id="menu-toggle" onclick="openNav()" data-toggle="tooltip" data-placement="right" title="Nhấp chuột để xem các dịc vụ khác">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand logo" style="text-decoration: none; margin-right: 20px; margin-left:5px; margin-top: 3px;" href="/">
                        <span style="font-weight: bold; font-size: 32px; color: #00BA51; display:block;">Piapy</span>
                        <span style="display:block; font-size: 12px; color: #7b7b7b;">conphong.com</span>
                    </a>
                </div>
                <style type="text/css">
                    #menu-search .form-control, #menu-right .item{
                        margin: 5px 0!important; font-size: 13px;
                    }
                    #menu-search.menu-nav li{
                        margin-left:5px;
                    }
                </style>
                <ul id="menu-search" class="nav navbar-nav menu-nav pull-left">
                    <li class="small" style="margin-right: 5px; margin-top: 8px" data-toggle="modal" data-target="#get-location-user">
                        <span class="city-location-show">Hồ Chí Minh</span>
                        <span class="district-location-show"> Thủ Đức</span>
                    </li>
                    <li>
                        <input id="search-map-input" type="text" class="form-control" placeholder="Nhập trường học, khu công nghiệp, công ty..." style="width:300px;" data-toggle="tooltip" data-placement="bottom">
                    </li>
                    <li class="dropup">
                        <input id="price-input" type="text" class="form-control" placeholder="Giá" style="width: 80px;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                            <li><a href="javascript:;">< 1 triệu</a></li>
                            <li><a href="javascript:;">1 triệu - 1.5 triệu</a></li>
                            <li><a href="javascript:;">1.5 triệu - 2 triệu</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="javascript:;">2 triệu - 2.5 triệu</a></li>
                            <li><a href="javascript:;">2.5 triệu - 3 triệu</a></li>
                            <li><a href="javascript:;">3.5 triệu - 4 triệu</a></li>
                            <li><a href="javascript:;">4.5 triệu - 5 triệu</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="javascript:;"> > 5 triệu</a></li>
                        </ul>
                    </li>
                    <li class="dropup">
                        <input id="area-input" type="text" class="form-control" placeholder="Diện tích" style="width: 70px;"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                            <li><a href="javascript:;">< 10 m2</a></li>
                            <li><a href="javascript:;">10 m2 - 15 m2</a></li>
                            <li><a href="javascript:;">15 m2 - 20 m2</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="javascript:;">20 m2 - 25 m2</a></li>
                            <li><a href="javascript:;">25 m2 - 30 m2</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="javascript:;"> Nhà nguyên căn</a></li>
                        </ul>
                    </li>
                    <li>
                        <button id="btn-s-h" class="form-control btn btn-primary" style="border-radius: 3px;"><span class="fa fa-arrow-right" aria-hidden="true"></span></button>
                    </li>
                </ul>
                <ul id="menu-right" class="nav navbar-nav menu-nav pull-right" style="">
                    <?php if(isset($_SESSION['id_user']) || isset($_SESSION['source_id'])){?>
                        <li class="item">
                            <a class="btn btn-primary" href="/quan-ly-phong-tro"><i class="glyphicon glyphicon-plus"></i> Chủ phòng</a>
                        </li>
                        <li class="item">
                            <img src="<?php echo $_SESSION['img']?>"><?php echo $_SESSION['name']?>
                        </li>
                        <a href="/thong-tin-chu-tro">Thông tin tài khoản</a>
                        <a href="/dang-xuat">Đăng xuất</a>
                    <?php }else{?>
                        <li class="item">
                            <a class="btn btn-primary" style="padding: 5px;margin-right: 5px;" href="/ow-dang-ky"><i class="fa fa-building"></i> Chủ phòng</a>
                        </li>
                        <li class="item"><button href="<?php echo $list; ?>" class="btn btn-line" style="border-radius: 3px;"><i class="glyphicon glyphicon-user"></i><a href="/dang-nhap-chu-phong"> Đăng nhập </a>/ <a href="/dang-ky-chu-phong">Đăng ký</a></button></li>
                    <?php }?>
                   
                </ul>
            </div>
        </nav>
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

