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
<div class="section">
  <div class="container">
    <div class="row"><?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-sm-9'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
        <h1><?php echo $heading_title; ?></h1>
        <?php echo $description; ?>
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
</div>
<?php echo $footer; ?>