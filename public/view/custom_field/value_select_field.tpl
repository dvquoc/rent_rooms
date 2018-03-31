<table id="custom-field-value" class="table table-striped table-bordered table-hover">
  <thead>
  <tr>
    <td class="text-left required"><?php echo $entry_custom_value; ?></td>
    <td class="text-right"><?php echo $entry_sort_order; ?></td>
    <td></td>
  </tr>
  </thead>
  <tbody>
  <?php $custom_field_value_row = 0; ?>
  <?php foreach ($custom_field_values as $custom_field_value) { ?>
  <tr id="custom-field-value-row<?php echo $custom_field_value_row; ?>">
    <td class="text-left" style="width: 70%;"><input type="hidden" name="custom_field_value[<?php echo $custom_field_value_row; ?>][custom_field_value_id]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
      <?php foreach ($languages as $language) { ?>
      <div class="input-group"> <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span>
        <input type="text" name="custom_field_value[<?php echo $custom_field_value_row; ?>][custom_field_value_description][<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($custom_field_value['custom_field_value_description'][$language['language_id']]) ? $custom_field_value['custom_field_value_description'][$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_custom_value; ?>" class="form-control" />
      </div>
      <?php if (isset($error_custom_field_value[$custom_field_value_row][$language['language_id']])) { ?>
      <div class="text-danger"><?php echo $error_custom_field_value[$custom_field_value_row][$language['language_id']]; ?></div>
      <?php } ?>
      <?php } ?></td>
    <td class="text-right"><input type="text" name="custom_field_value[<?php echo $custom_field_value_row; ?>][sort_order]" value="<?php echo $custom_field_value['sort_order']; ?>" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>
    <td class="text-left"><button onclick="$('#custom-field-value-row<?php echo $custom_field_value_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
  </tr>
  <?php $custom_field_value_row++; ?>
  <?php } ?>
  </tbody>
  <tfoot>
  <tr>
    <td colspan="2"></td>
    <td class="text-left"><button type="button" onclick="addCustomFieldValue();" data-toggle="tooltip" title="<?php echo $button_custom_field_value_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
  </tr>
  </tfoot>
</table>
<script type="text/javascript"><!--
$('select[name=\'type\']').trigger('change');

var custom_field_value_row = <?php echo $custom_field_value_row; ?>;

function addCustomFieldValue() {
html  = '<tr id="custom-field-value-row' + custom_field_value_row + '">';
  html += '  <td class="text-left" style="width: 70%;"><input type="hidden" name="custom_field_value[' + custom_field_value_row + '][custom_field_value_id]" value="" />';
    <?php foreach ($languages as $language) { ?>
    html += '    <div class="input-group">';
      html += '      <span class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></span><input type="text" name="custom_field_value[' + custom_field_value_row + '][custom_field_value_description][<?php echo $language['language_id']; ?>][name]" value="" placeholder="<?php echo $entry_custom_value; ?>" class="form-control" />';
      html += '    </div>';
    <?php } ?>
    html += '  </td>';
  html += '  <td class="text-right"><input type="text" name="custom_field_value[' + custom_field_value_row + '][sort_order]" value="" placeholder="<?php echo $entry_sort_order; ?>" class="form-control" /></td>';
  html += '  <td class="text-left"><button type="button" onclick="$(\'#custom-field-value-row' + custom_field_value_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
  html += '</tr>';

$('#custom-field-value tbody').append(html);

custom_field_value_row++;
}
//--></script>