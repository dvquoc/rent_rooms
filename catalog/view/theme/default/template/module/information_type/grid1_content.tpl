<?php if(!empty($data['informations'])) { ?>
<div class="row">
        <?php  foreach($data['informations'] as $key => $information) { ?>
                    <div class="col-md-<?php echo 12/$data['col'];  ?> item-post">
                        <div class="inner-content">
                            <a href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>">
                                <div class="img">
                                    <img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive">
                                </div>
                                <div class="content">
                                    <div class="header">
                                        <h3 class="title title-medium">
                                            <?php echo $information['name']; ?>
                                        </h3>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <?php if($key -1 == 12/$data['col']) { ?>
                        <div class="clearfix"></div>
                    <?php } ?>
        <?php } ?>
</div>
<?php }else { ?>
<div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>