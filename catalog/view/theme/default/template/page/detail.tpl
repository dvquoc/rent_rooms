<?php echo $header ?>
<link href="/public/assets/css/list-page.css" rel="stylesheet" media="screen"/>
<div id="content-page" class="container page-layout-box">
<div class="top-detail">
	<div class="body-detail">
			<div class="row">
				<div class="col-md-8 img-rooms" style="padding:15px; padding-top: 10px; padding-right: 0px; position: relative; height: 430px; overflow: hidden">
					<ul class="control-tabs" style="z-index:1; background: #2b443661; width:100%; position: absolute; left: 15px; top: 10px; list-style-type: none; margin: 0px; padding: 5px;">
                        <li class="active pull-left"><a style="background-color:#fff; line-height: 16px; padding: 5px;font-size: 12px;" data-toggle="tab" href="#img-detail">Hình ảnh</a></li>
						<li class="pull-left" style="margin-left: 3px; line-height: 16px; background-color:#fff; padding: 5px;font-size: 12px;"><a style="background-color:#fff; line-height: 16px; padding: 5px;font-size: 12px;" data-toggle="tab" href="#map-detail">Xem vị trí</a></li>
						<li class="pull-right" style="padding: 5px;font-size: 12px; color: #fff; line-height: 15px; padding-right: 30px;">1/7 hình ảnh</li>
					</ul>
                    <div class="tab-content" style="width: 100%; height: 100%; background-color: #eee">
                        <div id="img-detail" class="tab-pane fade in active" style="width: 100%; height: 100%;">
                            <img src="<?php echo $detail['images'][0]['link']; ?>" class="img-responsive">
                        </div>
                        <div id="map-detail" class="tab-pane fade" style="width: 100%; height: 100%">

                        </div> 
                    </div>
				</div>
				<div class="col-md-4 info-room">
                    <div class="inner" style="background-color: #fff; padding:10px; border: 1px solid #eaeaea; margin-top: 10px; height: 420px;box-shadow: 0px 0px 4px -3px #000;">
                        <div class="row" style="margin: -10px; margin-top: -11px; padding: 5px 5px 2px 5px; background-color: #eee;">
                            <div class="col-md-2 avata">
                                <img style="border-radius: 100%" src="https://static.trulia-cdn.com/userimg/user_m_00_m.gif" width="40px">
                            </div>
                            <div class="col-md-10 info-master">
                                <b class="name-master">Người quản lý</b><br>
                                <b style="font-size: 18px" class="phone-master"><?php echo $detail['phone_master']?></b>
                            </div>
                        </div>
                        <div class="des">
                            <p style="font-size: 13px; ll">Các phòng trọ được chúng tôi kiểm duyệt, Nếu có thông tin gì sai hãy vui lòng báo cáo lỗi. Để giúp cải thiện dịch vụ tốt nhất.</p>
                        </div>
                        <div style="font-size: 12px;">
                            <div class="row item">
                                <div style="background-color: #eee; margin:0 14px; padding: 5px;">
                                    <div class="col-md-6"><b>Tiền điện: </b><?php echo $detail['price_electricity']?></div>
                                    <div class="col-md-6"><b>Tiền nước: </b><?php echo $detail['price_electricity']?></div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="row item">
                                <div style="background-color:#fff ; margin:0 15px; padding: 5px;">
                                    <div class="col-md-6"><b>Tiền cọc: </b><?php echo $detail['price_deposit']?> triệu</div>
                                    <div class="col-md-6"><b>Số người ở: </b><?php echo $detail['amount_people']?> người</div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="row item">
                                <div style="background-color: #eee; margin:0 15px; padding: 5px;">
                                    <div class="col-md-6"><b>Tình trạng: </b> còn phòng</div>
                                    <div class="col-md-6"><b>Kiểm duyệt: </b> đã duyệt</div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div style="color:#00ba51; font-size: 16px; margin-bottom: 5px; margin-top: 5px; line-height: 32px;">
                            <i class="fa fa-check" style="margin-right: 10px; font-size: 20px; border-radius: 100%; border:1px solid #00ba51; padding: 5px;"></i>
                            <span class="info-time">Quản lý giờ giấc:  <?php echo $detail['close_door']?></span>
                        </div>

                        <button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-bookmark"></i> Lưu xem sau</button>
                        <button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-phone"></i> Liên hệ chủ nhà - Gặp: Chị Hương</button>
                    </div>
				</div>
			</div>
	</div>
