<?php echo $header; ?>
<section><?php echo $theme_menu; ?></section>
<section class="warning-regiter-site">
    <div class="container text-center">
        <h3>Chọn website và dùng thử trước, quyết định mua dùng sau.</h3>
        <p>Hơn <b style="font-size: 18px;">200 +</b> Website chuyên nghiệp chờ bạn, hãy thử ngay</p>
    </div>
</section>
<section class="header-category-page">
    <div class="container">
        <div class="content-header-category">
            <div class="row">
                <div class="col-md-7 heading-page-themes">
                    <h3 class="heading-page">Chọn Mẫu <span class="highlight"> <?php echo $name; ?></span> Phù hợp với bạn</h3>
                </div>
                <div class="col-md-5">
                    <?php echo $search; ?>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="conent">
    <div class="container">
        <div class="row">
            <div class="col-md-9 pull-right">
                <?php echo $list_product ?>
            </div>
            <div class="col-md-3 pull-left">
                <div class="aside-group">
                    <div class="section-nav-title"><span>Bộ lọc</span></div>
                    <div class="aside-group-content">
                        <ul class="list-nav-category">
                            <?php  $active='not-active'; if(isset($url['price_filter']) && $url['price_filter']==0) $active='active'; ?>
                            <li class="<?php echo $active; ?>">
                                <a id="mau-thiet-ke-web" class="menu-item active" href="<?php echo $link_free;  ?>">
                                    <i class="fa fa-arrows-alt"></i>Miễn phí
                                </a>
                            </li>
                            <?php  $active=''; if(isset($url['price_filter']) && $url['price_filter']==1) $active='active'; ?>
                            <li class="<?php echo $active; ?>">
                                <a id="noi-bat" class="menu-item" href="<?php echo $link_buy;  ?>">
                                    <i class="fa fa-star-o"></i>Có phí</a>
                            </li>
                            <li>
                            <li class="devide"></li>
                            <div class="section-nav-title"><span>Lĩnh vực</span> <span class="highlight"> <?php echo $name; ?></span></div>
                            <?php if(!empty($tages)) { ?>
                                <?php foreach($tages as $item) { ?>
                                <?php  $active='not-active'; if(isset($url['tag_id']) && $url['tag_id']==$item['tag_id']) $active='active'; ?>
                                    <li class="<?php echo $active; ?>">
                                        <a id="2" class="menu-item" href="<?php echo $item['href']; ?>">
                                            <i class="fa fa-caret-right"></i><?php echo $item['name'] ?>
                                        </a>
                                    </li>
                                <?php } ?>
                            <?php } ?>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<?php echo $footer; ?>