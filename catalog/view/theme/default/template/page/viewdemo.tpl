<!DOCTYPE html>
<html class=""><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xem website demo</title>
    <script src="<?php echo $base; ?>catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
    <link href="<?php echo $base; ?>catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen"/>
    <link href="<?php echo $base; ?>catalog/view/theme/default/stylesheet/view-demo.css" rel="stylesheet" media="screen"/>
    <link href="<?php echo $base; ?>catalog/view/theme/default/stylesheet/quocdv.css" rel="stylesheet" media="screen"/>
    <link href="<?php echo $base; ?>catalog/view/theme/default/stylesheet/stylesheet.css" rel="stylesheet" media="screen"/>
    <script src="<?php echo $base; ?>catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="<?php echo $base; ?>catalog/view/javascript/common.js" type="text/javascript"></script>
    </head>
<body>
<div id="view-demo">
    <div class="demo-header">
        <div class="container">
            <div class="row">
                <div class="col-md-6 hidden-sm hidden-xs text-left view-type">
                    <a class="desktop current" href="javascript:void()">
                        <svg viewBox="0 0 16 16" xmlns="http://www.w3.org/2000/svg">
                            <path d="M14 0H2C.897 0 0 .897 0 2v8c0 1.103.897 2 2 2h4.667v2h-2c-.552 0-1 .447-1 1 0 .553.448 1 1 1h6.667c.552 0 1-.447 1-1 0-.553-.448-1-1-1h-2v-2H14c1.104 0 2-.897 2-2V2c0-1.103-.896-2-2-2zM2 10V2h12v8H2z"></path>
                        </svg>
                        Desktop
                    </a>
                    <a class="mobile" href="javascript:void()">
                        <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path d="M18.7 0H6.3C5.6 0 5 .6 5 1.3v21.3c0 .8.6 1.4 1.3 1.4h12.3c.7 0 1.4-.587 1.4-1.287V1.3c0-.7-.6-1.3-1.3-1.3zm-6.2 22.6c-.7 0-1.3-.6-1.3-1.3 0-.7.6-1.3 1.3-1.3.7 0 1.3.6 1.3 1.3 0 .7-.6 1.3-1.3 1.3zm4.5-4c0 .2-.2.4-.4.4H8.4c-.2 0-.4-.2-.4-.4V3.4c0-.2.2-.4.4-.4h8.1c.3 0 .5.2.5.4v15.2z"></path>
                        </svg>
                        Mobile
                    </a>
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 text-right" style="line-height: 38px;">
                    <a href="<?php echo $link_back; ?>" class="view-back btn-viewdemo">
                        <i class="fa fa-mail-reply"></i>
                        Quay về xem chi tiết
                    </a>
                    <a href="javascript:void(0)" class="hidden-xs btn-viewdemo banner-home-registration event-Template-apply-form-open" data-toggle="modal" data-target="#myModal">Sử dụng giao diện này</a>
                    <a href="<?php echo $link_site; ?>" class="btn-viewdemo view-normal hidden-sm hidden-xs">Đóng</a>
                </div>
            </div>
        </div>
    </div>
    <div id="demo-wrapper" class="desktop-view">
        <div id="demo-container">
            <iframe id="frame" src="<?php echo $link_site; ?>" ></iframe>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var ismobile = getParameterByName('mobile');
            if (ismobile == 'true') {
                $(".view-type a").removeClass("current");
                $(".view-type a.mobile").addClass("current");
                $("#demo-container").attr('style', 'max-width: 375px; max-height: 568px; margin: -311px 0px 0px -160px; top: 50%; left: 50%;');
                console.log("done");
            }

        });
        $(function () {
            $(".view-type a.desktop").click(function () {
                $(".view-type a").removeClass("current");
                $(this).addClass("current");
                $("#demo-container").attr('style', 'max-width: 100%; max-height: 100%; margin: 0px; top: 0px; left: 0px;');
            });

            $(".view-type a.mobile").click(function () {
                $(".view-type a").removeClass("current");
                $(this).addClass("current");
                $("#demo-container").attr('style', 'border: 1px solid #333; margin-bottom: 20px; border-radius: 10px;max-width: 375px; max-height: 568px; margin: 20px 0px 0px -160px; top: 0; left: 48%;');
            });
        });
    </script>
    <div class="poup-user modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content modal-themes">
                <div class="modal-body text-center">
                    <button type="button" id="close" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                    <div class="user-buy">
                        <h3>Bạn đã có website tại Vlineweb</h3>
                        <p class="text-sample">                                    <span>
                                    Hệ thống sẽ cài đặt giao diện mặc định cho website dùng thử của bạn.
                                    Giao diện có phí sẽ sử dụng được khi bạn dùng Bizweb và tải mua giao diện
                                </span>
                        </p>
                        <a id="btnLogin" onclick="cart.add('<?php echo $product_id; ?>');" type="submit" class="btn-vline btn-buy"> Mua ngay </a>
                    </div>
                    <div class="user-free">
                        <h3>Bạn chưa có website ?</h3>
                        <p class="text-sample">
                            <span>
                                Hệ thống sẽ cài đặt giao diện mặc định cho website dùng thử của bạn.
                                Giao diện có phí sẽ sử dụng được khi bạn dùng Vlineweb và tải mua giao diện
                            </span>
                        </p>
                        <a id="btnSearch" href="javascript:;" href="javascript:;" data-toggle="modal" data-target="#register_quickly" type="button" class="btn-vline btn-free">
                            Đăng ký dùng thử miễn phí
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript">
    var elem = $('#frame');
    elem.load(function(){
        elem.contents().find(".chili.text-right").remove();
        //elem.contents().find("#content").css({"background":"none","padding-top":"1px",'padding-bottom':'0px','margin-top':'-15px'});
    });
    var mobile = false;
    $(window).resize(function () {
        var ww = $(window).width();
        if (ww > 855) {
            mobile = false;
            $('.fancybox-item.fancybox-close').addClass('fancybox-close-reg-web');
        }
        else {
            mobile = true;
            $('.fancybox-item.fancybox-close').removeClass('fancybox-close-reg-web');
        }
    });
    $(window).trigger('resize');
    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }
</script>
<div id="register_quickly" class="modal fade" style="padding-left: 0px">
    <div class="modal-dialog modal-lg" style="width: 100%; margin: 0px;">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title text-center">Đăng ký tài khoản</h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" style="padding: 0px">
                <div class="content-edit">
                    <iframe src="" class="" frameborder="0" width="100%" style="min-height: 550px"   id="modalFrame" height="100%"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $('#register_quickly').on('show.bs.modal', function (event) {
            var height=$( window ).height();
            $('#register_quickly .modal-dialog').css({'height': height});
            $('#modalFrame').css({'height': height});
            var elem = $('#modalFrame');
            elem.attr("src", '<?php echo $link_register; ?>');
        });
    });
</script>
    <style type="text/css">
        #register_quickly{
            padding:0px!important;
        }
        </style>
</body></html>