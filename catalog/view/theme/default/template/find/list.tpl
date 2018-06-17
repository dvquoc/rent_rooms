<?php echo $header ?>
<link href="/public/assets/css/layout.css" rel="stylesheet" media="screen"/>
<link href="/public/assets/css/list-page.css" rel="stylesheet" media="screen"/>
<link href="/public/assets/css/boostrap-custom.css" rel="stylesheet" media="screen"/>
<link href="/public/assets/css/load-font.css" rel="stylesheet" type="text/css">
<link href="/public/assets/css/stylesheet.css" rel="stylesheet">
<script src="/public/assets/plugins/slide_reveal/slidereveal.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<div style="clear:both"></div>
<div class="container">
  	<div class="row">
		<div class="col-md-2">dsa</div>
		<div class="col-md-10">
			<div class="row">
				<div class="col-md-12">
					<div>
						<h5>Mô tả HCM</h5>
						<p>mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tả mô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tảmô tả mô tả</p>
					</div>
				</div>
				
				<?php foreach($rooms as $item) { ?>
					<div class="col-md-3">
						<div>
							<?php  $img = json_decode($item["images"],true); ?>
							<img src="<?php echo $img[0]['link'];?>" width="230px" height="120px">
						</div>
						<div class="clearfix"></div>
						<div>
							<table>
								<tr>
									<td>$<?php echo $item['price'];?></td>
								</tr>
								<tr>
									<td><?php echo $item['price_electricity'];?></td>
								</tr>
								<tr>
									<td><?php echo $item['name'];?></td>
								</tr>
								<tr>
									<td><?php echo $item['address'];?></td>
								</tr>
							</table>
						</div>
					</div>
					<?php }?>
			</div>
			<div class="row">
				<div class="col-md-9">
					<?php foreach($rooms as $item) { ?>
					<div class="col-md-3" style="margin-bottom: 20px">
						<?php  $img = json_decode($item["images"],true); ?>
						<img src="<?php echo $img[0]['link'];?>" width="150px" height="120px" >
					</div> 
					<div class="col-md-9">
						<div><?php echo $item['name'];?></div>
						<div class="clearfix"></div>

						<div class="col-md-9" style="padding-left: 0"><?php echo $item['address'];?></div>
						<div class="col-md-3" style="padding-left: 0"><?php echo $item['date_crate'];?></div>
						<div class="clearfix"></div>

						<div class="col-md-1" style="padding-left: 0"><i class="fa fa-shopping-cart" aria-hidden="true"></i></div>
						<div class="col-md-4" style="padding-left: 0"><?php echo $item['price'];?> Triệu/tháng</div>
						<div class="col-md-4 col-btn"><button class="btnn"><i class="fa fa-phone" aria-hidden="true"></i> Liên hệ</button></div>
						<div class="clearfix"></div>

						<div class="col-md-1" style="padding-left: 0"><i class="fa fa-area-chart" aria-hidden="true"></i></div>
						<div class="col-md-4" style="padding-left: 0"><?php echo $item['price_electricity'];?> Mét vuông</div>
						<div class="col-md-4 col-btn"><button class="btnn"><i class="fa fa-heart" aria-hidden="true"></i> Yêu thích</button></div>
						<div class="clearfix"></div>

					</div>
					<div class="clearfix"></div>
					<?php } ?>
				</div>
				<div class="col-md-3">
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

