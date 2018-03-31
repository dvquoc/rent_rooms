<select name="type" id="input-type" class="form-control">
  <optgroup label="<?php echo $text_choose; ?>">
    <?php if ($type == 'select') { ?>
    <option value="select" selected="selected"><?php echo $text_select; ?></option>
    <?php } else { ?>
    <option value="select"><?php echo $text_select; ?></option>
    <?php } ?>
    <?php if ($type == 'radio') { ?>
    <option value="radio" selected="selected"><?php echo $text_radio; ?></option>
    <?php } else { ?>
    <option value="radio"><?php echo $text_radio; ?></option>
    <?php } ?>
    <?php if ($type == 'checkbox') { ?>
    <option value="checkbox" selected="selected"><?php echo $text_checkbox; ?></option>
    <?php } else { ?>
    <option value="checkbox"><?php echo $text_checkbox; ?></option>
    <?php } ?>
    <?php if ($type == 'category') { ?>
    <option value="category" selected="selected">Category</option>
    <?php } else { ?>
    <option value="category">Category</option>
    <?php } ?>
    <?php if ($type == 'tag_template') { ?>
    <option value="tag_template" selected="selected">Tag template</option>
    <?php } else { ?>
    <option value="tag_template">Tag template</option>
    <?php } ?>
    <?php if ($type == 'name_website') { ?>
    <option value="name_website" selected="selected">Tên website</option>
    <?php } else { ?>
    <option value="name_website">Tên website</option>
    <?php } ?>
  </optgroup>
  <optgroup label="<?php echo $text_input; ?>">
    <?php if ($type == 'text') { ?>
    <option value="text" selected="selected"><?php echo $text_text; ?></option>
    <?php } else { ?>
    <option value="text"><?php echo $text_text; ?></option>
    <?php } ?>
    <?php if ($type == 'textarea') { ?>
    <option value="textarea" selected="selected"><?php echo $text_textarea; ?></option>
    <?php } else { ?>
    <option value="textarea"><?php echo $text_textarea; ?></option>
    <?php } ?>
  </optgroup>
  <optgroup label="<?php echo $text_file; ?>">
    <?php if ($type == 'file') { ?>
    <option value="file" selected="selected"><?php echo $text_file; ?></option>
    <?php } else { ?>
    <option value="file"><?php echo $text_file; ?></option>
    <?php } ?>
  </optgroup>
  <optgroup label="<?php echo $text_date; ?>">
    <?php if ($type == 'date') { ?>
    <option value="date" selected="selected"><?php echo $text_date; ?></option>
    <?php } else { ?>
    <option value="date"><?php echo $text_date; ?></option>
    <?php } ?>
    <?php if ($type == 'time') { ?>
    <option value="time" selected="selected"><?php echo $text_time; ?></option>
    <?php } else { ?>
    <option value="time"><?php echo $text_time; ?></option>
    <?php } ?>
    <?php if ($type == 'datetime') { ?>
    <option value="datetime" selected="selected"><?php echo $text_datetime; ?></option>
    <?php } else { ?>
    <option value="datetime"><?php echo $text_datetime; ?></option>
    <?php } ?>
  </optgroup>
</select>

<script type="text/javascript"><!--
  $('select[name=\'type\']').on('change', function() {
    if (this.value == 'select' || this.value == 'radio' || this.value == 'checkbox') {
      $('#custom-field-value').show();
      $('#display-value').hide();
    } else {
      $('#custom-field-value').hide();
      $('#display-value').show();
    }
    if (this.value == 'date') {
      $('#display-value > div').html('<div class="input-group date"><input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" data-date-format="YYYY-MM-DD" id="input-value" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div>');
    } else if (this.value == 'time') {
      $('#display-value > div').html('<div class="input-group time"><input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" data-date-format="HH:mm" id="input-value" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div>');
    } else if (this.value == 'datetime') {
      $('#display-value > div').html('<div class="input-group datetime"><input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-value" class="form-control" /><span class="input-group-btn"><button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button></span></div>');
    } else if (this.value == 'textarea') {
      $('#display-value > div').html('<textarea name="value" placeholder="<?php echo $entry_value; ?>" id="input-value" class="form-control">' + $('#input-value').val() + '</textarea>');
    } else if(this.value=='category'){
      var html='<select name="value" class="form-control">';
      <?php foreach($categories as $item) { ?>
        html+='<option value="<?php echo $item['category_id']; ?>"><?php echo $item['name']; ?></option>';
      <?php } ?>
      html+='</select>';
      $('#display-value > div').html(html);
    }else {
      $('#display-value > div').html('<input type="text" name="value" value="' + $('#input-value').val() + '" placeholder="<?php echo $entry_value; ?>" id="input-value" class="form-control" />');
    }
    $('.date').datetimepicker({
      pickTime: false
    });

    $('.time').datetimepicker({
      pickDate: false
    });

    $('.datetime').datetimepicker({
      pickDate: true,
      pickTime: true
    });
  });

  // Tag
  $('input[name=\'tag\']').autocomplete({
    'source': function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/tag/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request)+"&filter_tag_type=default",
        dataType: 'json',
        success: function(json) {
          response($.map(json, function(item) {
            return {
              label: item['name'],
              value: item['tag_id']
            }
          }));
        }
      });
    },
    'select': function(item) {
      $('input[name=\'tag\']').val('');

      $('#product-tag' + item['value']).remove();

      $('#product-tag').append('<div id="product-tag' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="product_tag[]" value="' + item['value'] + '" /></div>');
    }
  });

  $('#product-tag').delegate('.fa-minus-circle', 'click', function() {
    $(this).parent().remove();
  });
  //--></script>