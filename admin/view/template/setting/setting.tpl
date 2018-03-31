<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-setting" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-setting" class="form-horizontal">
          <div class="row">
            <div class="col-md-7">
              <ul class="nav nav-tabs">
                <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
                <li><a href="#tab-store" data-toggle="tab"><?php echo $tab_store; ?></a></li>
                <li><a href="#tab-local" data-toggle="tab"><?php echo $tab_local; ?></a></li>
                <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
                <li><a href="#tab-ftp" data-toggle="tab"><?php echo $tab_ftp; ?></a></li>
                <li><a href="#tab-mail" data-toggle="tab"><?php echo $tab_mail; ?></a></li>
                <li><a href="#tab-server" data-toggle="tab"><?php echo $tab_server; ?></a></li>
                <li><a href="#tab-google" data-toggle="tab"><?php echo $tab_google; ?></a></li>
              </ul>
              <div class="tab-content">
              <div class="tab-pane active" id="tab-general">
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_name" value="<?php echo $config_name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name" class="form-control" />
                    <?php if ($error_name) { ?>
                    <div class="text-danger"><?php echo $error_name; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-owner"><?php echo $entry_owner; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_owner" value="<?php echo $config_owner; ?>" placeholder="<?php echo $entry_owner; ?>" id="input-owner" class="form-control" />
                    <?php if ($error_owner) { ?>
                    <div class="text-danger"><?php echo $error_owner; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-address"><?php echo $entry_address; ?></label>
                  <div class="col-sm-10">
                    <textarea name="config_address" placeholder="<?php echo $entry_address; ?>" rows="5" id="input-address" class="form-control"><?php echo $config_address; ?></textarea>
                    <?php if ($error_address) { ?>
                    <div class="text-danger"><?php echo $error_address; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-geocode"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_geocode; ?>"><?php echo $entry_geocode; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_geocode" value="<?php echo $config_geocode; ?>" placeholder="<?php echo $entry_geocode; ?>" id="input-geocode" class="form-control" />
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-email"><?php echo $entry_email; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_email" value="<?php echo $config_email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="form-control" />
                    <?php if ($error_email) { ?>
                    <div class="text-danger"><?php echo $error_email; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-telephone"><?php echo $entry_telephone; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_telephone" value="<?php echo $config_telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="form-control" />
                    <?php if ($error_telephone) { ?>
                    <div class="text-danger"><?php echo $error_telephone; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-fax"><?php echo $entry_fax; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_fax" value="<?php echo $config_fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-image"><?php echo $entry_image; ?></label>
                  <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                    <input type="hidden" name="config_image" value="<?php echo $config_image; ?>" id="input-image" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-open"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_open; ?>"><?php echo $entry_open; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="config_open" rows="5" placeholder="<?php echo $entry_open; ?>" id="input-open" class="form-control"><?php echo $config_open; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-comment"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_comment; ?>"><?php echo $entry_comment; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="config_comment" rows="5" placeholder="<?php echo $entry_comment; ?>" id="input-comment" class="form-control"><?php echo $config_comment; ?></textarea>
                  </div>
                </div>
                <?php if ($locations) { ?>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" data-container="#tab-general" title="<?php echo $help_location; ?>"><?php echo $entry_location; ?></span></label>
                  <div class="col-sm-10">
                    <?php foreach ($locations as $location) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($location['location_id'], $config_location)) { ?>
                        <input type="checkbox" name="config_location[]" value="<?php echo $location['location_id']; ?>" checked="checked" />
                        <?php echo $location['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="config_location[]" value="<?php echo $location['location_id']; ?>" />
                        <?php echo $location['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
                <?php } ?>
              </div>
              <div class="tab-pane" id="tab-store">
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-meta-title"><?php echo $entry_meta_title; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_meta_title" value="<?php echo $config_meta_title; ?>" placeholder="<?php echo $entry_meta_title; ?>" id="input-meta-title" class="form-control" />
                    <?php if ($error_meta_title) { ?>
                    <div class="text-danger"><?php echo $error_meta_title; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-meta-description"><?php echo $entry_meta_description; ?></label>
                  <div class="col-sm-10">
                    <textarea name="config_meta_description" rows="5" placeholder="<?php echo $entry_meta_description; ?>" id="input-meta-description" class="form-control"><?php echo $config_meta_description; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-meta-keyword"><?php echo $entry_meta_keyword; ?></label>
                  <div class="col-sm-10">
                    <textarea name="config_meta_keyword" rows="5" placeholder="<?php echo $entry_meta_keyword; ?>" id="input-meta-keyword" class="form-control"><?php echo $config_meta_keyword; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-layout"><?php echo $entry_layout; ?></label>
                  <div class="col-sm-10">
                    <select name="config_layout_id" id="input-layout" class="form-control">
                      <?php foreach ($layouts as $layout) { ?>
                      <?php if ($layout['layout_id'] == $config_layout_id) { ?>
                      <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="tab-local">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-language"><?php echo $entry_language; ?></label>
                  <div class="col-sm-10">
                    <select name="config_language" id="input-language" class="form-control">
                      <?php foreach ($languages as $language) { ?>
                      <?php if ($language['code'] == $config_language) { ?>
                      <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-admin-language"><?php echo $entry_admin_language; ?></label>
                  <div class="col-sm-10">
                    <select name="config_admin_language" id="input-admin-language" class="form-control">
                      <?php foreach ($languages as $language) { ?>
                      <?php if ($language['code'] == $config_admin_language) { ?>
                      <option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="tab-option">
                <fieldset>
                  <legend><?php echo $text_product; ?></legend>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-catalog-limit"><span data-toggle="tooltip" title="<?php echo $help_product_limit; ?>"><?php echo $entry_product_limit; ?></span></label>
                    <div class="col-sm-10">
                      <input type="text" name="config_product_limit" value="<?php echo $config_product_limit; ?>" placeholder="<?php echo $entry_product_limit; ?>" id="input-catalog-limit" class="form-control" />
                      <?php if ($error_product_limit) { ?>
                      <div class="text-danger"><?php echo $error_product_limit; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-list-description-limit"><span data-toggle="tooltip" title="<?php echo $help_product_description_length; ?>"><?php echo $entry_product_description_length; ?></span></label>
                    <div class="col-sm-10">
                      <input type="text" name="config_product_description_length" value="<?php echo $config_product_description_length; ?>" placeholder="<?php echo $entry_product_description_length; ?>" id="input-list-description-limit" class="form-control" />
                      <?php if ($error_product_description_length) { ?>
                      <div class="text-danger"><?php echo $error_product_description_length; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-admin-limit"><span data-toggle="tooltip" title="<?php echo $help_limit_admin; ?>"><?php echo $entry_limit_admin; ?></span></label>
                    <div class="col-sm-10">
                      <input type="text" name="config_limit_admin" value="<?php echo $config_limit_admin; ?>" placeholder="<?php echo $entry_limit_admin; ?>" id="input-admin-limit" class="form-control" />
                      <?php if ($error_limit_admin) { ?>
                      <div class="text-danger"><?php echo $error_limit_admin; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                </fieldset>
                <fieldset>
                  <legend><?php echo $text_review; ?></legend>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_review; ?>"><?php echo $entry_review; ?></span></label>
                    <div class="col-sm-10">
                      <label class="radio-inline">
                        <?php if ($config_review_status) { ?>
                        <input type="radio" name="config_review_status" value="1" checked="checked" />
                        <?php echo $text_yes; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_review_status" value="1" />
                        <?php echo $text_yes; ?>
                        <?php } ?>
                      </label>
                      <label class="radio-inline">
                        <?php if (!$config_review_status) { ?>
                        <input type="radio" name="config_review_status" value="0" checked="checked" />
                        <?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_review_status" value="0" />
                        <?php echo $text_no; ?>
                        <?php } ?>
                      </label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_review_guest; ?>"><?php echo $entry_review_guest; ?></span></label>
                    <div class="col-sm-10">
                      <label class="radio-inline">
                        <?php if ($config_review_guest) { ?>
                        <input type="radio" name="config_review_guest" value="1" checked="checked" />
                        <?php echo $text_yes; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_review_guest" value="1" />
                        <?php echo $text_yes; ?>
                        <?php } ?>
                      </label>
                      <label class="radio-inline">
                        <?php if (!$config_review_guest) { ?>
                        <input type="radio" name="config_review_guest" value="0" checked="checked" />
                        <?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_review_guest" value="0" />
                        <?php echo $text_no; ?>
                        <?php } ?>
                      </label>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_review_mail; ?>"><?php echo $entry_review_mail; ?></span></label>
                    <div class="col-sm-10">
                      <label class="radio-inline">
                        <?php if ($config_review_mail) { ?>
                        <input type="radio" name="config_review_mail" value="1" checked="checked" />
                        <?php echo $text_yes; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_review_mail" value="1" />
                        <?php echo $text_yes; ?>
                        <?php } ?>
                      </label>
                      <label class="radio-inline">
                        <?php if (!$config_review_mail) { ?>
                        <input type="radio" name="config_review_mail" value="0" checked="checked" />
                        <?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_review_mail" value="0" />
                        <?php echo $text_no; ?>
                        <?php } ?>
                      </label>
                    </div>
                  </div>
                </fieldset>


                <fieldset>
                  <legend><?php echo $text_account; ?></legend>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-login-attempts"><span data-toggle="tooltip" title="<?php echo $help_login_attempts; ?>"><?php echo $entry_login_attempts; ?></span></label>
                    <div class="col-sm-10">
                      <input type="text" name="config_login_attempts" value="<?php echo $config_login_attempts; ?>" placeholder="<?php echo $entry_login_attempts; ?>" id="input-login-attempts" class="form-control" />
                      <?php if ($error_login_attempts) { ?>
                      <div class="text-danger"><?php echo $error_login_attempts; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-account"><span data-toggle="tooltip" title="<?php echo $help_account; ?>"><?php echo $entry_account; ?></span></label>
                    <div class="col-sm-10">
                      <select name="config_account_id" id="input-account" class="form-control">
                        <option value="0"><?php echo $text_none; ?></option>
                        <?php foreach ($informations as $information) { ?>
                        <?php if ($information['information_id'] == $config_account_id) { ?>
                        <option value="<?php echo $information['information_id']; ?>" selected="selected"><?php echo $information['title']; ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $information['information_id']; ?>"><?php echo $information['title']; ?></option>
                        <?php } ?>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_account_mail; ?>"><?php echo $entry_account_mail; ?></span></label>
                    <div class="col-sm-10">
                      <label class="radio-inline">
                        <?php if ($config_account_mail) { ?>
                        <input type="radio" name="config_account_mail" value="1" checked="checked" />
                        <?php echo $text_yes; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_account_mail" value="1" />
                        <?php echo $text_yes; ?>
                        <?php } ?>
                      </label>
                      <label class="radio-inline">
                        <?php if (!$config_account_mail) { ?>
                        <input type="radio" name="config_account_mail" value="0" checked="checked" />
                        <?php echo $text_no; ?>
                        <?php } else { ?>
                        <input type="radio" name="config_account_mail" value="0" />
                        <?php echo $text_no; ?>
                        <?php } ?>
                      </label>
                    </div>
                  </div>
                </fieldset>

              </div>
              <div class="tab-pane" id="tab-ftp">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-ftp-host"><?php echo $entry_ftp_hostname; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_ftp_hostname" value="<?php echo $config_ftp_hostname; ?>" placeholder="<?php echo $entry_ftp_hostname; ?>" id="input-ftp-host" class="form-control" />
                    <?php if ($error_ftp_hostname) { ?>
                    <div class="text-danger"><?php echo $error_ftp_hostname; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-ftp-port"><?php echo $entry_ftp_port; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_ftp_port" value="<?php echo $config_ftp_port; ?>" placeholder="<?php echo $entry_ftp_port; ?>" id="input-ftp-port" class="form-control" />
                    <?php if ($error_ftp_port) { ?>
                    <div class="text-danger"><?php echo $error_ftp_port; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-ftp-username"><?php echo $entry_ftp_username; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_ftp_username" value="<?php echo $config_ftp_username; ?>" placeholder="<?php echo $entry_ftp_username; ?>" id="input-ftp-username" class="form-control" />
                    <?php if ($error_ftp_username) { ?>
                    <div class="text-danger"><?php echo $error_ftp_username; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-ftp-password"><?php echo $entry_ftp_password; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_ftp_password" value="<?php echo $config_ftp_password; ?>" placeholder="<?php echo $entry_ftp_password; ?>" id="input-ftp-password" class="form-control" />
                    <?php if ($error_ftp_password) { ?>
                    <div class="text-danger"><?php echo $error_ftp_password; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-ftp-root"><span data-toggle="tooltip" data-html="true" title="<?php echo htmlspecialchars($help_ftp_root); ?>"><?php echo $entry_ftp_root; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_ftp_root" value="<?php echo $config_ftp_root; ?>" placeholder="<?php echo $entry_ftp_root; ?>" id="input-ftp-root" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_ftp_status; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_ftp_status) { ?>
                      <input type="radio" name="config_ftp_status" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_ftp_status" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_ftp_status) { ?>
                      <input type="radio" name="config_ftp_status" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_ftp_status" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="tab-mail">
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-protocol"><span data-toggle="tooltip" title="<?php echo $help_mail_protocol; ?>"><?php echo $entry_mail_protocol; ?></span></label>
                  <div class="col-sm-10">
                    <select name="config_mail_protocol" id="input-mail-protocol" class="form-control">
                      <?php if ($config_mail_protocol == 'mail') { ?>
                      <option value="mail" selected="selected"><?php echo $text_mail; ?></option>
                      <?php } else { ?>
                      <option value="mail"><?php echo $text_mail; ?></option>
                      <?php } ?>
                      <?php if ($config_mail_protocol == 'smtp') { ?>
                      <option value="smtp" selected="selected"><?php echo $text_smtp; ?></option>
                      <?php } else { ?>
                      <option value="smtp"><?php echo $text_smtp; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-parameter"><span data-toggle="tooltip" title="<?php echo $help_mail_parameter; ?>"><?php echo $entry_mail_parameter; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_mail_parameter" value="<?php echo $config_mail_parameter; ?>" placeholder="<?php echo $entry_mail_parameter; ?>" id="input-mail-parameter" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-smtp-hostname"><span data-toggle="tooltip" title="<?php echo $help_mail_smtp_hostname; ?>"><?php echo $entry_mail_smtp_hostname; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_mail_smtp_hostname" value="<?php echo $config_mail_smtp_hostname; ?>" placeholder="<?php echo $entry_mail_smtp_hostname; ?>" id="input-mail-smtp-hostname" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-smtp-username"><?php echo $entry_mail_smtp_username; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_mail_smtp_username" value="<?php echo $config_mail_smtp_username; ?>" placeholder="<?php echo $entry_mail_smtp_username; ?>" id="input-mail-smtp-username" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-smtp-password"><?php echo $entry_mail_smtp_password; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_mail_smtp_password" value="<?php echo $config_mail_smtp_password; ?>" placeholder="<?php echo $entry_mail_smtp_password; ?>" id="input-mail-smtp-password" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-smtp-port"><?php echo $entry_mail_smtp_port; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_mail_smtp_port" value="<?php echo $config_mail_smtp_port; ?>" placeholder="<?php echo $entry_mail_smtp_port; ?>" id="input-mail-smtp-port" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-mail-smtp-timeout"><?php echo $entry_mail_smtp_timeout; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_mail_smtp_timeout" value="<?php echo $config_mail_smtp_timeout; ?>" placeholder="<?php echo $entry_mail_smtp_timeout; ?>" id="input-mail-smtp-timeout" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-alert-email"><span data-toggle="tooltip" title="<?php echo $help_mail_alert; ?>"><?php echo $entry_mail_alert; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="config_mail_alert" rows="5" placeholder="<?php echo $entry_mail_alert; ?>" id="input-alert-email" class="form-control"><?php echo $config_mail_alert; ?></textarea>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="tab-server">
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_secure; ?>"><?php echo $entry_secure; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_secure) { ?>
                      <input type="radio" name="config_secure" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_secure" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_secure) { ?>
                      <input type="radio" name="config_secure" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_secure" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_shared; ?>"><?php echo $entry_shared; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_shared) { ?>
                      <input type="radio" name="config_shared" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_shared" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_shared) { ?>
                      <input type="radio" name="config_shared" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_shared" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-robots"><span data-toggle="tooltip" title="<?php echo $help_robots; ?>"><?php echo $entry_robots; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="config_robots" rows="5" placeholder="<?php echo $entry_robots; ?>" id="input-robots" class="form-control"><?php echo $config_robots; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_seo_url; ?>"><?php echo $entry_seo_url; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_seo_url) { ?>
                      <input type="radio" name="config_seo_url" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_seo_url" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_seo_url) { ?>
                      <input type="radio" name="config_seo_url" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_seo_url" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-file-max-size"><span data-toggle="tooltip" title="<?php echo $help_file_max_size; ?>"><?php echo $entry_file_max_size; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_file_max_size" value="<?php echo $config_file_max_size; ?>" placeholder="<?php echo $entry_file_max_size; ?>" id="input-file-max-size" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-file-ext-allowed"><span data-toggle="tooltip" title="<?php echo $help_file_ext_allowed; ?>"><?php echo $entry_file_ext_allowed; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="config_file_ext_allowed" rows="5" placeholder="<?php echo $entry_file_ext_allowed; ?>" id="input-file-ext-allowed" class="form-control"><?php echo $config_file_ext_allowed; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-file-mime-allowed"><span data-toggle="tooltip" title="<?php echo $help_file_mime_allowed; ?>"><?php echo $entry_file_mime_allowed; ?></span></label>
                  <div class="col-sm-10">
                    <textarea name="config_file_mime_allowed" cols="60" rows="5" placeholder="<?php echo $entry_file_mime_allowed; ?>" id="input-file-mime-allowed" class="form-control"><?php echo $config_file_mime_allowed; ?></textarea>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_maintenance; ?>"><?php echo $entry_maintenance; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_maintenance) { ?>
                      <input type="radio" name="config_maintenance" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_maintenance" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_maintenance) { ?>
                      <input type="radio" name="config_maintenance" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_maintenance" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="<?php echo $help_password; ?>"><?php echo $entry_password; ?></span></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_password) { ?>
                      <input type="radio" name="config_password" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_password" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_password) { ?>
                      <input type="radio" name="config_password" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_password" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-encryption"><span data-toggle="tooltip" title="<?php echo $help_encryption; ?>"><?php echo $entry_encryption; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_encryption" value="<?php echo $config_encryption; ?>" placeholder="<?php echo $entry_encryption; ?>" id="input-encryption" class="form-control" />
                    <?php if ($error_encryption) { ?>
                    <div class="text-danger"><?php echo $error_encryption; ?></div>
                    <?php } ?>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label" for="input-compression"><span data-toggle="tooltip" title="<?php echo $help_compression; ?>"><?php echo $entry_compression; ?></span></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_compression" value="<?php echo $config_compression; ?>" placeholder="<?php echo $entry_compression; ?>" id="input-compression" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_error_display; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_error_display) { ?>
                      <input type="radio" name="config_error_display" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_error_display" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_error_display) { ?>
                      <input type="radio" name="config_error_display" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_error_display" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label"><?php echo $entry_error_log; ?></label>
                  <div class="col-sm-10">
                    <label class="radio-inline">
                      <?php if ($config_error_log) { ?>
                      <input type="radio" name="config_error_log" value="1" checked="checked" />
                      <?php echo $text_yes; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_error_log" value="1" />
                      <?php echo $text_yes; ?>
                      <?php } ?>
                    </label>
                    <label class="radio-inline">
                      <?php if (!$config_error_log) { ?>
                      <input type="radio" name="config_error_log" value="0" checked="checked" />
                      <?php echo $text_no; ?>
                      <?php } else { ?>
                      <input type="radio" name="config_error_log" value="0" />
                      <?php echo $text_no; ?>
                      <?php } ?>
                    </label>
                  </div>
                </div>
                <div class="form-group required">
                  <label class="col-sm-2 control-label" for="input-error-filename"><?php echo $entry_error_filename; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="config_error_filename" value="<?php echo $config_error_filename; ?>" placeholder="<?php echo $entry_error_filename; ?>" id="input-error-filename" class="form-control" />
                    <?php if ($error_error_filename) { ?>
                    <div class="text-danger"><?php echo $error_error_filename; ?></div>
                    <?php } ?>
                  </div>
                </div>
              </div>
              <div class="tab-pane" id="tab-google">
                <fieldset>
                  <legend><?php echo $text_google_analytics; ?></legend>
                  <div class="alert alert-info"><?php echo $help_google_analytics; ?></div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-google-analytics"><?php echo $entry_google_analytics; ?></label>
                    <div class="col-sm-10">
                      <textarea name="config_google_analytics" rows="5" placeholder="<?php echo $entry_google_analytics; ?>" id="input-google-analytics" class="form-control"><?php echo $config_google_analytics; ?></textarea>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-google-analytics-status"><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="config_google_analytics_status" id="input-google-analytics-status" class="form-control">
                        <?php if ($config_google_analytics_status) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </fieldset>
                <fieldset>
                  <legend><?php echo $text_google_captcha; ?></legend>
                  <div class="alert alert-info"><?php echo $help_google_captcha; ?></div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-google-captcha-public"><?php echo $entry_google_captcha_public; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="config_google_captcha_public" value="<?php echo $config_google_captcha_public; ?>" placeholder="<?php echo $entry_google_captcha_public; ?>" id="input-google-captcha-public" class="form-control" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-google-captcha-secret"><?php echo $entry_google_captcha_secret; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="config_google_captcha_secret" value="<?php echo $config_google_captcha_secret; ?>" placeholder="<?php echo $entry_google_captcha_secret; ?>" id="input-google-captcha-secret" class="form-control" />
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-google-captcha-status"><?php echo $entry_status; ?></label>
                    <div class="col-sm-10">
                      <select name="config_google_captcha_status" id="input-google-captcha-status" class="form-control">
                        <?php if ($config_google_captcha_status) { ?>
                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                        <option value="0"><?php echo $text_disabled; ?></option>
                        <?php } else { ?>
                        <option value="1"><?php echo $text_enabled; ?></option>
                        <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </fieldset>
              </div>
            </div>
            </div>
            <div class="col-md-5">
              <ul class="nav nav-tabs">
                <li class="active"><a href="javascript:;"><?php echo $entry_template; ?></a></li>
              </ul>
              <div class="form-group">
                <div class="col-sm-12">
                  <select name="config_template" id="input-template" class="form-control">
                    <?php foreach ($templates as $template) { ?>
                    <?php if ($template == $config_template) { ?>
                    <option value="<?php echo $template; ?>" selected="selected"><?php echo $template; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $template; ?>"><?php echo $template; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                  <br />
                  <img src="" alt="" id="template" class="img-thumbnail" />
                </div>
              </div>
              <ul class="nav nav-tabs">
                <li class="active"><a href="javascript:;"><?php echo $tab_image; ?></a></li>
              </ul>
              <div class="form-group">
                <div class="col-sm-12">
                  <div class="form-group">
                    <div class="col-md-6">
                      <div class="item"><a href="" id="thumb-logo" data-toggle="image" class="img-thumbnail"><img src="<?php echo $logo; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                        <input type="hidden" name="config_logo" value="<?php echo $config_logo; ?>" id="input-logo" />
                      </div>
                      <label class="item" for="input-logo"><?php echo $entry_logo; ?></label>
                    </div>
                    <div class="col-md-6">
                      <div class="item"><a href="" id="thumb-icon" data-toggle="image" class="img-thumbnail"><img src="<?php echo $icon; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                        <input type="hidden" name="config_icon" value="<?php echo $config_icon; ?>" id="input-icon" />
                      </div>
                      <label class="item" for="input-icon"><?php echo $entry_icon; ?></label>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-category-width"><?php echo $entry_image_category; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_category_width" value="<?php echo $config_image_category_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-category-width" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_category_height" value="<?php echo $config_image_category_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_category) { ?>
                      <div class="text-danger"><?php echo $error_image_category; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-thumb-width"><?php echo $entry_image_thumb; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_thumb_width" value="<?php echo $config_image_thumb_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-thumb-width" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_thumb_height" value="<?php echo $config_image_thumb_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_thumb) { ?>
                      <div class="text-danger"><?php echo $error_image_thumb; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-popup-width"><?php echo $entry_image_popup; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_popup_width" value="<?php echo $config_image_popup_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-popup-width" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_popup_height" value="<?php echo $config_image_popup_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_popup) { ?>
                      <div class="text-danger"><?php echo $error_image_popup; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-product-width"><?php echo $entry_image_product; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_product_width" value="<?php echo $config_image_product_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-product-width" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_product_height" value="<?php echo $config_image_product_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_product) { ?>
                      <div class="text-danger"><?php echo $error_image_product; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-additional-width"><?php echo $entry_image_additional; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_additional_width" value="<?php echo $config_image_additional_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-additional-width" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_additional_height" value="<?php echo $config_image_additional_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_additional) { ?>
                      <div class="text-danger"><?php echo $error_image_additional; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-related"><?php echo $entry_image_related; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_related_width" value="<?php echo $config_image_related_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-related" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_related_height" value="<?php echo $config_image_related_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_related) { ?>
                      <div class="text-danger"><?php echo $error_image_related; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-compare"><?php echo $entry_image_compare; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_compare_width" value="<?php echo $config_image_compare_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-compare" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_compare_height" value="<?php echo $config_image_compare_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_compare) { ?>
                      <div class="text-danger"><?php echo $error_image_compare; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-wishlist"><?php echo $entry_image_wishlist; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_wishlist_width" value="<?php echo $config_image_wishlist_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-wishlist" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_wishlist_height" value="<?php echo $config_image_wishlist_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_wishlist) { ?>
                      <div class="text-danger"><?php echo $error_image_wishlist; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-cart"><?php echo $entry_image_cart; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_cart_width" value="<?php echo $config_image_cart_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-cart" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_cart_height" value="<?php echo $config_image_cart_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_cart) { ?>
                      <div class="text-danger"><?php echo $error_image_cart; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group required">
                    <label class="col-sm-12" for="input-image-location"><?php echo $entry_image_location; ?></label>
                    <div class="col-sm-12">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="config_image_location_width" value="<?php echo $config_image_location_width; ?>" placeholder="<?php echo $entry_width; ?>" id="input-image-location" class="form-control" />
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="config_image_location_height" value="<?php echo $config_image_location_height; ?>" placeholder="<?php echo $entry_height; ?>" class="form-control" />
                        </div>
                      </div>
                      <?php if ($error_image_location) { ?>
                      <div class="text-danger"><?php echo $error_image_location; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
$('select[name=\'config_template\']').on('change', function() {
	$.ajax({
		url: 'index.php?route=setting/setting/template&token=<?php echo $token; ?>&template=' + encodeURIComponent(this.value),
		dataType: 'html',
		beforeSend: function() {
			$('select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
		},
		complete: function() {
			$('.fa-spin').remove();
		},
		success: function(html) {
			$('#template').attr('src', html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'config_template\']').trigger('change');
//--></script> 
</div>
<?php echo $footer; ?>