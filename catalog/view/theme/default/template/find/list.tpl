<?php echo $header ?>
<script src="/public/assets/plugins/slide_reveal/slidereveal.js" type="text/javascript"></script>
<div class="container">
  	<div class="row" style="margin-top: 70px">
		<div class="col-md-2 list_left">
			<div style="height:100%">
				<div class="list_like">
					<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" width="165px" height="120px">
					<p>Nhấn vào nút yêu thích để làm gì đó</p>
				</div>
				<div class="info">
					<button class="col_left_button btn btn-primary">Đăng ký phòng trọ</button>
					<button class="col_left_button btn btn-primary">Góp ý thắc mắc</button>
					<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" width="165px" height="120px">
					<button class="col_left_button btn btn-primary">Thông tin thêm</button>
				</div>
				<div class="footer">
					<p>Nhanh nhất - tiết kiệm nhất - cẩn thận nhất</p>
				</div>
			</div>
		</div>
		<div class="col-md-10 list-right" >
			<div class="row ">
				<div class="col-md-12 seo_description">
					<div>
						<h2 class="title">Mô tả HCM</h2>
						<p class="text">mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tả mô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tả</p>
					</div>
					<div>
						<button class="btn">Xem bằng bản đồ</button>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 top-title" style="margin-top: 20px">
					<h2>Top nhà trọ HCM</h2>
				</div>
			</div>
			<div class="row">	
			<?php foreach($featured as $item) { ?>
				<div class="col-md-3 top-slide">
					<div>
						<?php  $img = json_decode($item["images"],true); ?>
						<img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" class="img-responsive">
					</div>
					<div class="clearfix"></div>
					<div>
						<p class="price">$<?php echo $item['price'];?></p>
						<p class="p-lectriccity"><?php echo $item['price_electricity'];?></p>
						<p class="name"><?php echo $item['name'];?></p>
						<p class="address"><?php echo $item['address'];?></p>
					</div>
				</div>
				<?php }?>
			</div>
			<div class="row">
				<div class="col-md-8">

					<?php foreach($rooms as $item) { ?>
					<div class="row">
						<div class="col-md-3 list-img">
							<?php  $img = json_decode($item["images"],true); ?>
							<img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" width="150px" height="120px" >
						</div> 
						<div class="col-md-9 list-info">
							<div class="title"><b><?php echo $item['name'];?></b></div>

							<div class="row item-address-date">
								<div class="col-md-9 adress" >	<?php echo $item['address'];?>
								</div>
								<div class="col-md-3 date" >
									<?php 
									$string = str_replace(' ', '', $item['date_crate']);
									echo  date('d-m-Y',$string);
									?>
								</div>
							</div>
							
							<div class="row item-price" >
								<div class="col-md-8 price" >
									<i class="fa fa-shopping-cart" aria-hidden="true"></i><?php echo $item['price'];?> Triệu/tháng
								</div>
								<div class="col-md-4 item-button">
									<button class="btn"><i class="fa fa-phone" aria-hidden="true"></i> Liên hệ</button>
								</div>
							</div>
							
							<div class="row item-area">
								<div class="col-md-8 are"> <i class="fa fa-area-chart" aria-hidden="true">	</i><?php echo $item['price_electricity'];?> Mét vuông
								</div>
								<div class="col-md-4 item-button">
									<button class="btn"><i class="fa fa-heart" aria-hidden="true"></i> Yêu thích</button>
								</div>
							</div>
						</div>
					</div>
					<div class="clearfix"></div>
					<?php } ?>
				</div>
				<div class="col-md-4 near">
					<div>
						<p>Khu vực lân cận</p>
					</div>
					<div class="tag">
						<a href="" class="arena">Khu công nghiệp tân bình</a>
						<a href="" class="arena">Công viên đầm sen</a>
						<a href="" class="arena">Chợ bến thành</a>
						<a href="" class="arena">akhama bulabu</a>
					</div>
					<div class="clearfix"></div>
					<div>
						<p>Khu vực khac: Hồ Chí Minh</p>
					</div>
					<div class="tag">
						<ul>
							<li><a href="" class="county">Quân 1</a></li>
							<li><a href="" class="county">Quân 2</a></li>
							<li><a href="" class="county">Quân 3</a></li>
							<li><a href="" class="county">Quân 4</a></li>
							<li><a href="" class="county">Quân 5</a></li>
							<li><a href="" class="county">Quân 6</a></li>

						</ul>
					</div>
				</div>
			</div>
	</div>
</div>

