<?php if(!empty($data['informations'])) { ?>
<div class="row">
        <div class="col-md-12 feature-post">
            <div class="img">
                <img src="<?php echo $data['informations'][0]['thumb']; ?>" alt="<?php echo $data['informations'][0]['name']; ?>" class="img-responsive">
            </div>
            <div class="content">
                <h3><a class="title title-medium" href="<?php echo $data['informations'][0]['href']; ?>" title="<?php echo $data['informations'][0]['name']; ?>"><?php echo $data['informations'][0]['name']; ?></a></h3>
                <p><?php echo $data['informations'][0]['description']; ?></p>
            </div>
        </div>
        <div class="col-md-12">
            <?php foreach($data['informations'] as $key => $information) { if($key==0) continue;  ?>
                        <div class="row item-post">
                            <div class="col-md-12">
                                <div class="inner-content">
                                    <ul class="list-title">
                                        <li><i class="fa fa-question-circle"></i> <a class="title" href="<?php echo $data['informations'][0]['href']; ?>" title="<?php echo $data['informations'][0]['name']; ?>"><?php echo $information['name']; ?></a></li>
                                        <li><i class="fa fa-question-circle"></i> <a class="title" href="<?php echo $data['informations'][0]['href']; ?>" title="<?php echo $data['informations'][0]['name']; ?>"><?php echo $information['name']; ?></a></li>
                                        <li><i class="fa fa-question-circle"></i> <a class="title" href="<?php echo $data['informations'][0]['href']; ?>" title="<?php echo $data['informations'][0]['name']; ?>"><?php echo $information['name']; ?></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
            <?php } ?>
        </div>
</div>
<?php }else { ?>
<div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>