<?php echo $header; ?>
<!--declare-->
<div class="container-fluid-full">
     <?php echo $slideshow_home; ?>
</div>
<?php echo $content_top; ?>
<div class="container">
    <div class="row">
        <div class="col-md-6"><?php echo $content_block_one; ?></div>
        <div class="col-md-6"><?php echo $content_block_tow; ?></div>
    </div>
</div>
<div id="supporter" style="background-color: #eee; padding: 30px 0px; margin: 0px auto; padding-bottom: 60px;">
    <div class="inner-content-supporter text-center">
        <div class="supporter">
            <div class="container">
                <div class="header-module">
                    <h3 class="title-module title-fuature text-center"><span>Hỗ trợ viên 24/47</span></h3>
                    <p class="title-description text-center">chúng tôi năng đông, sáng tạo luôn phục vụ khách hàng nhiệt tình và tận tâm. Các bạn vui lòng liên hệ với chúng tôi khi cần tư vấn.</p>
                </div>
                <div class="content-supporter">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="inner-item">
                                <img class="img-supporter" style="border-radius: 100%; border: 1px solid #ccc; margin: auto; margin-bottom: 30px" src="http://stillusion.sg/wp-content/uploads/People_Karin.Ong@hsf.com_HC-150x150.jpg">
                                <div class="text-supporter" style="background-color: #0567a7; padding: 15px;">
                                    <h4 class="name" style="margin-bottom: 7px; color: #fff;">Mr Hương</h4>
                                    <b style="margin-bottom: 7px; color: #fff;">0987.333.333</b>
                                    <p style="color: #fff">Chuyên viên tư vấn dầu tư nhà đất Quisque velit nisi, pretium ut lacinia in, elementum id enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="inner-item">
                                <img class="img-supporter" style="border-radius: 100%; border: 1px solid #ccc; margin: auto; margin-bottom: 30px" src="https://menshealthandwellness.org/wp-content/uploads/Bruce-Hershatter_MD.jpg">
                                <div class="text-supporter" style="background-color: #0567a7; padding: 15px;">
                                    <h4 class="name" style="margin-bottom: 7px; color: #fff;">Mr Hương</h4>
                                    <b style="margin-bottom: 7px; color: #fff;">0987.333.333</b>
                                    <p style="color: #fff">Chuyên viên tư vấn dầu tư nhà đất Quisque velit nisi, pretium ut lacinia in, elementum id enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="inner-item">
                                <img class="img-supporter" style="border-radius: 100%; border: 1px solid #ccc; margin: auto; margin-bottom: 30px" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTQmf1YDv4y1eSY0jqrUOuvcl2objNKT1vY-eO0joO7CYmudk0">
                                <div class="text-supporter" style="background-color: #0567a7; padding: 15px;">
                                    <h4 class="name" style="margin-bottom: 7px; color: #fff;">Mr Hương</h4>
                                    <b style="margin-bottom: 7px; color: #fff;">0987.333.333</b>
                                    <p style="color: #fff">Chuyên viên tư vấn dầu tư nhà đất Quisque velit nisi, pretium ut lacinia in, elementum id enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php foreach($list_landing_page as $item){ if($item['type'] == 'BImage'){  ?>
<div class="title">
    <img src="<?php echo json_decode($item["data"])->image  ?>" class="img-responsive" style="margin-bottom:5px;"/>
</div>
<?php } } ?>
<?php echo $content_bottom; ?>
<?php echo $footer; ?>