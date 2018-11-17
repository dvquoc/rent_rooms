<?php echo $header ?>
<link href="/public/assets/css/list-page.css" rel="stylesheet" media="screen"/>
<link href="/public/assets/css/detail.css" rel="stylesheet" media="screen"/>
<div id="content-page" class="container page-layout-box">
<div class="top-detail">
	<div class="body-detail">
			<div class="row">
				<div class="col-md-8 stage-rooms">
					<ul class="control-tabs clearfix">
                        <li class="active pull-left"><a class="img-show" data-toggle="tab" href="#img-detail">Hình ảnh</a></li>
						<li class="pull-left"><a class="map-show" data-toggle="tab" href="#map-detail">Xem vị trí</a></li>
						<li class="pull-right text-number-img">1/7 hình ảnh</li>
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
                    <div class="inner">
                        <div class="info-owner">
                                <span class="name-master">Người quản lý</span><br>
                                <b style="font-size: 16px" class="phone-master"><?php echo $detail['phone_master']?></b>
                        </div>
                        <div class="des">
                            <p style="font-size: 13px;">Các phòng trọ được chúng tôi kiểm duyệt, Nếu có thông tin gì sai hãy vui lòng báo cáo lỗi. Để giúp cải thiện dịch vụ tốt nhất.</p>
                        </div>
                        <div class="info-primary">
                            <div class="item">
                                <div class="clearfix">
                                    <div class="pull-left"><b>Tiền điện: </b><?php echo $detail['price_electricity']?></div>
                                    <div class="pull-right"><b>Tiền nước: </b><?php echo $detail['price_electricity']?></div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="clearfix">
                                    <div class="pull-left"><b>Tiền cọc: </b><?php echo $detail['price_deposit']?> triệu</div>
                                    <div class="pull-right"><b>Số người ở: </b><?php echo $detail['amount_people']?> người</div>
                                </div>
                            </div>
                            <div class="item">
                                <div class="clearfix">
                                    <div class="pull-left"><b>Tình trạng: </b> còn phòng</div>
                                    <div class="pull-right"><b>Kiểm duyệt: </b> đã duyệt</div>
                                </div>
                            </div>
                        </div>
                        <div class="info-time">
                            <span>Quản lý giờ giấc:  <?php echo $detail['close_door']?></span>
                        </div>

                        <button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-bookmark"></i> Lưu xem sau</button>
                        <button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-phone"></i> Liên hệ chủ nhà - Gặp: Chị Hương</button>
                    </div>
				</div>
			</div>
	</div>
</div>
<div class="header">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1 style="margin-bottom: 0; font-size: 22px;" class="title"><?php echo $detail['name']?></h1>
                <div style="color: #333; font-size: 13px" class="text-address">
                    <img width="20" align="left" src="https://static.chotot.com.vn/storage/NHA_CDN_PRODUCTION/9fcda47ac73ec5deb8298a9a649681d1.png">
                    <?php echo $detail['address']?>
                </div>
            </div>
            <div class="col-md-2 price">
                <span class="text-title">Giá thuê phòng</span>
                <div class="text-info"><b><?php echo $detail['price']/1000000?></b> Triệu/tháng </div>
            </div>
            <div class="col-md-2 area">
                <span class="text-title">Diện tích</span>
                <div class="text-info"><b><?php echo $detail['acreage']?></b> m2</div>
            </div>
            <div class="col-md-2 other">
                <span class="text-title">Khác</span>
                <div class="text-info" style="font-size: 11px;">Tiền điện: <b><?php echo $detail['acreage']?></b> kg Tiền nước: <b><?php echo $detail['acreage']?></b> kg</div>
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