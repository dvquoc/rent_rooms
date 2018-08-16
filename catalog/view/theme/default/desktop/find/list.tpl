<?php echo $header; ?>
<link href="/public/assets/css/list-page.css" rel="stylesheet" media="screen"/>
<div id="content-page" class="container page-layout-box">
  	<div class="row">
		<div class="col-md-12 list-right">
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
                    <a class="view-map" href="/map-tim-kiem<?php echo $url; ?>" >
                        <span></span>
                        Xem bằng bản đồ
                    </a>
                </div>
            </div>
            <div class="top-page-search row">
                <div class="col-md-12 text-center">
                    <img src="https://file4.batdongsan.com.vn/2018/04/07/RUFz0fap/20180407105303-7dfc.jpg">
                </div>
            </div>
			<div class="row" id="container-result">
				<div class="col-md-8 list-result">
                    <h1 itemprop="name" class="tex-left" style="font-size:20px; "><b>Tìm kiếm phòng trọ tốt nhất <?php echo $info_seo['name']; ?></b></h1>
                    <div class="row grid" id="featured">
                        <div class="top-title">
                            <h3 style="margin-bottom: 0">Phòng trọ tốt nhất khu vực này</h3>
                        </div>
                        <div class="owl-carousel">
                            <?php foreach($featured as $key=>$item) { ?>
                            <div class=" i-column" itemscope="" itemtype="http://schema.org/Product">
                                <?php
							$slugName = urlencode(str_replace(' ','-',trim($item["slug"])));
							$slugDistrict = urlencode(str_replace(' ','-',trim($item["slug_district"])));
							$slugCity = urlencode(str_replace(' ','-',trim($item["slug_city"])));
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
                        <div class="sort-search" style="background-color:#eee; border-radius: 1px; padding:7px; border:1px solid #dadada; margin-bottom: 15px">
                            <div class="row">
                                <div class="col-md-4"><b style="font-size: 14px; line-height: 28px;">kết quả tìm kiếm</b></div>
                                <div class="col-md-8 text-right">
                                    <b><i class="fa fa-sort"></i> Sắp xếp: </b>
                                    <select name="sort-price" class="item-sort">
                                        <option>Giá từ thấp tới cao</option>
                                    </select>
                                    <select name="sort-area" class="item-sort">
                                        <option>Diện tích từ thấp tới cao</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <?php echo $list_content ?>
                    <?php if(!empty($info_seo['meta_description'])) { ?>
                        <div class="row ">
                            <div class="seo_description">
                                <div>
                                    <h3 class="title">Mô tả HCM</h3>
                                    <p class="text" style="color:#999;">
                                        <?php  echo $info_seo['meta_description']; ?>
                                    </p>
                                </div>
                            </div>
                        </div>
                    <?php  } ?>
				</div>
				<div class="col-md-4 near" id="col-r">
                    <?php if(!empty($specials)) { ?>
                        <div>
                            <h3>Mọi người cũng tìm kiếm khu vực này</h3>
                        </div>
                        <div class="tag">
                                <?php foreach($specials as $special) { ?>
                                    <a href="/tim-kiem/phong-tro-gan-<?php echo $special['slug']; ?>/<?php echo $special['location']['coordinates'][1] ?>,<?php echo $special['location']['coordinates'][0] ?>" class="arena"><?php echo $special['name'] ?></a>
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
                        <img style="margin-top: 10px;" src="https://static.vecteezy.com/system/resources/previews/000/179/049/non_2x/half-price-sale-banner-poster-or-flyer-template-design-vector.jpg" class="img-responsive">
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
		            items:3
		        }
		    }
		})
	});
</script>
</div>
<?php echo $footer; ?>

