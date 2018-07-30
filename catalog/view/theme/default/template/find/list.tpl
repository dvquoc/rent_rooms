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
                    <h1 itemprop="name" class="text-center" style="font-size:20px; ">Tìm kiếm phòng trọ tốt nhất Hồ Chí Minh, Quận Bình thạnh</h1>
                    <a style="float: right; margin-top:-90px;" href="/tim-kiem-theo-ban-do" >
                        <span style="width: 10px; height: 10px; border-radius: 10px; display: inline-block; background-color:#ffffff; margin-right: 10px; -webkit-animation: pulse-shadow--collection 2s infinite;  animation: pulse-shadow--collection 2s infinite;"></span>
                        Xem bằng bản đồ
                    </a>
                </div>
            </div>
			<div class="row grid" id="featured">
			<div class="col-md-12 top-title">
					<h3 style="margin-bottom: 0">Top nhà trọ HCM</h3>
			</div>
			  <div class="owl-carousel col-md-12">
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
								<div class="i price"><b><?php echo $item['price']/1000000;?></b> Triệu/tháng</div>
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
			<div class="row" id="container-result">
				<div class="col-md-8 list-result">
                    <div class="row">
                        <div class="sort-search" style="padding:10px; border:1px solid #eee; margin-bottom: 15px">
                            <b>Sắp xếp: </b> <span><b>Giá</b> từ thấp đến cao</span> <span><b>Diện tích từ lớn đến nhỏ</b> từ thấp đến cao</span>
                        </div>
                    </div>
					<?php foreach($rooms as $item) { ?>
					<div class="row" i-column" itemscope="" itemtype="http://schema.org/Product">
						<?php
							$slugName = urlencode(str_replace(' ','-',trim($item["slug_name"])));
							$slugDistrict = urlencode(str_replace(' ','-',trim($item["slug_district_name"])));
							$slugCity = urlencode(str_replace(' ','-',trim($item["slug_city_name"])));
						?>
						<a itemprop="url" href="<?php echo '/phong-tro-'.$slugDistrict.'/'.$slugCity.'/'.$slugName.'-code-'.$item["_id"];?>" class="inner-item">
							<button class="context-menu-button icon">test</button>
							<ul class="dropdown" style="display: none;">
								<li class="item">Lưu xem sau</li>
								<li class="item">Chia sẽ</li>
							</ul>
							<div class="col-md-3 list-img">
								<?php  $img = json_decode($item["images"],true); ?>
								<img itemprop="image" alt="PHÒNG TRỌ CHO NAM ĐẦY ĐỦ TIỆN NGHI 1T3NGƯỜI QUẬN 4" onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" class="img-responsive" >
							</div> 
							<div class="col-md-9 list-info pull-right">
								<h3 itemprop="name" class="title"><?php echo $item['name'];?> <?php echo $item['name'];?></h3>
								<div class="f-i">
									<div class="i d">
										Ngày đăng: <span><?php echo  date('d/m/Y',trim($item['date_crate']));?></span>
									</div>
                                    <?php if(isset($point)) { ?>
                                        <div class="i d">
                                                Cách khoản: <span><?php echo ($item['calculated']>1000 ? round($item['calculated']/1000,1).'Km': round($item['calculated'],0).'m') ?> </span>
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
									<div class="i are"> - </div>
									<div class="i are">
                                        Tiền nước:
										<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
										<b><?php echo $item['acreage'];?></b>  Khối / Người
									</div>
									<div class="i are">
                                        Tiền điện:
										<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
										<b><?php echo $item['acreage'];?></b>  kW
									</div>
								</div>
								
								<button class="btn call-button"><i class="fa fa-phone" aria-hidden="true"></i></button>
							</div>
							<div class="clearfix"></div>
						</a>
					</div>
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
					<div>
						<h3>Mọi người cũng tìm kiếm khu vực này</h3>
					</div>
					<div class="tag">
						<a href="" class="arena">Khu công Công nghệ cao</a>
						<a href="" class="arena">Sư phạm kỹ thuật</a>
						<a href="" class="arena">Coopmart Quận 9</a>
						<a href="" class="arena">Cao đẳng Công nghệ thủ đức</a>
						<a href="" class="arena">Suối tiên</a>
						<a href="" class="arena">Đường Lê Văn Việt</a>
						<a href="" class="arena">Nhà văn hóa thanh niên Thử Đức</a>
                        <a href="" class="arena">Coopmart Quận 9</a>
                        <a href="" class="arena">Cao đẳng Công nghệ thủ đức</a>
                        <a href="" class="arena">Suối tiên</a>
                        <a href="" class="arena">Đường Lê Văn Việt</a>
					</div>
					<div class="clearfix"></div>
					
					<div class="tag-place" style="margin-top: 15px;">
						<h3>Khu vực khac: Hồ Chí Minh</h3>
                        <div class="row">
                            <ul class="col-md-6" style="list-style-type: none">
                                <li><a href="" class="county">Quân 1</a></li>
                                <li><a href="" class="county">Quân 2</a></li>
                                <li><a href="" class="county">Quân 3</a></li>
                                <li><a href="" class="county">Quân 4</a></li>
                                <li><a href="" class="county">Quân 5</a></li>
                                <li><a href="" class="county">Quân 6</a></li>
                            </ul>
                            <ul class="col-md-6" style="list-style-type: none">
                                <li><a href="" class="county">Quân Thử Đức</a></li>
                                <li><a href="" class="county">Quân Gò Vấp</a></li>
                                <li><a href="" class="county">Quân Tân Bình</a></li>
                                <li><a href="" class="county">Quân Tân Phú</a></li>
                                <li><a href="" class="county">Huyện Hốc Môn</a></li>
                                <li><a href="" class="county">Quân Tân phú</a></li>
                            </ul>
                        </div>
					</div>
					<div class="ad-r">
						<img style="margin: 10px 0px" src="https://www.mainguyen.vn/img/2017/09/news/l/11231104_1563154727040692_4481018767909529242_o2373.jpg" class="img-responsive">
					</div>
				</div>
			</div>
	</div>
</div>
<script src="/public/assets/js/jquery/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
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
		            items:5
		        }
		    }
		})
	});
</script>
</div>
<?php echo $footer; ?>

