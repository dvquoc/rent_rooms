<?php echo $header ?>
<div class="container">
	<div class="row top-detail" style="margin-top: 70px">
		<div class="col-md-4">
			<p class="text-title">Giá thuê phòng/Diện tích</p>
			<p class="text-info"><?php echo $detail['price']/1000?> Triệu/tháng - <?php echo detail['acreage']?> m2<p>
		</div>
		<div class="col-md-4">
			<p class="text-info"><?php echo $detail['name']?></p>
			<p class="text-info"><?php echo $detail['address']?></p>
		</div>
		<div class="col-md-4"></div>
	</div>
	<div class="row body-detail">
		<div class="col-md-8 img-rooms">
			<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" class="img-responsive">
		</div>
		<div class="col-md-4 info-room">
			<p class="text-title">Thông tin phong trọ</p>
			<div class="row">
				<div class="col-md-3 avata">
					<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" class="img-responsive">
				</div>
				<div class="col-md-9 info-master">
					<span class="name-master">Tên chủ phòng</span><br>
					<span class="phone-master">SDT</span>
				</div>
			</div>
			<p class="description-master">
				Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with
			</p>
			<i class="fa fa-map-marker" style="margin-right: 5px; font-size: 20px;"></i><span class="info-time">Giờ giấc <?php echo $detail['close_door']?></span>
			<div class="clearfix"></div>
			<button class="btn share">Chia sẻ</button>
			<div class="clearfix"></div>
			<button class="btn call">liên hệ</button>			
		</div>
	</div>
	<div class="row " style="margin-top: 30px">
		<div class="col-md-8 room-detail">
			<h1>Chi tiết phòng trộ</h1>
			<p class="text-title">Nội quy phòng trọ</p>
			<div class="regulation_room">
				<p><?php echo $detail['regulation_room']?></p>
			</div>
			<p class="text-title">Điểm nổi bật</p>
			<div class="highlight">
				<p><?php echo $detail['highlight']?></p>
			</div>
			<div class="row room-relative">
				<?php foreach($rooms as $item) { ?>
				<div class="col-md-3 list-img">
					<?php  $img = json_decode($item["images"],true); ?>
					<img onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'" src="<?php echo $img[0]['link'];?>" class="img-responsive" >
				</div> 
				<div class="col-md-9 list-info pull-right">
					<div class="title"><b><?php echo $item['name'];?></b></div>
					<div class="f-i">
						<div class="i d">
							Ngày đăng: <span><?php echo  date('d/m/Y',trim($item['date_crate']));?></span>
						</div>
						<div class="i d">
								Cách khoản: <span>5 Km</span>
						</div>
					</div>
					<div class="adress" ><?php echo $item['address'];?></div>
					<div class="mf">
						<div class="i price" >
								<i class="fa fa-shopping-cart hidden" aria-hidden="true"></i><b><?php echo $item['price']/1000000;?></b> Triệu/tháng
						</div>
						<div class="i are">
							<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
							<b><?php echo $item['acreage'];?></b> m2
						</div>
						<div class="i are"> - </div>
						<div class="i are">
							<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
							<b><?php echo $item['acreage'];?></b> / Khối
						</div>
						<div class="i are">
							<i class="fa fa-area-chart hidden" aria-hidden="true">	</i>
							<b><?php echo $item['acreage'];?></b> / Kg
						</div>
					</div>
					
					<button class="btn call-button"><i class="fa fa-phone" aria-hidden="true"></i> gọi điện</button>
				</div>
			<div class="clearfix"></div>

			<?php }?>
		</div>
		</div>
		<div class="col-md-4">
			<img src="https://www.mainguyen.vn/img/2017/09/news/l/11231104_1563154727040692_4481018767909529242_o2373.jpg" class="img-responsive">
		</div>
		
	</div>
	
</div>