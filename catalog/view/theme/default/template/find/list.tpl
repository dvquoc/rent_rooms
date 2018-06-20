<?php echo $header ?>
<script src="/public/assets/plugins/slide_reveal/slidereveal.js" type="text/javascript"></script>
<div class="container">
  	<div class="row" style="margin-top: 70px">
		<div class="col-md-2 list_col_left">
			<div style="height:100%">
				<div class="left_col_like">
					<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" width="165px" height="120px">
					<p>Nhấn vào nút yêu thích để làm gì đó</p>
				</div>
				<div class="left_col_info">
					<button class="col_left_button btn btn-primary">Đăng ký phòng trọ</button>
					<button class="col_left_button btn btn-primary">Góp ý thắc mắc</button>
					<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" width="165px" height="120px">
					<button class="col_left_button btn btn-primary">Thông tin thêm</button>
				</div>
				<div class="left_col_footer">
					<p>Nhanh nhất - tiết kiệm nhất - cẩn thận nhất</p>
				</div>
			</div>
		</div>
		<div class="col-md-10">
			<div class="row">
				<div class="col-md-12">
					<div class="page_description">
						<h2>Mô tả HCM</h2>
						<p>mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tả mô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tả</p>
					</div>
					<div style="text-align: center;">
						<button class="btn">Xem bằng bản đồ</button>
					</div>
				</div>
				<div class="col-md-12" style="margin-top: 20px">
					<h2>Top nhà trọ HCM</h2>
				</div>
				<?php foreach($rooms as $key => $item) { ?>
					<div class="col-md-3">
						<div>
							<?php  $img = json_decode($item["images"],true); ?>
							<img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" class="img-responsive">
						</div>
						<div class="clearfix"></div>
						<div>
							<div class="address"><?php echo $item['name'];?></div>
							<div class="address" style="font-size: 13px; color:#999;"><?php echo $item['address'];?></div>
							<div class="address"><?php echo $item['price'];?></div>
							<div class="address"><?php echo $item['price_electricity'];?></div>
						</div>
					</div>
				<?php if($key==3) break;  }?>
			</div>
			<div class="row">
				<div class="col-md-8">
					<?php foreach($rooms as $item) { ?>
					<div class="row">
						<div class="inner-item">
							<button class="context-menu-button icon">test</button>
							<div class="col-md-3" style="padding: 0px;">
								<?php  $img = json_decode($item["images"],true); ?>
								<img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" style="height: 121px; margin: -1px; border-radius: 3px 0px 0px 3px;" class="img-responsive" >
							</div> 
							<div class="col-md-9">
								<div><b><?php echo $item['name'];?></b></div>
								<div class="clearfix"></div>

								<div class="col-md-9" style="padding-left: 0; font-size: 13px; color: #999;"><?php echo $item['address'];?></div>
								<div class="col-md-3" style="padding-left: 0"><?php echo $item['date_crate'];?></div>
								<div class="clearfix"></div>

								<div class="col-md-1" style="padding-left: 0"><i class="fa fa-shopping-cart" aria-hidden="true"></i></div>
								<div class="col-md-4" style="padding-left: 0"><?php echo $item['price'];?> Triệu/tháng</div>
								<div class="col-md-4 col-btn">
									<button class="btn btn-primary"><i class="fa fa-phone" aria-hidden="true"></i> Liên hệ </button></div>
								<div class="clearfix"></div>

								<div class="col-md-1" style="padding-left: 0"><i class="fa fa-area-chart" aria-hidden="true"></i></div>
								<div class="col-md-4" style="padding-left: 0"><?php echo $item['price_electricity'];?> Mét vuông</div>
								<div class="col-md-4 col-btn"><button class="btn btn-primary"><i class="fa fa-heart" aria-hidden="true"></i> Yêu thích</button></div>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
					<?php } ?>
				</div>
				<div class="col-md-4">
					<div>
						<p>Khu vực lân cận</p>
					</div>
					<div class="link-tag">
						<a href="" class="tag-list-btn tag-list-white tag-list-border">Khu công nghiệp tân bình</a>
						<a href="" class="tag-list-btn tag-list-white tag-list-border">Công viên đầm sen</a>
						<a href="" class="tag-list-btn tag-list-white tag-list-border">Chợ bến thành</a>
						<a href="" class="tag-list-btn tag-list-white tag-list-border">akhama bulabu</a>
					</div>
					<div class="clearfix"></div>
					<div>
						<p>Khu vực khac: Hồ Chí Minh</p>
					</div>
					<div class="link-tag">
						<ul>
							<li><a href="" class="link">Quân 1</a></li>
							<li>				<a href="" class="link">Quân 2</a></li>
							<li><a href="" class="link">Quân 3</a></li>
							<li><a href="" class="link">Quân 4</a></li>
							<li><a href="" class="link">Quân 5</a></li>
							<li><a href="" class="link">Quân 6</a></li>
						</ul>
					</div>
				</div>
			</div>
	</div>
</div>

