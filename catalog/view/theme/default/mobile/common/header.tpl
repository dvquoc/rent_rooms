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
                <ul class="navbar-nav pull-left" style="display: none">
                    <li id="l-u-s" class="small" data-toggle="modal" data-target="#get-location-user">
                        <svg class="down-location-user" aria-hidden="true" data-prefix="fal" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
                            <path fill="currentColor" d="M119.5 326.9L3.5 209.1c-4.7-4.7-4.7-12.3 0-17l7.1-7.1c4.7-4.7 12.3-4.7 17 0L128 287.3l100.4-102.2c4.7-4.7 12.3-4.7 17 0l7.1 7.1c4.7 4.7 4.7 12.3 0 17L136.5 327c-4.7 4.6-12.3 4.6-17-.1z"></path>
                        </svg>
                        <span class="city-location-show">Hồ Chí Minh</span>
                        <span class="district-location-show"> Thủ Đức</span>
                    </li>
                    <li class="keyword before-background">
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
                        <button id="btn-s-h" class="form-control btn btn-yellow"><span class="fa fa-search" aria-hidden="true"></span> Tìm kiếm</button>
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
                            <a class="user-owner" href="javascript:;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                                <svg class="icon-owner" version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                    viewBox="0 0 487.6 487.6" style="enable-background:new 0 0 487.6 487.6; width:25px; height:25px" xml:space="preserve">
                            <g>
                                <path fill="#ffffff" d="M0,243.8c0,134.4,109.4,243.8,243.8,243.8s243.8-109.4,243.8-243.8S378.2,0,243.8,0C109.4,0,0,109.4,0,243.8z
			 M101.9,410.8c36-24.3,66.9-39.9,76-44.4c5.5-2.7,9-8.2,9-14.4v-30.6c0-2.2-0.6-4.3-1.7-6.2c-6.2-10.5-10.5-23.1-12.7-37.4
			c-0.7-4.8-4.3-8.7-8.8-9.9c-1.2-1.5-4.6-6.7-8.9-21.8c-3.4-12-3.4-17.9-3.1-20.3c3.7,0,7.3-1.7,9.6-4.7c2.6-3.3,3.3-7.7,1.9-11.6
			c-4.8-13.6-5.4-27.5-1.7-41.7c3.2-13.6,10.5-26.4,21.8-38c6.1-6.5,13.1-12.3,20.6-17c0.1-0.1,0.3-0.2,0.4-0.3
			c6.3-4.4,12.8-7.7,19.3-9.9h0.1c5.5-1.9,11.2-2.9,17.3-3.2c16.4-1.4,31.1,1.6,44,9.3c14.2,7.8,19.9,18,19.9,18
			c2,3.8,5.8,6.3,10,6.6c0.1,0,5.5,1,10.4,7.4c5.8,7.7,14,27.7,4,76c-1.1,5.5,1.6,11,6.5,13.4c0.4,1.9,0.9,7.7-2.9,21.2
			c-3.4,12-6.2,17.7-7.9,20.3c-2.1-0.3-4.4,0-6.4,0.8c-3.8,1.6-6.6,5.1-7.3,9.1c-2,11.3-5.1,21.4-9.3,30c-0.8,1.7-1.2,3.5-1.2,5.3
			v35.4c0,6.2,3.4,11.7,9,14.4c9.2,4.5,40.1,20.2,76,44.4c-38.3,32.6-87.8,52.3-141.9,52.3C189.7,463.1,140.2,443.4,101.9,410.8z
			 M243.8,24.5c120.9,0,219.3,98.4,219.3,219.3c0,57.8-22.5,110.5-59.2,149.7c-34.3-23.5-64.8-39.8-78.6-46.7v-27.4
			c3.3-7.2,6-15.2,8-23.7c9.8-3.7,16.7-15.1,23.2-38c5.9-20.9,5.4-35.6-1.6-44c7.3-40.1,4-69.7-9.9-88c-7.2-9.6-15.6-13.8-21.4-15.6
			c-4.1-5.8-12.4-15.2-26.2-22.8c-17.1-10.1-36.7-14.3-57.8-12.5c-8,0.4-15.9,1.9-23.6,4.5h-0.1c-8.6,2.9-17,7.2-25.1,12.8
			c-9.2,5.9-17.7,12.9-25,20.6c-14.4,14.7-23.8,31.3-27.9,49c-3.8,14.6-4.2,29.2-1.1,43.6c-1.3,1-2.6,2.1-3.7,3.5
			c-7.2,8.7-7.8,22.6-1.8,43.9c4,14.1,9.2,28.6,18.2,35.3c2.7,13.5,7,25.8,12.9,36.6v22.2c-13.7,6.9-44.3,23.2-78.6,46.7
			c-36.7-39.2-59.3-91.9-59.3-149.7C24.5,122.9,122.9,24.5,243.8,24.5z"/>
                                </g>
                            </svg>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-right text-center" aria-labelledby="dropdownMenu2">
                                <li >
                                    <p>Đăng nhập để đăng tin</p>
                                    <a class="login-header" href="/dang-nhap-chu-phong"><i class="fa fa-user"></i> Đăng nhập </a>
                                </li>
                                <li>
                                    <p>-- Hãy đăng ký nếu chưa có tài khoản --</p>
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

