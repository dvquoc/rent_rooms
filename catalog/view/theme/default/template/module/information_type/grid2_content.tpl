<?php if(!empty($data['informations'])) { ?>
<div class="row">
        <div id="carousel<?php echo $prefix_module; ?>" class="owl-carousel owl-theme">
            <?php  foreach($data['informations'] as $key => $information) { ?>
                        <div class="col-md-<?php echo $data['slider'] ? 12 : 12/$data['col'];  ?> item-post">
                            <div class="inner-content">

                                <div class="img">
                                    <a  href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>">
                                    <img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive">
                                    </a>
                                </div>
                                <div class="content">
                                    <div class="header">
                                        <h3>
                                            <a class="title title-medium" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>">
                                                <?php echo $information['name']; ?>
                                            </a>
                                        </h3>
                                    </div>
                                    <p class="des"><?php echo $information['description']; ?></p>
                                </div>

                            </div>
                        </div>
            <?php } ?>
        </div>
</div>
<?php if($data['slider']) { ?>
    <script type="text/javascript">
        $('#carousel<?php echo $prefix_module; ?>').owlCarousel({
            items: 3,
            nav:true,
            navText:["❮","❯"],
        });
        </script>
    <?php } ?>
<?php }else { ?>
<div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>