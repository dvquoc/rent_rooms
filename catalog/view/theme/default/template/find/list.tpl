<?php echo $header;
if(!isset($_COOKIE['origin_ref']))
{
    setcookie('origin_ref', $_SERVER['HTTP_REFERER']);
} ?>
<link href="/public/assets/css/list-page.css" rel="stylesheet" media="screen"/>
<div class="container">
  	<div class="row">
		<div class="col-md-12 list-right" style="margin-top: 15px">
            <div class="row">
                <div class="col-md-12 text-left">
                    <ol itemscope="" itemtype="http://schema.org/BreadcrumbList" class="breadcrumb _3WIL_EScB1tm02Oqj0vbu8">
                    <?php foreach($breadcrumbs as $index => $breadcrumb){ ?>
                        <?php if(++$index != count($breadcrumbs)){  ?>
                            <li class="breadcrumb-item" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem">
                                <a itemprop="item" href="<?php echo $breadcrumb['href']; ?>">
                                    <span itemprop="name"><?php echo $breadcrumb['text']; ?> / </span>
                                    <meta itemprop="position" content="<?php echo ++ $index; ?>">
                                </a>
                            </li>
                        <?php } else {  ?>
                            <li class="breadcrumb-item Z9Bevb8OoGSgkMEl67zPu" itemprop="itemListElement" itemscope="" itemtype="http://schema.org/ListItem">
                                <b itemprop="item">
                                    <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
                                    <meta itemprop="position" content="<?php echo ++ $index; ?>">
                                </b>
                            </li>
                        <?php } ?>
                    <?php } ?>
                    </ol>
                    <a class="view-map" href="/tim-kiem-theo-ban-do" >
                        <span></span>
                        Xem bằng bản đồ
                    </a>
                </div>
            </div>

			<div class="row" id="container-result">
				<div class="col-md-8 list-result">
                    <h1 itemprop="name" class="tex-left" style="font-size:20px; "><b>Tìm kiếm phòng trọ tốt nhất Hồ Chí Minh, Quận Bình thạnh</b></h1>
                    <div class="row grid" id="featured">
                        <div class="top-title">
                            <h3 style="margin-bottom: 0">Phòng trọ tốt nhất khu vực này</h3>
                        </div>
                        <div class="owl-carousel">
                            <?php foreach($featured as $item) { ?>
                            <div class=" i-column" itemscope="" itemtype="http://schema.org/Product">
                                <?php
							$slugName = urlencode(str_replace(' ','-',trim($item["slug_name"])));
							$slugDistrict = urlencode(str_replace(' ','-',trim($item["slug_district_name"])));
							$slugCity = urlencode(str_replace(' ','-',trim($item["slug_city_name"])));
						?>
                                <a href="<?php echo '/phong-tro-'.$slugDistrict.'/'.$slugCity.'/'.$slugName.'-code-'.$item["_id"];?>" class="inner-item">
                                <button class="context-menu-button icon">test</button>
                                <ul class="dropdown" style="display: none;">
                                    <li class="item">Lưu xem sau</li>
                                    <li class="item">Chia sẽ</li>
                                </ul>
                                <div class="img">
                                    <?php  $img = json_decode($item["images"],true); ?>
                                    <img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" class="img-responsive">
                                    <div class="i price"><b><?php echo $item['price']/1000000;?></b> Triệu / tháng</div>
                                    <div class="i area"><b><?php echo $item['price']/1000000;?></b> m2</div>
                                </div>
                                <div class="read">
                                    <div class="name cut-text"><?php echo $item['name'];?></div>
                                    <div class="address cut-text"><?php echo $item['address'];?></div>
                                </div>
                                </a>
                            </div>
                            <?php }?>
                        </div>
                    </div>
                    <div class="row">
                        <div class="sort-search" style="padding:10px; border:1px solid #eee; margin-bottom: 15px">
                            <b>Sắp xếp: </b> <span><b>Giá</b> từ thấp đến cao</span> <span><b>Diện tích từ lớn đến nhỏ</b> từ thấp đến cao</span>
                        </div>
                    </div>
                    <?php if(!empty($rooms)) { ?>
					<?php foreach($rooms as $item) { ?>
					<div class="row" i-column" itemscope="" itemtype="http://schema.org/Product">
						<?php
							$slugName = urlencode(str_replace(' ','-',trim($item["slug_name"])));
							$slugDistrict = urlencode(str_replace(' ','-',trim($item["slug_district_name"])));
							$slugCity = urlencode(str_replace(' ','-',trim($item["slug_city_name"])));
						?>
						<a itemprop="url" href="<?php echo '/phong-tro-'.$slugDistrict.'/'.$slugCity.'/'.$slugName.'-code-'.$item["_id"];?>" class="inner-item">
							<div class="dropdown">
                                <button class="context-menu-button icon" data-toggle="dropdown" id="dropdownMenu<?php echo $item['_id']; ?>" aria-haspopup="true" aria-expanded="true">test</button>
                                <ul style="right: 0; left: auto" class="dropdown-menu" aria-labelledby="dropdownMenu<?php echo $item['_id']; ?>" style="display: none;">
                                    <li class="item"><span href="javascript:;"> Lưu xem sau</span></li>
                                    <li class="item"><span href="javascript:;">Chia sẽ</span></li>
                                </ul>
                            </div>
							<div class="col-md-3 list-img">
								<?php  $img = json_decode($item["images"],true); ?>
								<img itemprop="image"  alt="PHÒNG TRỌ CHO NAM ĐẦY ĐỦ TIỆN NGHI 1T3NGƯỜI QUẬN 4" src="http://www.justitiarul.ro/wp-content/themes/ar2-d57c18d/images/empty_thumbnail.gif" onerror="this.src='http://www.justitiarul.ro/wp-content/themes/ar2-d57c18d/images/empty_thumbnail.gif" data-src="<?php echo $img[0]['link'];?>" class="lazy img-responsive" >
							</div> 
							<div class="col-md-9 list-info pull-right">
                                <h3 itemprop="name" class="title"><b><?php echo $item['name'];?><?php echo $item['name'];?></b></h3>
								<div class="f-i">
									<div class="i d">
										Ngày đăng: <span><?php echo  date('d/m/Y',trim($item['date_crate']));?></span>
									</div>
                                    <?php if(isset($point)) { ?>
                                        <div class="i d">
                                                Cách khoản: <span style="background-color: #1f6aae;color: #fff;padding: 2px 4px;border-radius: 2px;"><?php echo ($item['calculated']>1000 ? round($item['calculated']/1000,1).' km': round($item['calculated'],0).' m') ?> </span>
                                        </div>
                                        <div class="i d">
                                            <span class="direction-point" data-lat="<?php echo $item['location']['coordinates'][1] ?>" data-lgn="<?php echo $item['location']['coordinates'][0] ?>" style="background-color: #00ba51;color: #fff;padding: 2px 4px;border-radius: 2px;">chỉ đường</span>
                                        </div>
                                    <?php } ?>
								</div>
								<div class="adress"  itemprop="address" itemscope="" itemtype="http://schema.org/PostalAddress"><?php echo $item['address'];?></div>
								<div class="mf" itemprop="offers" itemscope="" itemtype="http://schema.org/Offer">
									<div class="i price" itemprop="price" content="<?php echo $item['price']/1000000;?>">
											<i class="fa fa-shopping-cart hidden" aria-hidden="true"></i><b><?php echo $item['price']/1000000;?></b> Triệu/tháng
									</div>
									<div class="i are">
										<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
										<b><?php echo $item['acreage'];?></b> m2
									</div>
									<div class="i are"> | </div>
									<div class="i are">
                                        Tiền nước:
										<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
										<b><?php echo $item['price_water'];?></b>  khối / người
									</div>
									<div class="i are">
                                        Tiền điện:
										<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
										<b><?php echo $item['price_electricity'];?></b> kw
									</div>
								</div>
								
								<button class="btn call-button"><i class="fa fa-phone" aria-hidden="true"></i></button>
							</div>
							<div class="clearfix"></div>
						</a>
					</div>
                    <?php } ?>
					<?php }else{ ?>
                        <div class="text-center"><h3>Rất tiếc ! Chúng tôi đã không tìm thấy phòng trọ nào</h3></div>
					<?php } ?>
                    <div class="row ">
                        <div class="col-md-12 seo_description">
                            <div>
                                <h3 class="title">Mô tả HCM</h3>
                                <p class="text" style="color:#999;">Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit...</p>
                            </div>
                        </div>
                    </div>
				</div>
				<div class="col-md-4 near" id="col-r">
                    <?php if(!empty($specials)) { ?>
                        <div>
                            <h3>Mọi người cũng tìm kiếm khu vực này</h3>
                        </div>
                        <div class="tag">
                                <?php foreach($specials as $special) { ?>
                                    <a href="/tim-kiem/phong-tro-gan-slug-slug/<?php echo $special['location']['coordinates'][1] ?>,<?php echo $special['location']['coordinates'][0] ?>" class="arena"><?php echo $special['name'] ?></a>
                                <?php } ?>
                        </div>
                        <div class="clearfix" style="margin-bottom: 15px;"></div>
                    <?php } ?>
					<div class="tag-place">
						<h3>Tìm trọ trong khu vực: <?php echo $city['name'] ?></h3>
                        <div class="row">
                            <?php if(!empty($district_in_city)){ ?>
                                <ul style="list-style-type: none">
                                    <?php foreach($district_in_city as $item){ ?>
                                        <li class="col-md-6"><a href="/tim-kiem/<?php echo $city['slug_city'] ?>/<?php echo $item['slug_district'] ?>" class="county"><?php echo $item['name'] ?></a></li>
                                    <?php } ?>
                                </ul>
                            <?php } ?>
                        </div>
					</div>
					<div class="ad-r">
						<img style="margin: 10px 0px" src="https://www.mainguyen.vn/img/2017/09/news/l/11231104_1563154727040692_4481018767909529242_o2373.jpg" class="img-responsive">
					</div>
				</div>
			</div>
	</div>
