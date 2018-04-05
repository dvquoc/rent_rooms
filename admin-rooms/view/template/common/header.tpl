<!DOCTYPE html>
<html dir="ltr" lang="<?php echo $lang; ?>">
<head>
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
<script type="text/javascript" src="view/javascript/jquery/jquery-2.1.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="view/javascript/bootstrap/js/bootstrap-notify.js"></script>
<script src="view/javascript/addgrid/jquery.grideditor.js"></script>
<link href="view/javascript/tinymce_4_7_1_2/tinymce.min.css" type="text/css" rel="stylesheet" />
<script src="view/javascript/tinymce_4_7_1_2/tinymce.min.js"></script>
<script src="view/javascript/tinymce_4_7_1_2/jquery.tinymce.min.js"></script>
<link href="view/javascript/bootstrap/opencart/opencart.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
<link href="view/javascript/summernote/summernote.css" rel="stylesheet" />
<script type="text/javascript" src="view/javascript/summernote/summernote.js"></script>
<script src="view/javascript/jquery/datetimepicker/moment.js" type="text/javascript"></script>
<script src="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<link href="view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" media="screen" />
<link type="text/css" href="view/stylesheet/stylesheet.css" rel="stylesheet" media="screen" />
<link rel="stylesheet" type="text/css" href="view/javascript/addgrid/grideditor.css" />
<?php foreach ($styles as $style) { ?>
<link type="text/css" href="<?php echo $style['href']; ?>" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="view/javascript/common.js" type="text/javascript"></script>
<?php foreach ($scripts as $script) { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
</head>
<body>
<div id="container">
<header id="header" class="navbar navbar-static-top">
  <?php if ($logged) { ?>
    <style type="text/css">
        #list-left li a{
            padding: 3px 15px;
            line-height: 40px;
            cursor: pointer;
            color: #6D6D6D;
        }
    </style>
  <ul id="list-left" class="pull-left" style="margin-left: 250px; list-style-type: none; padding: 0px; margin-bottom: 0px;">
      <li><a href="/"><b style="text-transform: uppercase; font-weight: bold; color: #000;  font-size: 24px;"><img src="/image/logo.png" height="50px"></b></a></li>
  </ul>
  <ul class="nav pull-right">
    <li><a href="<?php echo $logout; ?>"><span class="hidden-xs hidden-sm hidden-md"><?php echo $text_logout; ?></span> <i class="fa fa-sign-out fa-lg"></i></a></li>
  </ul>
  <?php } ?>
</header>

