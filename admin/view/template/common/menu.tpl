<ul id="menu">
  <li id="dashboard"><a href="<?php echo $home; ?>"><i class="fa fa-dashboard fa-fw"></i> <span><?php echo $text_dashboard; ?></span></a></li>
  <li id="manager-content"><a class="parent"><i class="fa fa-tags fa-fw"></i><span>Quản lý nội dung</span></a>
    <ul>
      <?php foreach($objects as $key=>$object){ ?>
      <li id="catalog"><a class="parent"> <span><?php echo $object['item_menu_name_group'] ?></span></a>
        <ul>
          <?php foreach($object['item_menu'] as $item_menu) { ?>
          <li><a href="<?php echo $item_menu[0]; ?>"><?php echo $item_menu[1]; ?></a></li>
          <?php } ?>
        </ul>
      </li>
      <?php } ?>
    </ul>
  </li>
  <li id="extension"><a class="parent"><i class="fa fa-puzzle-piece fa-fw"></i> <span><?php echo $text_extension; ?></span></a>
    <ul>
      <li><a href="<?php echo $installer; ?>"><?php echo $text_installer; ?></a></li>
      <li><a href="<?php echo $modification; ?>"><?php echo $text_modification; ?></a></li>
      <li><a href="<?php echo $module; ?>"><?php echo $text_module; ?></a></li>
      <li><a href="<?php echo $feed; ?>"><?php echo $text_feed; ?></a></li>
      <li><a href="<?php echo $fraud; ?>"><?php echo $text_fraud; ?></a></li>
    </ul>
  </li>

  <li id="system"><a class="parent"><i class="fa fa-cog fa-fw"></i> <span><?php echo $text_system; ?></span></a>
    <ul>
      <li><a href="<?php echo $setting; ?>"><?php echo $text_setting; ?></a></li>
      <li><a class="parent"><?php echo $text_design; ?></a>
        <ul>
          <li><a href="<?php echo $layout; ?>"><?php echo $text_layout; ?></a></li>
          <li><a href="<?php echo $banner; ?>"><?php echo $text_banner; ?></a></li>
        </ul>
      </li>
      <li><a class="parent"><?php echo $text_users; ?></a>
        <ul>
          <li><a href="<?php echo $user; ?>"><?php echo $text_user; ?></a></li>
          <li><a href="<?php echo $user_group; ?>"><?php echo $text_user_group; ?></a></li>
        </ul>
      </li>
      <li><a href="<?php echo $language; ?>"><?php echo $text_language; ?></a></li>
    </ul>
  </li>
  <li id="tools"><a class="parent"><i class="fa fa-wrench fa-fw"></i> <span><?php echo $text_tools; ?></span></a>
    <ul>
      <li><a href="<?php echo $upload; ?>"><?php echo $text_upload; ?></a></li>
      <li><a href="<?php echo $backup; ?>"><?php echo $text_backup; ?></a></li>
    </ul>
  </li>
  <li><a type="button" id="button-menu"><i class="fa fa-indent fa-lg"></i> <span>Ẩn hiện menu</span></a></li>
</ul>
