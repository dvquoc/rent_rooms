<?php echo $header ?>
<div class="top-detail">
	<div class="body-detail" style="background-color: #eee; ">
		<div class="container">
			<div class="row">
				<div class="col-md-8 img-rooms" style="padding:15px; position: relative; ">
					<ul style="position: absolute; left: -106px; top: 80px; transform: rotate(-90deg); list-style-type: none;">
						<li class="pull-left" style="background-color:#fff; border-radius: 3px; line-height: 16px; padding: 10px;font-size: 13px;">Hình ảnh</li>
						<li class="pull-left" style="margin-left: 3px; line-height: 16px; border-radius: 3px; background-color:#fff; padding: 10px;font-size: 13px;">Xem map</li>
					</ul>
					<img src="http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg" class="img-responsive">
				</div>
				<div class="col-md-4 info-room" style="background-color: #fff;  border: 1px solid #d8d8d8;border-radius: 3px; margin-top: 15px; height: 455px; box-shadow: 0px 1px 5px -3px #000;">
					<h3 style="margin-top: 20px;" class="text-title">Thông tin phòng trọ</h3>
					<div class="row">
						<div class="col-md-2 avata">
							<img src="https://static.trulia-cdn.com/userimg/user_m_00_m.gif" width="40px">
						</div>
						<div class="col-md-10 info-master">
							<b class="name-master">Người quản lý</b><br>
							<b style="font-size: 18px" class="phone-master">0894 232 232</b>
						</div>
					</div>
					<p class="description-master">
						Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with Font Awesome, the web’s most popular icon set and toolkit. Get vector icons and social logos on your website with
					</p>
					<div style="color:#00ba51; font-size: 18px; margin-bottom: 10px">
						<i class="fa fa-check" style="margin-right: 5px; font-size: 20px;"></i>
						<span class="info-time">Quản lý giờ giấc:  <?php echo $detail['close_door']?></span>
					</div>
					<button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-bookmark"></i> Lưu xem sau</button>
					<button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-phone"></i> Liên hệ chủ nhà</button>
					<a style=""></a>		
				</div>
			</div>
		</div>
		<div class="header" style="background-color: #eeeeee;color: #545454;font-size: 16px;padding: 0px 0 5px 0px;">
			<div class="container">
				<div class="row">
					<div class="col-md-5">
						<h2 style="margin-bottom: 0;" class="text-info"><?php echo $detail['name']?></h2>
						<div style="color: #333; font-size: 13px" class="text-address"><?php echo $detail['address']?></div>
					</div>
					<div class="col-md-2">
						<b class="text-title">Giá thuê phòng</b>
						<div class="text-info"><b><?php echo $detail['price']/1000000?></b> Triệu/tháng </div>
					</div>
					<div class="col-md-2">
						<b class="text-title">Diện tích</b>
						<div class="text-info"><b><?php echo detail['acreage']?></b> m2</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>
<div style="background-color: #fff;">
	<div class="container">
		<div class="row " style="margin-top: 30px">
			<div class="col-md-8 room-detail">
				<h3>Quy định & thông tin khác</h1>
				<p class="text-title">Nội quy phòng trọ</p>
				<div class="regulation_room">
					<p><?php echo $detail['regulation_room']?></p>
				</div>
				<p class="text-title">Điểm nổi bật</p>
				<div class="highlight">
					<p><?php echo $detail['highlight']?></p>
				</div>
				<h3>Các phòng trọ phù hợp</h1>
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
</div>