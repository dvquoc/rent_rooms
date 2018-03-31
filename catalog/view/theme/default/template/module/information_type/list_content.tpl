<?php if(!empty($data['informations'])) { ?>
        <?php  foreach($data['informations'] as $information) { ?>
                <div class="row section-item">
                    <div class="col-md-4"><img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive"></div>
                    <div class="col-md-8">
                        <h3><a class="title" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>"><?php echo $information['name']; ?></a></h3>
                        <p><?php echo $information['description']; ?></p>
                        <a class="read-more" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>">Xem chi tiết [+]</a>
                    </div>
                </div>
        <?php } ?>
<?php }else { ?>
<div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>