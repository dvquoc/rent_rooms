<?php echo $header; ?>
<script type="text/javascript">
    var propertyImages =[<?php foreach($information_full_images as $item_link){ ?>{src:"<?php echo $item_link?>", type : "image", opts : {}},<?php }?>];
        var pswpElement = document.querySelectorAll('.pswp')[0];
        $(document).on("click", ".img-photo", function(){
            var self = $(this);
            $.fancybox.open( propertyImages, {}, parseInt(self.attr("index")) );
            return false;
        });
</script>
<div class="breadcrumbs">
  <div class="container">
    <ul class="breadcrumb">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
      <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>

  </div>
</div>
<div class="position-top">
  <?php echo $content_top; ?>
</div>
<section>
  <div class="container-fluid-full">
    <?php if(!empty($information_images)) { ?>
    <div class="images" id="hinh-anh" style="margin-top: -17px;">
      <ul class="list-image owl-carousel owl-theme">
        <?php $lengImage = count($information_images); foreach($information_images as $key => $image) { ?>
        <li class="item-image"><img index="<?php echo $key; ?>" src="<?php  echo $image ?>" class="img-responsive img-photo"></li>
        <?php } ?>
      </ul>
    </div>
    <script type="text/javascript"><!--
        $('#hinh-anh .list-image').owlCarousel({
            items: 3,
            autoPlay: false,
            navigation: true,
            navigationText: false,
            pagination: false
        });
        --></script>
    <?php } ?>
  </div>
</section>
<section class="section">
  <div class="container">
  <div class="row">
    <?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <ul class="menu-owner">
        <li class="active"><a href="<?php echo $link_detail?>#hinh-anh">Hình ảnh</a></li>
        <?php if(!empty($meta_data["_project_link"])) { ?>
          <?php foreach($meta_data["_project_link"] as $key => $item) { ?>
            <li><a href="<?php echo $link_detail.$item->link;?>"><?php echo $item->title;  ?></a></li>
          <?php } ?>
        <?php } ?>
        <li class="pull-right"><a class="contact-menu" href="lien-he.html"><i class="fa fa-send"></i> Yêu cầu thông tin</a></li>
        <li class="pull-right"><a class="hotline-menu" href="#(028) - 2342. 2342"><i class="fa fa-phone"></i> (028) - 2342. 2342</a></li>
      </ul>
      <h1><?php echo $heading_title; ?></h1>
      <div class="content-of-page">
        <?php echo $description; ?>
      </div>
      <?php if(!empty($information_tags)) { ?>
      <h3>Tags: </h3>
      <div class="tag-application">
        <?php foreach($information_tags as $tag) { ?>
        <a href="<?php echo $tag['href']; ?>" class="item-tag"><?php echo $tag['name']; ?></a>
        <?php } ?>
      </div>
      <?php } ?>
      <?php echo $content_bottom; ?>
    </div>
    <?php echo $column_right; ?></div>
</div>
  <?php if(!empty($relative)) { ?>
  <div class="news-relative"  style="margin-top: 20px;">
    <div class="container">
      <div class="header-module">
        <h3 class="title-module title-fuature text-center"><span>Dự án liên quan</span></h3>
      </div>
      <?php echo $relative; ?>
    </div>
  </div>
  <?php } ?>

  <?php if(!empty($relative_news)) { ?>
    <div class="news-relative" style="background-color: #eee; padding: 20px 0px;">
      <div class="container">
        <div class="header-module">
          <h3 class="title-module title-fuature text-center"><span>Tin tức liên quan</span></h3>
        </div>
        <?php echo $relative_news; ?>
      </div>
    </div>
  <?php } ?>

</section>
<?php echo $footer; ?>