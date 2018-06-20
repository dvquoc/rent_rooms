<?php echo $header ?>
<script src="/public/assets/plugins/slide_reveal/slidereveal.js" type="text/javascript"></script>
<div class="container">
  	<div class="row" style="margin-top: 70px">
		<div class="col-md-2 list-left">
			<div style="height:100%">
				<div class="list_like">
					<img src="https://propzy.vn/assets/modules/yeu-thich/images/ximg-yeu-thich.png.pagespeed.ic.rpz0I8PqTL.webp" class="img-responsive">
					<p class="text-center">Nhấn vào nút yêu thích để làm gì đó</p>
				</div>
				<div class="info">
					<button class="col_left_button btn btn-primary">Đăng ký phòng trọ</button>
					<button class="col_left_button btn btn-primary">Góp ý thắc mắc</button>

					<img style="margin: 10px 0px" src="https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/ed/31/62/ed3162cd-2471-16a8-2376-4e8ee6835e02/source/512x512bb.jpg" class="img-responsive">
					<button class="col_left_button btn btn-primary">Thông tin thêm</button>
				</div>
				<div class="footer text-center">
					<p>Nhanh nhất - tiết kiệm nhất - cẩn thận nhất</p>
				</div>
			</div>
		</div>
		<div class="col-md-10 list-right" >
			<div class="row ">
				<div class="col-md-12 seo_description">
					<div>
						<h3 class="title">Mô tả HCM</h3>
						<p class="text" style="color:#999;">Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit...</p>
					</div>
					<div class="text-center">
						<button class="btn btn-primary"><i class="fa fa-map-marker" style="margin-right: 5px; font-size: 20px;"></i>Xem bằng bản đồ</button>
					</div>
				</div>
			</div>
			<div class="row grid" id="featured">
			<div class="col-md-12 top-title" style="margin-top: 20px">
					<h3>Top nhà trọ HCM</h3>
			</div>	
			<?php foreach($featured as $item) { ?>
				<div class="col-md-3 i-column">
					<div class="inner-item">
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
					</div>
				</div>
				<?php }?>
			</div>
			<div class="row" id="container-result">
				<div class="col-md-8 list-result">
					<?php foreach($rooms as $item) { ?>
					<div class="row">
						<div class="inner-item">
							<button class="context-menu-button icon">test</button>
							<ul class="dropdown" style="display: none;">
								<li class="item">Lưu xem sau</li>
								<li class="item">Chia sẽ</li>
							</ul>
							<div class="col-md-3 list-img">
								<?php  $img = json_decode($item["images"],true); ?>
								<img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" class="img-responsive" >
							</div> 
							<div class="col-md-9 list-info pull-right">
								<div class="title"><b><?php echo $item['name'];?></b></div>
								<div class="adress" ><?php echo $item['address'];?></div>
								<div class="mf">
									<div class="i price" >
											<i class="fa fa-shopping-cart hidden" aria-hidden="true"></i><b><?php echo $item['price']/1000000;?></b> Triệu/tháng
									</div>
									<div class="i are">
										<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
										<b><?php echo $item['price_electricity'];?></b> m2
									</div>
								</div>
								<div class="f-i">
									<div class="i d">
										Ngày đăng: <span><?php echo  date('d-m-Y',trim($item['date_crate']));?></span>
									</div>
									<div class="i d">
											Cách khoản: <span>5 Km</span>
									</div>
								</div>
								
								<button class="btn btn-primary call-button"><i class="fa fa-phone" aria-hidden="true"></i></button>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<?php } ?>
				</div>
				<div class="col-md-4 near" id="column-right">
					<div>
						<h3>Khu vực lân cận</h3>
					</div>
					<div class="tag">
						<a href="" class="arena">Khu công nghiệp tân bình</a>
						<a href="" class="arena">Công viên đầm sen</a>
						<a href="" class="arena">Chợ bến thành</a>
						<a href="" class="arena">akhama bulabu</a>
					</div>
					<div class="clearfix"></div>
					
					<div class="tag" style="margin-top: 15px;">
						<h3>Khu vực khac: Hồ Chí Minh</h3>
						<ul>
							<li><a href="" class="county">Quân 1</a></li>
							<li><a href="" class="county">Quân 2</a></li>
							<li><a href="" class="county">Quân 3</a></li>
							<li><a href="" class="county">Quân 4</a></li>
							<li><a href="" class="county">Quân 5</a></li>
							<li><a href="" class="county">Quân 6</a></li>

						</ul>
					</div>
					<div class="ad-r">
						<img src="https://www.mainguyen.vn/img/2017/09/news/l/11231104_1563154727040692_4481018767909529242_o2373.jpg" class="img-responsive">
					</div>
				</div>
			</div>
	</div>
</div>

