<?php echo $header; ?>
<!----------------header menu---------->

<div class="detail-container">
<div class="theme-intro responsive">
    <div class="container">
        <div class="row">
            <div class="col-md-5">
                <div class="content-left-details">
                    <h1><span><?php echo $heading_title; ?></span> </h1>
                    <div class="desc">
                        Amobile - Giao diện website Bizweb được thiết kế cho ngành hàng Điện thoại. Với sự thiết kế hiện đại, đơn giản và tối ưu. Hướng theme toát lên vẻ đơn giản nhưng nhấn vào trọng tâm của mặt hàng. Dễ...
                    </div>
                    <div class="other-info clearfix">
                        <span class="price pull-left">
                            <?php if (!$special) { ?>
                               <?php echo $price; ?>
                            <?php } else { ?>
                                <span style="text-decoration: line-through; color: #333; "><?php echo $price; ?></span>
                                <?php echo $special; ?>
                            <?php } ?>
                        </span>
                    </div>
                    <div class="theme-action">
                        <a href="javascript:;" onclick="cart.add('<?php echo $product_id; ?>');" data-toggle="modal" data-target="#myModal" class="install-theme">Sử dụng giao diện này</a>
                        <a href="<?php echo $link_view; ?>" class="view-demo action-preview-theme">Xem trước giao diện</a>
                    </div>
                    <div class="group-widget preorder-note clearfix">
                        <div class="widget-content">
                            <p>Hình ảnh và thông tin trên Website chỉ là dữ liệu minh họa. <br>Quý khách hoàn toàn có thể thay đổi hình ảnh, nội dung, bố cục hoặc màu sắc.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7 theme-image">
            <div class="image-desktop hidden-xs">
                <a href="/demo/amobile" target="_blank" class="action-preview-theme" data-url="https://amobile.bizwebvietnam.net/">
                    <img src="<?php echo  $thumb; ?>">
                </a>
            </div>
            <div class="image-mobile">
                <div class="content-img-moblie" style="margin-bottom: 0px; overflow: hidden">
                <?php foreach($images as $item) { ?>
                    <a href="javascript:;" target="_blank" class="action-preview-theme" data-url="https://amobile.bizwebvietnam.net/">
                        <img src="<?php echo  $item; ?>">
                    </a>
                <?php } ?>
                </div>
            </div>
            <script type="text/javascript">
                $(document).ready(function () {
                    $(".content-img-moblie").owlCarousel({
                        items: 1,
                        itemsDesktop: [1199, 1],
                        itemsDesktopSmall: [991, 1],
                        itemsTablet: [767, 1],
                        itemsMobile: [480, 1],
                        pagination: false,
                        slideSpeed: 400,
                        addClassActive: true,
                        scrollPerPage: false,
                        touchDrag: true,
                        autoPlay: true,
                        stopOnHover: true,
                        addClassActive: true,
                    });
                });
            </script>
        </div>
        </div>
    </div>
</div>
    <div class="theme-detail">
        <div class="container">
            <div class="row">
                <div class="support-detail col-lg-6">
                    <h3>Bạn cần hỗ trợ</h3>
                    <p>Bạn còn thắc mắc, vui lòng liên hệ </p>
                    <div class="hotline-detail">
                        <span class="highlight">012.2313.1231</span> hoặc  <span class="highlight">012.2313.1231</span>
                    </div>
                </div>

                <div class="col-sm-6 tages">
                    <h3>Lĩnh vực liên quan</h3>
                    <div class="tag-list">
                        <a  class="tag" href="<?php echo $category['link']?>"><i class="fa fa-tags"></i> <?php echo $category['name']?></a>
                        <?php foreach($tages as $item) { ?>
                        <a href="<?php echo $item['href']; ?>" class="tag"><i class="fa fa-tags"></i> <?php echo $item['name']; ?></a>
                        <?php } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br>
    <div class="themes-related">
        <div class="container">
            <h3 class="title-related">Các giao diện thuộc lĩnh vực </h3>
            <?php echo $list_product_relative; ?>
        </div>
    </div>
</div>
<?php echo $footer; ?>