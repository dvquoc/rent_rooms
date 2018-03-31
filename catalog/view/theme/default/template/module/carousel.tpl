<div class="carousel-item">
  <h3 class="title-module title-fuature text-center"><span><?php echo $title; ?></span></h3>
  <div id="carousel<?php echo $module; ?>" class="owl-carousel owl-theme">
    <?php foreach ($banners as $banner) { ?>
    <div class="item text-center">
      <?php if ($banner['link']) { ?>
      <a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a>
      <?php } else { ?>
      <img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" />
      <?php } ?>
    </div>
    <?php } ?>
  </div>
</div>
<script type="text/javascript"><!--
$('#carousel<?php echo $module; ?>').owlCarousel({
	items: 6,
});
--></script>