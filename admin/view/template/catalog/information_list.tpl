
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right"><a href="<?php echo $add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> <?php echo $button_add; ?></a>
        <button type="button" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-information').submit() : false;"><i class="fa fa-trash-o"></i> <?php echo $button_delete; ?></button>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>

    <div class="well" style="position: relative">
        <div class="row">
          <div class="col-md-12">
            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> Tìm kiếm</button>
          </div>
            <?php $class='col-md-12'; if(!empty($categories)) $class='col-md-6'; ?>
            <div class="<?php echo $class; ?>">
              <div class="form-group">
                <label class="control-label" for="input-status">Tên</label>
                <input type="text" name="filter_name" value="<?php echo $filter_name; ?>" placeholder="Tìm theo tên" id="input-name" class="form-control" />
              </div>
            </div>
          <?php if(isset($categories)) { ?>
            <div class="<?php echo $class; ?>">
              <div class="form-group">
                <label class="control-label" for="input-status">Chọn danh mục</label>
                <select name="filter_category_id" id="input-status" class="form-control">
                    <option value="0">---- Chọn danh mục ----</option>
                    <?php foreach($categories as $key=>$category) { ?>
                        <?php if($category['category_id']==$filter_category_id) { ?>
                        <option selected="selected" value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                        <?php }else { ?>
                        <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                        <?php } ?>
                    <?php } ?>
                </select>
                </div>
            </div>
            <?php } ?>

        </div>
    </div>

    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-information">
          <div class="table-responsive">
            <table class="table table-hover">
              <thead>
                <tr>
                  <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                  <td style="width: 100px;" class="text-center"><?php echo "Hình ảnh"; ?></td>
                  <td class="text-left"><?php if ($sort == 'id.title') { ?>
                    <a href="<?php echo $sort_title; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_title; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_title; ?>"><?php echo $column_title; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php if ($sort == 'i.sort_order') { ?>
                    <a href="<?php echo $sort_sort_order; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_sort_order; ?></a>
                    <?php } else { ?>
                    <a href="<?php echo $sort_sort_order; ?>"><?php echo $column_sort_order; ?></a>
                    <?php } ?></td>
                  <td class="text-right"><?php echo $column_action; ?></td>
                </tr>
              </thead>
              <tbody>
                <?php if ($informations) { ?>
                <?php foreach ($informations as $information) { ?>
                <tr>
                  <td class="text-center"><?php if (in_array($information['information_id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $information['information_id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $information['information_id']; ?>" />
                    <?php } ?></td>
                  <td class="text-left"><img src="<?php echo $information['image']; ?>" style="border: 1px solid #ccc;border-radius: 3px;padding: 3px;"></td>
                  <td class="text-left"><?php echo $information['title']; ?></td>
                  <td class="text-right"><?php echo $information['sort_order']; ?></td>
                  <td class="text-right"><a href="<?php echo $information['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                </tr>
                <?php } ?>
                <?php } else { ?>
                <tr>
                  <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
                </tr>
                <?php } ?>
              </tbody>
            </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
  $('#button-filter').on('click', function() {
    var url = '<?php echo $action_fitler ; ?>';

    var filter_name = $('input[name=\'filter_name\']').val();

    if (filter_name) {
      url += '&filter_name=' + encodeURIComponent(filter_name);
    }
    <?php if(isset($categories)) { ?>
      var filter_category_id = $('select[name=\'filter_category_id\']').val();
      if (filter_category_id)
        url += '&filter_category_id=' + encodeURIComponent(filter_category_id);
    <?php } ?>
    location = url;

  });
  //--></script>
<?php echo $footer; ?>