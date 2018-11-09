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

    <link href="/public/assets/css/menu-bar.css" rel="stylesheet" media="screen"/>
    <link href="/public/assets/css/stylesheet.css" rel="stylesheet"> 
    <link rel="stylesheet" href="/public/assets/js/font-awesome/css/font-awesome.min.css">
    <link href="/public/assets/js/jquery/owl-carousel/owl.carousel.min.css" rel="stylesheet">
    <?php foreach ($styles as $style) { ?>
    <link rel="<?php echo $style['rel']; ?>" type="text/css" href="<?php echo $style['href']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>

    <script src="/public/assets/js/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <script src="/public/assets/js/bootstrap/js/bootstrap.min.js" defer type="text/javascript"></script>
    <script src="https://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    <script src="/public/assets/js/common.js" type="text/javascript"></script>
    <script src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=drawing,places&region=vn&language=vi&key=AIzaSyBAqWDJPR4hUAraN1rwQIEzP0lAtfu8OmI" type="text/javascript"></script>
    <?php foreach ($scripts as $script) { ?>
        <script type="text/javascript" src="<?php echo $script; ?>"></script>
    <?php } ?>
        <nav id="menu-main" class="navbar" style="padding: 5px 0px;">
            <div class="clearfix <?php echo $classPage !='find-map' ? 'container' : 'container-fluid' ?>">
                <div class="navbar-header pull-left">
                    <button type="button" class="navbar-toggle pull-left" id="menu-toggle" onclick="openNav()" data-toggle="tooltip" data-placement="right" title="Nhấp chuột để xem các dịc vụ khác">

                    </button>
                    <a class="pull-left logo" href="/">
                        <span class="logo-site">Conphong.<span style="color: #FF9800">com</span></span>
                        <span class="slogan">Gõ là có, tìm được ngay</span>
                    </a>
                </div>
                <ul class="navbar-nav pull-left">
                    <li id="l-u-s" class="small" data-toggle="modal" data-target="#get-location-user">
                        <svg class="down-location-user" aria-hidden="true" data-prefix="fal" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
                            <path fill="currentColor" d="M119.5 326.9L3.5 209.1c-4.7-4.7-4.7-12.3 0-17l7.1-7.1c4.7-4.7 12.3-4.7 17 0L128 287.3l100.4-102.2c4.7-4.7 12.3-4.7 17 0l7.1 7.1c4.7 4.7 4.7 12.3 0 17L136.5 327c-4.7 4.6-12.3 4.6-17-.1z"></path>
                        </svg>
                        <span class="city-location-show">Hồ Chí Minh</span>
                        <span class="district-location-show"> Thủ Đức</span>
                    </li>
                    <li>
                        <input id="search-map-input" type="text" name="search-map-input" class="form-control" placeholder="Nhập trường học, khu công nghiệp, công ty..." style="width:300px;" data-toggle="tooltip" data-placement="bottom">
                    </li>
                    <li id="li-price-input" class="dropup">
                        <input id="price-input" type="text" class="form-control" placeholder="Giá" style="width: 80px;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <ul class="dropdown-menu list-val-search" data-to="price-input"  aria-labelledby="dropdownMenu2">
                            <li><a data-item-val ="0-1" href="javascript:;">< 1 triệu</a></li>
                            <li><a data-item-val ="1-1.5" href="javascript:;">1 triệu - 1.5 triệu</a></li>
                            <li><a data-item-val ="1.5-2" href="javascript:;">1.5 triệu - 2 triệu</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a data-item-val ="2-2.5" href="javascript:;">2 triệu - 2.5 triệu</a></li>
                            <li><a data-item-val ="2.5-3" href="javascript:;">2.5 triệu - 3 triệu</a></li>
                            <li><a data-item-val ="3.5-4" href="javascript:;">3.5 triệu - 4 triệu</a></li>
                            <li><a data-item-val ="4-4.5" href="javascript:;">4.5 triệu - 5 triệu</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a data-price-val ="5-20" href="javascript:;"> > 5 triệu</a></li>
                        </ul>
                    </li>
                    <li id="li-area-input" class="dropup">
                        <input id="area-input" type="text" class="form-control" placeholder="Diện tích" style="width: 70px;"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <ul class="dropdown-menu list-val-search" data-to="area-input" aria-labelledby="dropdownMenu2">
                            <li><a data-item-val ="0-10" href="javascript:;">< 10 m2</a></li>
                            <li><a data-item-val ="10-15" href="javascript:;">10 m2 - 15 m2</a></li>
                            <li><a data-item-val ="15-20" href="javascript:;">15 m2 - 20 m2</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a data-item-val ="20-25" href="javascript:;">20 m2 - 25 m2</a></li>
                            <li><a data-item-val ="25-30" href="javascript:;">25 m2 - 30 m2</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a data-item-val ="1" href="javascript:;"> Nhà nguyên căn</a></li>
                        </ul>
                    </li>
                    <li>
                        <button id="btn-s-h" class="form-control btn btn-yellow"><span class="fa fa-search" aria-hidden="true"></span></button>
                    </li>
                </ul>
                <ul class="menu-right owner-header pull-right">
                    <?php if(isset($_SESSION['id_user']) || isset($_SESSION['source_id'])){?>
                        <li class="item dropdown">
                            <a href="javascript;;" class="dropdown-toggle info-user" data-toggle="dropdown">
                                <img src="<?php echo $_SESSION['img']?>" width="24px" height="24px" class="info-image">
                                <b style="margin-left: 10px;"><?php echo $_SESSION['name']?></b>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href="/quan-ly-phong-tro">Quản lý phòng trọ</a></li>
                                <li><a href="/thong-tin-chu-tro">Thông tin tài khoản</a></li>
                                <li><a href="/dang-xuat">Đăng xuất</a></li>
                            </ul>
                        </li>
                    <?php }else{?>
                        <li class="item dropup owner-input">
                            <a class="btn btn-yellow" href="javascript:;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                               <i class="fa fa-plus"></i> Chủ phòng
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu2">
                                <li>
                                    <a class="login-header" href="/dang-nhap-chu-phong"><i class="fa fa-user"></i> Đăng nhập </a>
                                </li>
                                <li>
                                    <a class="login-header" href="/dang-ky-chu-phong"> <i class="fa fa-sign-in"></i> Đăng ký</a>
                                </li>
                            </ul>
                        </li>
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

