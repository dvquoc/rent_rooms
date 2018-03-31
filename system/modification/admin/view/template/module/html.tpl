<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
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
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
            <div class="col-sm-10">
              <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
              <?php if ($error_name) { ?>
              <div class="text-danger"><?php echo $error_name; ?></div>
              <?php } ?>
            </div>
          </div>         
          <div class="tab-pane">
            <ul class="nav nav-tabs" id="language">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
            <div class="tab-content">
              <?php foreach ($languages as $language) { ?>
              <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-title<?php echo $language['language_id']; ?>"><?php echo $entry_title; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="module_description[<?php echo $language['language_id']; ?>][title]" placeholder="<?php echo $entry_title; ?>" id="input-heading<?php echo $language['language_id']; ?>" value="<?php echo isset($module_description[$language['language_id']]['title']) ? $module_description[$language['language_id']]['title'] : ''; ?>" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                  <div class="col-sm-10">
                    <textarea name="module_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($module_description[$language['language_id']]['description']) ? $module_description[$language['language_id']]['description'] : ''; ?></textarea>
                  </div>
                </div>
              </div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
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
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
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
					  "imagetools advlist textcolor colorpicker autolink autosave link image lists charmap print preview hr anchor pagebreak spellchecker",
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
<?php } ?>
//--></script> 
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<?php echo $footer; ?>