</div>
<div class="header" style="margin:10px 0; background-color:#f3f3f3; position: sticky; top: 55.8px; color: #545454; font-size: 15px; padding: 10px 0 10px 0px; z-index:5">
    <div class="container">
        <div class="row">
            <div class="col-md-5">
                <h1 style="margin-bottom: 0; font-size: 22px;" class="text-info"><?php echo $detail['name']?></h1>
                <div style="color: #333; font-size: 13px" class="text-address">
                    <img width="20" align="left" src="https://static.chotot.com.vn/storage/NHA_CDN_PRODUCTION/9fcda47ac73ec5deb8298a9a649681d1.png">
                    <?php echo $detail['address']?>
                </div>
            </div>
            <div class="col-md-2">
                <b class="text-title">Giá thuê phòng</b>
                <div class="text-info"><b><?php echo $detail['price']/1000000?></b> Triệu/tháng </div>
            </div>
            <div class="col-md-2">
                <b class="text-title">Diện tích</b>
                <div class="text-info"><b><?php echo $detail['acreage']?></b> m2</div>
            </div>
        </div>
    </div>
</div>
<div style="background-color: #fff;">
		<div class="row ">
			<div class="col-md-8 room-detail">
				<h3 class="text-title">Nội quy phòng trọ</h3>
				<div class="regulation_room" style="padding-left: 30px">
					<p><?php echo $detail['regulation_room']?></p>
				</div>
				<h3 class="text-title">Điểm nổi bật</h3>
				<div class="highlight" style="padding-left: 30px">
					<p><?php echo $detail['highlight']?></p>
				</div>
                <?php if(!empty($specials)) { ?>
                    <div class="special">
                        <div class="row">
                            <div class="col-md-12">
                                <h3>Mọi người cũng tìm kiếm khu vực này</h3>
                            </div>
                            <div class="tag">
                                <?php foreach($specials as $special) { ?>
                                <div class="col-md-6">
                                    <a href="/tim-kiem/phong-tro-gan-<?php echo $special['slug']; ?>/<?php echo $special['location']['coordinates'][1] ?>,<?php echo $special['location']['coordinates'][0] ?>" class="arena"><?php echo $special['name'] ?></a>
                                </div>
                                <?php } ?>
                            </div>
                            <div class="clearfix" style="margin-bottom: 15px;"></div>
                        </div>
                    </div>
                <?php } ?>

                <div class="room-relative">
                    <h3>Các phòng trọ phù hợp</h1>
                    <div style="margin-left: 15px">
                        <?php echo $list_content;  ?>
                    </div>
                </div>
			</div>
			<div class="col-md-4">
				<img src="https://thietkewebvinhphuc.com/wp-content/uploads/2017/06/tai-sao-banner-quang-cao-van-song-khoe-du-khong-ai-them-click.jpg" class="img-responsive">
				<img style="margin-top: 10px;" src="https://static.vecteezy.com/system/resources/previews/000/179/049/non_2x/half-price-sale-banner-poster-or-flyer-template-design-vector.jpg" class="img-responsive">
			</div>
			
		</div>
</div>
</div>
<script type="text/javascript">
    var optionMap = {
        center: new google.maps.LatLng(<?php echo $detail['location'][1]; ?>, <?php echo $detail['location'][0]; ?>),
        zoom: 14,
        scaleControl: false,
        fullscreenControl: false,
        mapTypeControl: false,
        streetViewControl: false,
        overviewMapControl: true,
        scrollwheel: true,
        disableDoubleClickZoom: true,
    }
    new google.maps.Map($("#map-detail").get(0),optionMap);
</script>
<?php echo $footer; ?>