<div id="search" class="search-area">
  <input type="text" autocomplete="off" name="search" value="" data-category-id="<?php echo  $category_id; ?>" placeholder="Nhập lĩnh vực hoạt động của bạn">
  <button type="button" class="search-submit"><span><i class="fa fa-search"></i></span></button>
</div>
<p class="tag-text-example text-center">Gõ lĩnh vực, ví dụ:
  <?php foreach($tag_features  as $item) { ?>
  <a href="<?php echo $item['href']; ?>"><?php echo $item['name']; ?></a>
  <?php } ?>
  ...</p>