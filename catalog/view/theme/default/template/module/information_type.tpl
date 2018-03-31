<div class="<?php echo $show_type; ?>">
  <div class="container">
  <div class="header-module">
    <h3 class="title-module title-fuature text-center"><span><?php echo $title; ?></span></h3>
    <?php if(isset($des) && !empty($des)) { ?>
      <p class="title-description text-center"><?php echo $des; ?></p>
    <?php } ?>
  </div>
  <?php echo $list_information; ?>
  </div>
</div>
