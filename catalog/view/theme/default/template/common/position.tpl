<?php if ($modules) { ?>
<column <?php if(isset($position_prefix)) { echo "id=\"".$position_prefix."\"";  } ?>>
  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>
</column>
<?php } ?>