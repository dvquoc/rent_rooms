<?php echo $header; ?>
<?php echo $theme_menu; ?>
<div class="container">
<section class="list-product">
    <?php if(!empty($list_product)) { ?>
        <?php echo $list_product; ?>
    <?php }else { ?>
    Hiện tại siêu thị mẫu của chúng tôi không mẫu nào phù hợp với lĩnh vực bạn chọn
    <?php } ?>
</section>
</div>
<?php echo $footer; ?>