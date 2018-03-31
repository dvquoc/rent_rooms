<?php if(!empty($data['informations'])) { ?>
        <?php  foreach($data['informations'] as $information) { ?>
                <div class="row item-post">
                    <div class="inner-item-post">
                        <div class="col-md-4">
                            <a href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>">
                                <img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive">
                            </a>
                        </div>
                        <div class="col-md-8">
                            <h3><a class="title title-medium" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>"><?php echo $information['name']; ?></a></h3>
                            <p><?php echo $information['description']; ?></p>
                            <a class="read-more" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>">Xem chi tiết &rarr;</a>
                        </div>
                    </div>
                </div>
        <?php } ?>
        <?php if(isset($data['pagination']) || isset($data['results'])) { ?>
        <div class="pagination-info">
            <div class="row">
                <div class="col-sm-6 text-left"><?php echo $data['pagination']; ?></div>
                <div class="col-sm-6 text-right"><?php echo $data['results']; ?></div>
            </div>
        </div>
        <?php } ?>
<?php }else { ?>
<h4 class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</h4>
<?php } ?>