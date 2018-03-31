<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-information" class="btn btn-primary"><i class="fa fa-save"></i> <?php echo $button_save; ?></button>
        <a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> <?php echo $button_cancel; ?></a></div>
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
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-information" class="form-horizontal">
        <div class="row">
          <div class="col-md-9">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-inbox"></i> <?php echo $text_form; ?></h3>
                </div>
                <div class="panel-body">
                    <ul class="nav nav-tabs">
                      <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                      <li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
                    </ul>
                    <div class="tab-content">
                      <div class="tab-pane active" id="tab-general">
                        <ul class="nav nav-tabs" id="language">
                          <?php foreach ($languages as $language) { ?>
                          <li class="pull-left"><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><?php echo $language['name']; ?> - <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></a></li>
                          <?php } ?>
                        </ul>
                        <div class="tab-content">
                          <?php foreach ($languages as $language) { ?>
                          <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                            <fieldset>
                                  <legend>Thiết lập SEO</legend>
                                  <div class="content-fieldset">
                                      <div class="form-group required">
                                          <div class="col-md-12">
                                              <div class="input-group">
                                                  <label class="input-group-addon control-label" for="input-meta-title<?php echo $language['language_id']; ?>"><?php echo $entry_meta_title; ?> <span style="color:red"> *</span></label>
                                                  <input type="text" name="information_description[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['meta_title'] : ''; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title<?php echo $language['language_id']; ?>" class="form-control" />
                                                  <?php if (isset($error_meta_title[$language['language_id']])) { ?>
                                                  <div class="text-danger"><?php echo $error_meta_title[$language['language_id']]; ?></div>
                                                  <?php } ?>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-sm-2  hidden control-label" for="input-meta-description<?php echo $language['language_id']; ?>"><?php echo $entry_meta_description; ?></label>
                                          <div class="col-sm-6">
                                              <textarea name="information_description[<?php echo $language['language_id']; ?>][meta_description]" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                                          </div>
                                          <div class="col-sm-6">
                                              <textarea name="information_description[<?php echo $language['language_id']; ?>][meta_keyword]" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                                          </div>
                                      </div>
                                  </div>
                              </fieldset>
                            <div class="form-group row">
                              <div class="col-md-6 required">
                                  <div class="input-group">
                                    <label class="input-group-addon control-label"><?php echo $entry_title; ?> <span style="color:red"> *</span></label>
                                    <input type="text" name="information_description[<?php echo $language['language_id']; ?>][title]" value="<?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['title'] : ''; ?>" placeholder="<?php echo $entry_title; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
                                    <?php if (isset($error_title[$language['language_id']])) { ?>
                                    <div class="text-danger"><?php echo $error_title[$language['language_id']]; ?></div>
                                    <?php } ?>
                                  </div>
                              </div>
                              <div class="col-md-6">
                                <div class="input-group">
                                    <label class="input-group-addon control-label">Đường dẫn thân thiện</label>
                                    <input type="text" name="information_description[<?php echo $language['language_id']; ?>][keyword]" value="<?php echo isset($information_description[$language['language_id']]['keyword']) ? $information_description[$language['language_id']]['keyword'] : ''; ?>" placeholder="<?php echo $entry_keyword; ?>" id="input-title<?php echo $language['language_id']; ?>" class="form-control" />
                                </div>
                              </div>
                            </div>
                            <?php if(!empty($meta_contents['tab_1'])) { ?>
                              <?php echo $meta_contents['tab_1']; ?>
                            <?php } ?>

                            <div class="form-group required">
                              <div class="col-sm-12">
                                <textarea name="information_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($information_description[$language['language_id']]) ? $information_description[$language['language_id']]['description'] : ''; ?></textarea>
                                <?php if (isset($error_description[$language['language_id']])) { ?>
                                <div class="text-danger"><?php echo $error_description[$language['language_id']]; ?></div>
                                <?php } ?>
                              </div>
                            </div>
                          </div>
                          <?php } ?>
                        </div>
                      </div>
                      <div class="tab-pane" id="tab-data">
                        <input type="hidden" name="information_type" value="<?php echo $information_type; ?>" id="input-information-type" />
                        <div class="form-group">
                          <label class="col-sm-2 control-label" for="input-bottom"><span data-toggle="tooltip" title="Đánh dấu nổi bật">Nổi bật</span></label>
                          <div class="col-sm-10">
                            <select name="feature" id="input-feature" class="form-control">
                              <?php if($feature==0) { ?>
                                <option selected="selected" value="0">Không</option>
                                <option value="1">Có</option>
                              <?php }else { ?>
                                <option selected="selected" value="1">Có</option>
                                <option value="0">Không</option>
                              <?php } ?>
                            </select>
                          </div>
                        </div>
                        <?php if(isset($categories)) { ?>
                            <div class="form-group">
                              <label class="col-sm-2 control-label" for="input-bottom"><span data-toggle="tooltip" title="Chọn danh mục">Danh mục</span></label>
                              <div class="col-sm-10">
                                <select name="category_id" id="input-status" class="form-control">
                                    <option>---- Chọn danh mục ----</option>
                                    <?php foreach($categories as $key=>$category) { ?>
                                    <?php if($category['category_id']==$category_id) { ?>
                                    <option selected="selected" value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                                    <?php }else { ?>
                                    <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select>
                              </div>
                            </div>
                        <?php } ?>
                        <?php if(isset($information_tags)) { ?>
                          <div class="form-group">
                            <label class="col-sm-2 control-label" for="input-tag"><span>Nhập tag</label>
                            <div class="col-sm-10">
                              <input type="text" name="tag" value="" placeholder="Nhập tag" id="input-tag" class="form-control" />
                              <div id="information-tags" class="well well-sm" style="height: 150px; overflow: auto;">
                                <?php foreach ($information_tags as $information_tag) { ?>
                                <div id="information_tags<?php echo $information_tag['tag_id']; ?>"><i class="fa fa-minus-circle"></i> <?php echo $information_tag['name']; ?>
                                  <input type="hidden" name="information_tags[]" value="<?php echo $prefix_tag.$information_tag['tag_id']; ?>" />
                                </div>
                                <?php } ?>
                              </div>
                            </div>
                          </div>
                        <?php } ?>
                        <?php if(!empty($meta_contents['tab_data'])) { ?>
                          <?php echo $meta_contents['tab_data']; ?>
                        <?php } ?>
                      </div>
                    </div>
                </div>
              </div>
          </div>
          <div class="col-md-3">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-inbox"></i> Thông tin</h3>
                </div>
                <div class="panel-body">
                      <div class="form-group">
                        <label class="col-sm-12"><?php echo $tab_design; ?></label>
                        <div class="col-md-12">
                          <div class="layout">
                              <select name="information_layout[0]" class="form-control">
                                <option value=""><?php echo $entry_layout; ?></option>
                                <?php foreach ($layouts as $layout) { ?>
                                <?php if (isset($information_layout[0]) && $information_layout[0] == $layout['layout_id']) { ?>
                                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                              </select>
                          </div>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-sm-12"><?php echo $entry_sort_order; ?></label>
                        <div class="col-md-12">
                          <input type="text" name="sort_order" value="<?php echo $sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
                        </div>
                      </div>
                      <div class="form-group">
                          <label class="col-sm-12"><?php echo $entry_status; ?></label>
                          <div class="col-md-12">
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
              </div>
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-inbox"></i> Thông tin phương tiện</h3>
                  <button type="button" onclick="addImage();" title="" class="add-image pull-right">Thêm ảnh [+]</button>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <div class="img-main col-md-4">
                          <a href="" style="border:3px solid #27c2f0" id="thumb-image" data-toggle="image" class="img-thumbnail">
                            <img width="100%" class="img-resposive" src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                          </a>
                          <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
                        </div>
                        <div id="img-list" class="col-md-8">
                          <div class="img">
                            <?php $image_row = 0; ?>
                            <?php if($information_images) { ?>
                            <?php foreach($information_images as $key=>$item){ ?>
                            <div class="item-image" id="item-<?php echo $key; ?>">
                              <a href="" style="border: 3px solid #e4e4e4" id="thumb-image<?php echo $key; ?>" data-toggle="image" class="img-thumbnail">
                                <img width="100%" src="<?php echo $item['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                              </a>
                              <input type="hidden" name="information_images[<?php echo $key; ?>]" value="<?php echo $item['image']; ?>" id="input-image<?php echo $key; ?>" />
                              <button type="button" onclick="$('#item-<?php echo $key; ?>').remove();" data-toggle="tooltip" title="Xóa" class="remove-imge"><i class="fa fa-minus-circle"></i></button>
                            </div>
                            <?php $image_row ++;  } ?>
                            <?php } ?>
                          </div>
                        </div>
                    </div>
                    <!-- Add meta data at position -->
                    <?php if(!empty($meta_contents['block_media'])) { ?>
                        <?php echo $meta_contents['block_media']; ?>
                    <?php } ?>
                </div>
              </div>
            </div>
        </div>
      </form>
  </div>
  <script type="text/javascript">
<?php foreach ($languages as $language) { ?>
          var option_tinymce = {
              selector: '#input-description<?php echo $language['language_id']; ?>',
              language:'<?php global $registry;  echo $registry->get("language")->get('code');  ?>',
              /*skin: 'light',*/
              height:500,
              app_default: 'cdv',
              relative_urls: false,
              remove_script_host: false,
              document_base_url : "<?php echo HTTP_CATALOG; ?>",
              plugin_url : "<?php echo HTTP_SERVER; ?>view/javascript/tinymce/plugins/",
              plugins: [
                  "imagetools linktarget advlist textcolor colorpicker autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
                  "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
                  "save table contextmenu directionality emoticons template textcolor paste codesample example header"
              ],
              setup: function(ed) {
                  ed.addContextToolbar('a', 'link unlink');
              },
              toolbar1: "undo redo imagetools newdocument cut copy paste pastetext searchreplace print ltr rtl spellchecker visualchars visualblocks nonbreaking code preview fullscreen",
              toolbar2: "bullist numlist outdent indent blockquote link unlink imagetools example media table anchor removeformat insertdatetime hr  charmap emoticons template pagebreak restoredraft codesample",
              toolbar3: "bold italic underline strikethrough subscript superscript forecolor backcolor alignleft aligncenter alignright alignjustify header fontselect fontsizeselect",
              fontsize_formats: '8pt 9pt 10pt 11pt 12pt 13pt 14pt 16pt 18pt 20pt 22pt 24pt 26pt 28pt 36pt 48pt 72pt',
              document_app: "<?php echo DIR_APPLICATION; ?>",
              verify_html: false,
              forced_root_block : "p",
          }

          $('#input-description<?php echo $language['language_id']; ?>').before('<div id="myGrid<?php echo $language['language_id']; ?>"></div>');
          var id<?php echo $language['language_id']; ?> = "input-description<?php echo $language['language_id']; ?>";
          $('#myGrid<?php echo $language['language_id']; ?>').gridEditor({
              source_textarea: '#input-description<?php echo $language['language_id']; ?>',
              option_tinymce: option_tinymce,
          });

          $('#input-description<?php echo $language['language_id']; ?>').addClass('editor_chili');
          $('input[name="information_description[<?php echo $language["language_id"]; ?>][title]"]').keyup(function () {
              $('input[name="information_description[<?php echo $language["language_id"]; ?>][meta_title]"]').val($(this).val());
          });
<?php } ?>
</script>
<script type="text/javascript">

    var image_row = <?php echo $image_row; ?>;
    function addImage() {
      html  = '<div class="item-image" id="item-' + image_row + '">';
        html  += '<a href="" style="border: 1px solid #e4e4e4" id="thumb-image' + image_row + '" data-toggle="image" class="img-thumbnail">';
          html  += '<img width="100%" src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />';
        html  += '</a>';
        html  += '<input type="hidden" name="information_images[' + image_row + ']" value="" id="input-image' + image_row + '" />';
        html  += '<button type="button" onclick="$(\'#item-' + image_row + '\').remove();" data-toggle="tooltip" title="Xóa" class="remove-imge"><i class="fa fa-minus-circle"></i></button>';
      html  += '</div>';

      $('#img-list .img').append(html);

      image_row++;
    }
    <?php if(isset($information_tags)) { ?>
    // Tag
    $('input[name=\'tag\']').autocomplete({
      'source': function(request, response) {
        $.ajax({
          url: '<?php echo $tag_autocomplete;  ?>',
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

        $('#information-tags' + item['value']).remove();

        $('#information-tags').append('<div id="information-tags' + item['value'] + '"><i class="fa fa-minus-circle"></i> ' + item['label'] + '<input type="hidden" name="information_tags[]" value="<?php echo $prefix_tag; ?>' + item['value'] + '" /></div>');
      }
    });
    $('#information-tags').delegate('.fa-minus-circle', 'click', function() {
      $(this).parent().remove();
    });
    <?php } ?>
  </script>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<style type="text/css">
  .img-thumbnail{width: 100px; height: 100px;}
  .item-image{ position: relative; display: inline-block; margin-right: 5px; }
  .item-image .remove-imge{ position: absolute; right:0; top: 0;  background-color: red; border: 0px; color: #fff; }
  .add-image,.add-image:focus{
      font-size: 14px;
      background-color: transparent;
      border: 0px;
      color: #ffffff;
      outline: 0px;
      background-color: #7399a5;
      padding: 3px 10px;
      border-radius: 30px;
  }
  fieldset{
    margin-top: 20px;
  }
  legend{
    font-size: 16px;
    cursor: pointer;
    padding: 10px 0 10px 25px;
    position: relative;
  }
  legend:before{
    content: "+";
    position: absolute;
    left: 0px;
    top: 10px;
    padding: 1px 5px;
    color: #fff;
    background-color: #1e91cf;
  }
</style>
<?php echo $footer; ?>