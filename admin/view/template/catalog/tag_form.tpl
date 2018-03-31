<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-stock-status" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <div class="row-custom">
      <div class="panel panel-default col-md-9" >
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-tag" class="form-horizontal">
          <input type="hidden" name="tag_type" value="<?php echo $tag_type; ?>">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-category">Chọn danh mục</label>
            <div class="col-sm-4">
              <select class="tag_category form-control" name="tag_category">
                <option value="0">Chọn danh mục</option>
                <?php foreach ($categories as $category) { ?>
                <?php if($tag_category==$category['category_id']) { ?>
                    <option selected="selected" value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                <?php }else { ?>
                <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select>
            </div>
            <label class="col-sm-2 control-label" for="input-category">Chọn làm nổi bật</label>
            <div class="col-sm-4">
              <?php if($tag_feature==1) { ?>
                <input type="checkbox" checked="checked" name="tag_feature" value="1">
              <?php }else { ?>
                <input type="checkbox" name="tag_feature" value="1">
              <?php } ?>
            </div>
          </div>
          <ul class="nav nav-tabs" id="language">
            <?php foreach ($languages as $language) { ?>
            <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
            <?php } ?>
          </ul>
          <div class="tab-content">
            <?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                    <div class="form-group required">
                      <label class="col-sm-3 control-label text-left"><?php echo $entry_name; ?></label>
                      <div class="col-sm-9">
                          <input type="text" name="tag[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($tag[$language['language_id']]) ? $tag[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_name; ?>" class="form-control" />
                        <?php if (isset($error_name[$language['language_id']])) { ?>
                          <div class="text-danger"><?php echo $error_name[$language['language_id']]; ?></div>
                        <?php } ?>
                      </div>
                    </div>

                  <div class="form-group">
                    <label class="col-sm-3 control-label text-left">Nhập mô tả</label>
                    <div class="col-sm-9">
                      <textarea name="tag[<?php echo $language['language_id']; ?>][description]" placeholder="NHập mô tả" class="form-control"><?php echo isset($tag[$language['language_id']]) ? $tag[$language['language_id']]['description'] : ''; ?></textarea>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-3 control-label text-left">Nhập Meta title</label>
                    <div class="col-sm-9">
                      <input type="text" name="tag[<?php echo $language['language_id']; ?>][meta_title]" value="<?php echo isset($tag[$language['language_id']]) ? $tag[$language['language_id']]['meta_title'] : ''; ?>" placeholder="NHập mô tả" class="form-control" />
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-3 control-label text-left">Nhập Meta Description</label>
                    <div class="col-sm-9">
                      <input type="text" name="tag[<?php echo $language['language_id']; ?>][meta_description]" value="<?php echo isset($tag[$language['language_id']]) ? $tag[$language['language_id']]['meta_description'] : ''; ?>" placeholder="NHập mô tả" class="form-control" />
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-3 control-label text-left">Nhập Meta Keyword</label>
                    <div class="col-sm-9">
                      <input type="text" name="tag[<?php echo $language['language_id']; ?>][meta_keyword]" value="<?php echo isset($tag[$language['language_id']]) ? $tag[$language['language_id']]['meta_keyword'] : ''; ?>" placeholder="NHập mô tả" class="form-control" />
                    </div>
                  </div>

                </div>
            <?php } ?>
          </div>
        </form>
      </div>
    </div>
      <div class="panel panel-default col-md-3">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-tags fa-fw"></i> Hướng dẫn</h3>
        </div>
        <div class="panel-body">
          Đây là phần tag của các website. Phần tab này biều thị website thuộc lĩnh vực nào, Ví dụ <code>Nhà hàng</code>, <code>Xây dựng</code>, <code>Shop quần áo</code>...
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  $('#language a:first').tab('show');
  $('#option a:first').tab('show');
</script>
<?php echo $footer; ?>