</div>
<div id="modal-phone" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div id="show-phone" class="text-center">
                            <h1 style="margin-bottom: 10px; color: #000"><b>0897 567 070</b></h1>
                            <p style="margin: 0;">Hãy gọi vào giờ làm việc 24/7</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="modal-direction" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#00ba51;">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="color: #fff; " id="gridSystemModalLabel">
                    <div id="floating-panel">
                        <select id="mode" style="font-size: 13px; background-color: #00a247; border:0px; padding: 5px; border-radius: 3px; color:#fff;">
                            <option value="TRANSIT">Xe buýt</option>
                            <option value="DRIVING">Xe hơi</option>
                            <option value="BICYCLING">Xe đạp</option>
                            <option value="WALKING">Đi bộ</option>
                        </select>
                    </div>
                </h4>
            </div>
            <div class="modal-body" style="padding: 0px;">
                <div class="row">
                    <div class="col-md-8" style="padding-right: 0px;">
                        <div id="map-direction" style="width:100%; height: 500px;"></div>
                    </div>
                    <div class="col-md-4">
                        <div id="route-dicrection" style="height: 500px; overflow-y:scroll; padding-right: 15px;">
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
<?php if($type_page=="search-special") {  ?>
<script type="text/javascript">
    var from = <?php echo json_encode($point); ?>;
    function initMap(position) {
        var directionsDisplay = new google.maps.DirectionsRenderer;
        var directionsService = new google.maps.DirectionsService;
        var map = new google.maps.Map(document.getElementById('map-direction'), {
            zoom: 13,
            center: { lat: 10.8522445, lng: 106.7585893 },
            zoom: 14,
            scaleControl: false,
            fullscreenControl: false,
            mapTypeControl: false,
            streetViewControl: false,
            overviewMapControl: true,
            scrollwheel: true,
            disableDoubleClickZoom: true
        });
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('route-dicrection'));

        document.getElementById('mode').addEventListener('change', function() {
            calculateAndDisplayRoute(directionsService, directionsDisplay,position);
        });
        calculateAndDisplayRoute(directionsService, directionsDisplay,position);
    }

    function calculateAndDisplayRoute(directionsService, directionsDisplay,position) {
        var selectedMode = document.getElementById('mode').value;
        directionsService.route({
            origin:   {lat:  from.lat, lng: from.lgn},
            destination:  {lat: position[0], lng: position[1]},
            travelMode: google.maps.TravelMode[selectedMode]
        }, function(response, status) {
            if (status === 'OK') {
                directionsDisplay.setDirections(response);
            } else {
                window.alert('Đã có lỗi sảy ra ' + status);
            }
        });
    }
    $(".direction-point").click(function (event) {
        event.preventDefault()
        var sefl = $(this);
        $('#modal-direction').modal('show');
        $('#modal-direction').on('shown.bs.modal', function () {
            $("#route-dicrection").html("");
            initMap([sefl.data('lat'),sefl.data('lgn')]);
        });
    });
</script>
<?php } ?>
<script src="/public/assets/js/jquery/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
	    $('.call-button').click(function (event) {
            event.preventDefault();
            $("#modal-phone").modal('show');
        });
	    $('.context-menu-button').click(function (event) {
            event.preventDefault();
        });
		$('.owl-carousel').owlCarousel({
		    stagePadding: 50,
		    loop:true,
		    margin:10,
		    nav:true,
            navText:['<i class="fa fa-arrow-left"></i>','<i class="fa fa-arrow-right"></i>'],
		    responsive:{
		        0:{
		            items:1
		        },
		        600:{
		            items:2
		        },
		        1000:{
		            items:3
		        }
		    }
		})
	});
</script>
</div>
<?php echo $footer; ?>

