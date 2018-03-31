<?php echo $header; ?><?php echo $column_left; ?>
<div id="content" xmlns="http://www.w3.org/1999/html">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-html" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-html" class="form-horizontal">
          <div class="row">
            <div class="col-md-7">
            <input type="hidden" name="prefix_module" value="<?php echo $prefix_module; ?>" class="form-control" />
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
              <div class="col-sm-10">
                <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                <?php if ($error_name) { ?>
                <div class="text-danger"><?php echo $error_name; ?></div>
                <?php } ?>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_description="Mô tả "; ?></label>
              <div class="col-sm-10">
                <textarea type="text" name="description" placeholder="<?php echo $entry_description; ?>" id="input-name" class="form-control" /><?php echo $description; ?></textarea>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_type; ?></label>
              <div class="col-sm-10">
                <select name="type" id="input-type" class="form-control">
                  <option value="-1" >--- Chọn loại tin đăng ---</option>
                  <?php foreach ($types as $item) { ?>
                      <?php if ($item["id"]==$type) { ?>
                          <option value="<?php echo $item['id']; ?>" selected="selected"><?php echo $item["name"]; ?></option>
                      <?php } else { ?>
                          <option value="<?php echo $item['id']; ?>"><?php echo $item["name"]; ?></option>
                      <?php }  ?>
                  <?php } ?>
                </select>
              </div>
            </div>
              <div class="form-group">
                  <label class="control-label col-md-2">Lọc tin đăng</label>
                  <div class="panel-group col-md-10" id="accordion" role="tablist" aria-multiselectable="true">
                    <div class="panel panel-collapse" style="padding: 10px; border:1px solid #e4e4e4;">
                      <label data-toggle="collapse" data-target="#tab_2" data-parent="#accordion" style="width: 100%; background-color: #6bb9e2; color: #fff; padding: 7px;  border-radius: 3px; ">
                        <input class="pull-right" type="radio" id="predef_groups" name="data_source" value="list_product" <?php if (isset($data_source) && $tab['data_source'] == 'list_product' || true) { echo 'checked="checked"'; } ?> />
                        Lọc theo sản phẩm
                      </label>
                      <div class="panel-div-collapse collapse <?php if (isset($data_source) && $data_source == 'list_product' || true) { echo 'in'; } ?>" id="tab_2" style="border-top:1px solid #eee;  padding-top: 15px;">
                            <div class="form-group">
                                <label class="col-sm-3 control-label">Chọn danh mục</label>
                                <div class="col-sm-8">
                                  <select name="category" id="input-category" class="form-control">
                                    <option value="0" >--- Chọn danh mục ---</option>
                                    <?php if(!empty($categories)) { ?>
                                    <?php foreach ($categories as $item) { ?>
                                    <?php  if($item['category_id']==$category) { ?>
                                    <option selected="selected" value="<?php echo $item['category_id'] ?>" ><?php echo $item['name'] ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $item['category_id'] ?>" ><?php echo $item['name'] ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                    <?php } ?>
                                  </select>
                                </div>
                            </div>
                            <div class="form-group">
                              <label class="col-sm-3 control-label" for="input-information"><span>Chọn sản phẩm hiển thị</label>
                              <div class="col-sm-8">
                                <input type="text" name="information" value="" placeholder="Nhập tên tin cần hiển thị" id="input-information" class="form-control" />
                                <div id="information-list" class="well well-sm" style="height: 150px; overflow: auto;">
                                  <?php if(!empty($information_list)) { ?>
                                    <?php foreach ($information_list as $information) { ?>
                                    <div id="information_item<?php echo $information['information_id']; ?>">
                                      <i class="fa fa-minus-circle"></i>
                                      <?php echo $information['title']; ?>
                                      <input type="hidden" name="information_list[]" value="<?php echo $information['information_id']; ?>" />
                                    </div>
                                    <?php } ?>
                                  <?php } ?>
                                </div>
                              </div>
                            </div>
                      </div>
                    </div>
                  </div>
              </div>


            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-show-type"><?php echo $entry_show_type; ?></label>
              <div class="col-sm-4">
                <?php $list_layout = array(
                'list' =>array('Danh sách','/image/layout/list.png'),
                'grid' =>array('Grid - Dạng lưới 1','/image/layout/grid.png'),
                'grid1' =>array('Grid - Dạng lưới 2','/image/layout/grid_1.png'),
                'grid2' =>array('Grid - Dạng lưới 3','/image/layout/grid_2.png'),
                'slider' =>array('slider','/image/layout/grid.png'),
                'news' =>array('Tin tức','/image/layout/news.png'),
                'news_feature' =>array('Tin tức nỗi bật','/image/layout/list_feature.png'),
                'videos' =>array('Video','/image/layout/video.png'),
                ); ?>
                <select name="show_type" id="input-layout" class="form-control">
                  <?php foreach($list_layout as $key=>$item) { ?>
                  <?php if($key==$show_type) { ?>
                  <option data-image="<?php echo $item[1]; ?>" value="<?php echo $key; ?>" selected="selected"><?php echo $item[0]; ?></option>
                  <?php }else{ ?>
                  <option data-image="<?php echo $item[1]; ?>" value="<?php echo $key; ?>"><?php echo $item[0]; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
              </div>
              <label class="col-sm-2 control-label" for="input-slider"><?php echo $entry_slider="Là slider"; ?></label>
              <div class="col-sm-4">
                <select name="slider" id="input-slider" class="form-control">
                  <?php if ($slider) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
              <div class="col-sm-4">
                <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit" class="form-control" />
              </div>
              <label class="col-sm-2 control-label" for="input-limit_des"><?php echo $entry_limit_des="Giới hạn mô tả"; ?></label>
              <div class="col-sm-4">
                <input type="text" name="limit_des" value="<?php echo $limit_des; ?>" placeholder="<?php echo $entry_limit_des; ?>" id="input-limit-des" class="form-control" />
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-category-link">Hiển thị đường dẫn tới danh mục</label>
              <div class="col-sm-4">
                <select name="show_category_link" id="show-category-link" class="form-control">
                  <?php if ($show_category_link) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>

              <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
              <div class="col-sm-4">
                <select name="status" id="input-status" class="form-control">
                  <?php if ($status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
              </div>
            </div>
          </div>
          <div class="col-md-5">
            <h4>Hiển thị</h4>
            <div class="img-layout" style="padding: 10px; background-color: #eee; ">
              <img src="/image/layout/grid.png" class="img-responsive">
            </div>
          </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
    $('#language a:first').tab('show');
  </script>
  <script type="text/javascript">
      $('.panel-collapse > label').on('click',function(e){
          if($(this).parents('.panel-collapse').children('.panel-div-collapse').hasClass('in')){
              e.stopPropagation();
          }
      });
      $(".img-layout img").attr('src',$("#input-layout").find(':selected').data('image'));
      $("#input-layout").change(function () {
        $(".img-layout img").attr('src',$(this).find(':selected').data('image'));
      });
      var type_information = $("select[name=\'type\']").val();
      $("select[name=\'type\']").change(function () {
          type_information = $(this).val();
          $.ajax({
            url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=&filter_type='+$(this).val(),
            dataType: 'json',
            success: function(json) {
                var option = "<option value='0'>--- Chọn danh mục ---</option>";
                $.map(json, function(item) {
                    if(item['category_id'] == <?php echo $category ?>)
                    {
                        option += '<option selected="selected" value="' + item['category_id'] + '">' + item['name'] + '</option>';
                    }else{
                        option += '<option value="' + item['category_id'] + '">' + item['name'] + '</option>';
                    }
                });
                $('select[name=\'category\']').html(option);
            }
          });
      });

      $('input[name=\'information\']').autocomplete({
          'source': function(request, response) {
              $.ajax({
                  url: '<?php echo $information_autocomplete;  ?>&object_type='+type_information+'&filter_name='+encodeURIComponent(request),
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
              $('input[name=\'information\']').val('');
              $('#information_item' + item['value']).remove();
              $('#information-list').append('<div id="information_item' + item['value'] + '"><i class="fa fa-minus-circle"></i> '+ item['label']+ '<input type="hidden" name="information_list[]" value="' + item['value'] + '" /></div>');
          }
      });
      $('#information-list').delegate('.fa-minus-circle', 'click', function() {
          $(this).parent().remove();
      });
  </script>
</div>
<?php echo $footer; ?>