<?php if(!empty($data['informations'])) { ?>
<div class="row">
        <div class="col-md-6 col-sm-6 col-xs-12 feature-post">
            <div class="img">
                <img src="<?php echo $data['informations'][0]['thumb']; ?>" alt="<?php echo $data['informations'][0]['name']; ?>" class="img-responsive">
            </div>
            <div class="content">
                <h3><a class="title title-medium" href="<?php echo $data['informations'][0]['href']; ?>" title="<?php echo $data['informations'][0]['name']; ?>"><?php echo $data['informations'][0]['name']; ?></a></h3>
                <p><?php echo $data['informations'][0]['description']; ?></p>
            </div>
        </div>
        <div class="col-md-6 col-sm-6 col-xs-12">
            <?php foreach($data['informations'] as $key => $information) { if($key==0) continue;  ?>
                        <div class="row item-post">
                            <div class="inner-content">
                                <div class="col-md-5 img">
                                    <img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive">
                                </div>
                                <div class="content col-md-7">
                                    <h3><a class="title" href="<?php echo $data['informations'][0]['href']; ?>" title="<?php echo $data['informations'][0]['name']; ?>"><?php echo $information['name']; ?></a></h3>
                                    <p><?php echo $information['description']; ?></p>
                                </div>
                            </div>
                        </div>
            <?php } ?>
        </div>
</div>
<?php if($show_category_link){ ?>
    <div class="text-center"><a class="read-more btn btn-primary" href="<?php echo $category_link ?>" title="xem tất cả">Xem tất cả &#8674;</a></div>
<?php  } ?>
<?php }else { ?>
<div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>