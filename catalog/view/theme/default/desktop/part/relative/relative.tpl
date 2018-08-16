<?php if(!empty($informations)) { ?>
<div class="grid1">
    <div class="row section-item <?php if(isset($isCarousel)) echo 'item-carousel'; ?>">
            <?php  foreach($informations as $key => $information) { ?>
                        <div class="item-post col-md-<?php echo 12/$col;  ?>">
                            <div class="inner-content">
                                <div class="img">
                                    <img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive">
                                </div>
                                <div class="content">
                                    <div class="header">
                                        <h3>
                                            <a class="title" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>"><?php echo $information['name']; ?></a>
                                        </h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <?php if($key == 12/$col) { ?>
                            <div class="clearfix"></div>
                        <?php } ?>
            <?php } ?>
    </div>
</div>
<?php }else { ?>
    <div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>