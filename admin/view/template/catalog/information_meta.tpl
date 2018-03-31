<?php if(!empty($data)) { ?>
    <?php foreach($data as $name_field => $item) { ?>
    <div class="form-group<?php echo  ($item['required']) ? ' required' : '';  ?>">
        <label class="control-label col-sm-2 <?php echo $item['type']; ?>"><?php echo $item['label']; ?></label>
        <div class="col-sm-10">
            <?php if($item['type']=='text' || $item['type']=='hidden') { ?>
                <input type="<?php echo $item['type']; ?>" name="meta_data[<?php echo $item['name']; ?>]" value="<?php echo $item['value']; ?>" id="<?php echo $item['name']; ?>" class="form-control" />
            <?php } elseif($item['type']=='textarea') { ?>
                <textarea name="meta_data[<?php echo $item['name']; ?>]" id="<?php echo $item['name']; ?>" class="form-control"><?php echo $item['value']; ?></textarea>
            <?php } elseif($item['type']=='radio') { ?>
                <?php foreach($item['data_option'] as $key=>$item_radio) { ?>
                    <label class="radio-inline">
                        <?php if($item['value']==$item_radio[0]){ ?>
                            <input type="radio" checked="checked" name="meta_data[<?php echo $item['name']; ?>]" value="<?php echo $item_radio[0]; ?>">
                        <?php } else { ?>
                            <input type="radio" name="meta_data[<?php echo $item['name']; ?>]" value="<?php echo $item_radio[0]; ?>">
                        <?php } ?>
                        <?php echo $item_radio[1]; ?>
                    </label>
                <?php } ?>
            <?php } elseif($item['type']=='link-menu') { ?>
                <input type="<?php echo $item['type']; ?>" name="meta_data[<?php echo $item['name']; ?>]" value="<?php echo $item['value']; ?>" id="<?php echo $item['name']; ?>" class="form-control" />
                <a class="btn bnt-primary">[+] Add Đường dẫn</a>
            <?php }elseif($item['type']=='autocomplete'){ $id_autocomplete=time();?>
                <input type="text" name="input_autocomplete_<?php echo $id_autocomplete;?>" value="" placeholder="nhập giá trị" class="form-control" />
                <div id="meta_data<?php echo $item['name']; ?>_autocomplete" class="well well-sm" style="height: 150px; overflow: auto;">
                    <?php if(!empty($item['value'])) { ?>
                        <?php foreach ($item['value'] as $item_autocomplete) { ?>
                            <div id="item<?php echo $item['name']; ?>_autocomplete<?php echo $item_autocomplete['information_id']; ?>" class="container-autocomplete">
                                <i class="fa fa-minus-circle"></i><?php echo $item_autocomplete['title']; ?>
                                <input type="hidden" name="meta_data[<?php echo $item['name']; ?>][]" value="<?php echo $item_autocomplete['information_id']; ?>" />
                            </div>
                        <?php } ?>
                    <?php } ?>
                </div>
                <script type="text/javascript">
                    $('input[name=\'input_autocomplete_<?php echo $id_autocomplete;?>\']').autocomplete({
                        'source': function(request, response) {
                            $.ajax({
                                url: 'index.php?route=catalog/information/autocomplete&token=<?php echo $item["token"]; ?>&object_type=<?php echo $item["type_object_relative"] ?>&filter_name='+encodeURIComponent(request),
                                dataType: 'json',
                                success: function(json) {
                                    response($.map(json, function(item) {
                                        return {
                                        label: item['name'],
                                        value: item['id']
                                        }
                                    }));
                                }
                            });
                        },
                        'select': function(item) {
                            $('input[name=\'input_autocomplete_<?php echo $id_autocomplete;?>\']').val('');
                            $('#item<?php echo $item["name"]; ?>_autocomplete'+ item['value']).remove();
                            $('#meta_data<?php echo $item["name"]; ?>_autocomplete').append('<div id="item<?php echo $item['name']; ?>_autocomplete'+item['value']+'"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="meta_data[<?php echo $item['name']; ?>][]" value="' + item['value'] + '" /></div>');
                        }
                    });
                    $('.container-autocomplete').delegate('.fa-minus-circle', 'click', function() {
                        $(this).parent().remove();
                    });
                </script>
            <?php } ?>
        </div>
    </div>
    <?php } ?>
<?php } ?>