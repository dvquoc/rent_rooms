<?php echo $header ?>
<div class="container">
<div class="top-detail">
	<div class="body-detail">
			<div class="row">
				<div class="col-md-8 img-rooms" style="padding:15px; padding-top: 10px; padding-right: 0px; position: relative; height: 430px; overflow: hidden">
					<ul style="position: absolute; left: -55px; top: 85px; transform: rotate(-90deg); list-style-type: none;">
						<li class="pull-left" style="background-color:#fff; border-radius: 3px; line-height: 16px; padding: 10px;font-size: 13px;">Hình ảnh</li>
						<li class="pull-left" style="margin-left: 3px; line-height: 16px; border-radius: 3px; background-color:#fff; padding: 10px;font-size: 13px;">Xem map</li>
					</ul>
					<img src="<?php echo $detail['images'][0]['link']; ?>" class="img-responsive">
				</div>
				<div class="col-md-4 info-room">
                    <div class="inner" style="font-size: 12px; background-color: #fff; padding:15px; border: 1px solid #eaeaea; margin-top: 10px; height: 420px;box-shadow: 0px 0px 4px -3px #000;">
                        <div class="row">
                            <div class="col-md-2 avata">
                                <img src="https://static.trulia-cdn.com/userimg/user_m_00_m.gif" width="40px">
                            </div>
                            <div class="col-md-10 info-master">
                                <b class="name-master">Người quản lý</b><br>
                                <b style="font-size: 18px" class="phone-master">0894 232 232</b>
                            </div>
                        </div>
                        <div class="des">
                            <p style="font-size: 13px; ll">Các phòng trọ được chúng tôi kiểm duyệt, Nếu có thông tin gì sai hãy vui lòng báo cáo lỗi. Để giúp cải thiện dịch vụ tốt nhất.</p>
                        </div>
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

                        <div style="color:#00ba51; font-size: 16px; margin-bottom: 5px; margin-top: 10px; line-height: 32px;">
                            <i class="fa fa-check" style="margin-right: 10px; font-size: 20px; border-radius: 100%; border:1px solid #00ba51; padding: 5px;"></i>
                            <span class="info-time">Quản lý giờ giấc:  <?php echo $detail['close_door']?></span>
                        </div>

                        <button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-bookmark"></i> Lưu xem sau</button>
                        <button class="btn btn-block-inline" style="margin-bottom: 10px; font-size: 15px"><i class="fa fa-phone"></i> Liên hệ chủ nhà</button>
                    </div>
				</div>
			</div>
	</div>
</div>
<div class="header" style="margin:10px 0; background-color:#f3f3f3; position: sticky; top: 55.8px; color: #545454; font-size: 15px; padding: 10px 0 10px 0px; z-index: 10">
    <div class="container">
        <div class="row">
            <div class="col-md-5">
                <h1 style="margin-bottom: 0; font-size: 22px;" class="text-info"><?php echo $detail['name']?></h1>
                <div style="color: #333; font-size: 13px" class="text-address"><?php echo $detail['address']?></div>
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
                <div class="room-relative">
                    <h3>Các phòng trọ phù hợp</h1>
                    <div style="margin-left: 15px">
                        <?php foreach($rooms as $item) { ?>
                        <div class="row">
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
                            </a>
                        </div>
                        <?php } ?>
                    </div>
                </div>
			</div>
			<div class="col-md-4">
				<img src="https://www.mainguyen.vn/img/2017/09/news/l/11231104_1563154727040692_4481018767909529242_o2373.jpg" class="img-responsive">
			</div>
			
		</div>
</div>