<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
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
    <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_layout; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-puzzle-piece"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-module" class="form-horizontal">
          <div class="list-module">
            <?php if ($extensions) { ?>
            <?php foreach ($extensions as $key =>$extension) { ?>
                  <div class="col-md-4">
                    <div class="inner-list-module">
                      <div class="module-main">
                          <div class="title">
                            <img class="pull-left" src="https://propzy.atlassian.net/secure/projectavatar?avatarId=10324" width="50px;">
                            <div class="pull-left" style="margin-left: 10px; margin-top: 10px">
                              <?php echo $extension['name']; ?>
                              <?php if (!empty($extension['module'])) { ?><br>
                              <i style="font-weight: 300"><span class="badge"><?php echo count($extension['module']); ?></span> Thể hiện</i>
                              <i class="show-child fa fa-chevron-down" data-toggle="collapse" data-target="#show-child<?php echo $key; ?>"></i>
                              <?php } ?>
                            </div>
                            <div class="clearfix"></div>
                          </div>
                          <div class="action-module text-right">
                            <?php if ($extension['installed']) { ?>
                            <a href="<?php echo $extension['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> Thêm</a>
                            <?php } ?>
                            <?php if (!$extension['installed']) { ?>
                            <a href="<?php echo $extension['install']; ?>" data-toggle="tooltip" title="<?php echo $button_install; ?>" class="btn btn-success"><i class="fa fa-plus-circle"></i> Cài</a>
                            <?php } else { ?>
                              <a onclick="confirm('<?php echo $text_confirm; ?>') ? location.href='<?php echo $extension['uninstall']; ?>' : false;" data-toggle="tooltip" title="<?php echo $button_uninstall; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i> Gỡ</a>
                            <?php } ?>

                          </div>
                          <?php echo $extension['des']; ?>
                        </div>
                        <?php if (!empty($extension['module'])) { ?>
                        <div id="show-child<?php echo $key; ?>" class="list-chil-module collapse">
                          <?php foreach ($extension['module'] as $module) { ?>
                          <div class="child-module">
                            <div class="text-left"><?php echo $module['name']; ?></div>
                            <div class="action-module">
                              <a href="<?php echo $module['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
                              <a onclick="confirm('<?php echo $text_confirm; ?>') ? location.href='<?php echo $module['delete']; ?>' : false;" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a>
                            </div>
                          </div>
                          <?php } ?>
                        </div>
                        <?php } ?>

                    </div>
                  </div>
            <?php } ?>
            <?php } else { ?>
            <div>
              <div class="text-center" colspan="2"><?php echo $text_no_results; ?></div>
            </div>
            <?php } ?>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>
