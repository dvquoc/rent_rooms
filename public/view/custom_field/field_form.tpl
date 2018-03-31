<?php foreach ($custom_fields as $custom_field) { ?>
<?php if ($custom_field['location'] == 'account' && $field_form_type=='account') { ?>
<?php if ($custom_field['type'] == 'select') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
      <option value=""><?php echo $text_select; ?></option>
      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
      <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
      <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'radio') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div>
      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
      <div class="radio">
        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
        <label>
          <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } else { ?>
        <label>
          <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'checkbox') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div>
      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
      <div class="checkbox">
        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
        <label>
          <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } else { ?>
        <label>
          <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'text') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <div class="col-sm-12">
    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'textarea') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'file') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
    <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'date') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div class="input-group date">
      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'time') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div class="input-group time">
      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'datetime') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div class="input-group datetime">
      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'category') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <div class="col-sm-12">
    <div class="category">
      <select id="category" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
        <option value=""><?php echo $text_select; ?></option>
        <?php foreach ($categories as $categoty) { ?>
        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $categoty['category_id'] == $register_custom_field[$categoty['category_id']]) { ?>
        <option value="<?php echo $categoty['category_id']; ?>" selected="selected"><?php echo $categoty['name']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $categoty['category_id']; ?>"><?php echo $categoty['name']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
      <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
      <?php } ?>
      <script type="text/javascript">
        $('select#category').on('change', function() {
              $.ajax({
                url: 'index.php?route=page/search/autocomplete&filter_cateogry_id=' + this.value,
                dataType: 'json',
                beforeSend: function() {
                  console.log('beforeSend');
                },
                complete: function() {
                  $('.fa-spin').remove();
                },
                success: function(json) {
                  var html='';
                  $.each(json,function(key,item){
                    console.log(item);
                    html+="<div class='col-md-4'>";
                    html+="<div class='item-tage' onclick='setDataTag("+item.tag_id+")' data-valule='"+item.tag_id+"'>"+item.name+"</div>";
                    html+="</div>";
                  });
                  $('#tag_type_<?php echo $custom_field['location']; ?>').html(html);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                  alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
              });
        });
        </script>
    </div>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'tag_template') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <div class="col-sm-12">
    <div class="tag_template" style="position: relative">
      <input class="form-control hidden" type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" />
      <div class="dropdown-toggle form-control"  data-toggle="dropdown" id="tag_tempalte<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?> <span class="caret"></span></div>
      <div id="tag_type_<?php echo $custom_field['location']; ?>" class="dropdown-menu" style="width: 100%">
        Chọn loại website để tải lĩnh vực hoạt động
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  function setDataTag(tagValue){
      $("#input-custom-field<?php echo $custom_field['custom_field_id']; ?>").val(tagValue);
  }
</script>
<?php } ?>
<?php if ($custom_field['type'] == 'name_website') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <div class="col-sm-12">
    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php } ?>

<!-----------------  Address -------------->
<?php if ($custom_field['location'] == 'address' && $field_form_type=='address') { ?>
<?php if ($custom_field['type'] == 'select') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control">
      <option value=""><?php echo $text_select; ?></option>
      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
      <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
      <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'radio') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div>
      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
      <div class="radio">
        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
        <label>
          <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } else { ?>
        <label>
          <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'checkbox') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div>
      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
      <div class="checkbox">
        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
        <label>
          <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } else { ?>
        <label>
          <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
          <?php echo $custom_field_value['name']; ?></label>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'text') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'textarea') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'file') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
    <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'date') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div class="input-group date">
      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'time') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div class="input-group time">
      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php if ($custom_field['type'] == 'datetime') { ?>
<div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
  <label class="col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
  <div class="col-sm-10">
    <div class="input-group datetime">
      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-control" />
                <span class="input-group-btn">
                <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                </span></div>
    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
    <div class="text-danger"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></div>
    <?php } ?>
  </div>
</div>
<?php } ?>
<?php } ?>
<?php } ?>

