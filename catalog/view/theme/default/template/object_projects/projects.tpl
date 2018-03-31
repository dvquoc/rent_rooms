<?php echo $header; ?>
<div class="breadcrumbs">
    <div class="container">
        <ul class="breadcrumb">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
            <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
    </div>
</div>
<div class="container">
    <section class="section section-list-category">
        <div class="header-module">
            <h3 class="title-module title-fuature text-center"><span>Danh mục dự án</span></h3>
            <p class="title-description text-center">Các dự hot nhất Vinhome Groups</p>
        </div>
        <div class="owl-carousel owl-theme" id="slider-category">
            <?php
            $number_category=count($categories);
            if($number_category >= 4)
            $class="col-md-3";
            elseif($number_category==3)
            $class="col-md-4";
            elseif($number_category==2)
            $class="col-md-6";
            ?>
            <?php foreach($categories as $category){ ?>
            <div class="item">
                <?php if(isset($category_id) && $category_id==$category['category_id']) { ?>
                    <div class="item-category active">
                        <div class="row">
                        <div class="col-md-4">
                            <img src="<?php echo $category['image']; ?>" class="img-responsive">
                        </div>
                        <div class="col-md-8">
                            <a href="<?php echo $category['href']; ?>" class="">
                                <b><?php echo $category['name']; ?></b>
                            </a>
                            <p><?php echo $category['des']; ?></p>
                        </div>
                        </div>
                    </div>
                <?php }else{ ?>
                    <div class="item-category">
                        <div class="row">
                            <div class="col-md-4">
                                <img src="<?php echo $category['image']; ?>" class="img-responsive">
                            </div>
                            <div class="col-md-8">
                                <a href="<?php echo $category['href']; ?>" class="">
                                    <b><?php echo $category['name']; ?></b>
                                    <p><?php echo $category['des']; ?></p>
                                </a>
                            </div>
                        </div>
                    </div>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
        <script type="text/javascript">
            $('#slider-category').owlCarousel({
                items: 3,
                margin:15,
                nav:false,
                dots:true
            });
        </script>
    </section>
    <div class="row" style="margin-top: 15px;">
        <?php echo $column_left; ?>
        <?php if ($column_left && $column_right) { ?>
        <?php $class = 'col-sm-6'; ?>
        <?php } elseif ($column_left || $column_right) { ?>
        <?php $class = 'col-sm-9'; ?>
        <?php } else { ?>
        <?php $class = 'col-sm-12'; ?>
        <?php } ?>

        <div id="content" class="col-sm-12">
            <?php echo $content_top; ?>
            <div class="header-module">
                <h3 class="title-module title-fuature text-center"><span>Danh sách dự án</span></h3>
                <p class="title-description text-center">Các dự án luôn đầy đủ thông tin và mới nhất</p>
            </div>
            <?php echo $list_information; ?>
            <?php echo $content_bottom; ?>
        </div>
    </div>
</div>
<?php echo $footer; ?>