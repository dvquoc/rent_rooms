<?php if(!empty($data['informations'])) { ?>
<div class="grid">
    <div class="row">
        <?php  foreach($data['informations'] as $key => $information) { ?>
        <div class="col-md-<?php echo 12/$data['col'];  ?> item-post">
            <div class="inner-content">
                <div class="img">
                    <img src="<?php echo $information['thumb']; ?>" alt="<?php echo $information['name']; ?>" class="img-responsive">
                </div>
                <div class="content">
                    <div class="header">
                        <h3>
                            <a class="title title-medium" href="<?php echo $information['href']; ?>" title="<?php echo $information['name']; ?>"><?php echo $information['name']; ?></a>
                        </h3>
                        <?php if(isset($information['meta_data'])) { ?>
                        <div class="position"><?php echo  isset($information['meta_data']['_project_local']) ? $information['meta_data']['_project_local'] : '' ?></div>
                        <div class="date-start">Khởi công: <?php  echo  isset($information['meta_data']['_project_date_start']) ? $information['meta_data']['_project_date_start'] : '' ?></div>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
        <?php if($key -1 == 12/$data['col']) { ?>
        <div class="clearfix"></div>
        <?php } ?>
        <?php } ?>
    </div>
    <?php if(isset($data['pagination']) || isset($data['results'])) { ?>
        <div class="pagination-info">
            <div class="row">
                <div class="col-sm-6 text-left"><?php echo $data['pagination']; ?></div>
                <div class="col-sm-6 text-right"><?php echo $data['results']; ?></div>
            </div>
        </div>
    <?php } ?>
</div>
<?php }else { ?>
<div class="text-center alert alert-danger">Không có dữ liệu để hiển thị !</div>
<?php } ?>