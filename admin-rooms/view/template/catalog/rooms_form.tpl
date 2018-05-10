<?php echo $header; ?>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-information" class="btn btn-primary"><i class="fa fa-save"></i> Lưu</button>
        <a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> Hủy</a></div>
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
          <div class="col-md-12">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-inbox"></i> <?php echo $text_form; ?></h3>
                </div>
                <div class="panel-body">
                    <ul class="nav nav-tabs">
                      <li class="active"><a href="#tab-general" data-toggle="tab">Thông tin chính</a></li>
                      <li><a href="#tab-data" data-toggle="tab">SEO</a></li>
                    </ul>
                    <div class="tab-content">
                      <div class="tab-pane active main-infor" id="tab-general">
                          <div class="row">
                              <div class="col-md-5">
                                  <div class="text-center title-info"><h3>Hình ảnh</h3></div>
                                  <div class="form-group">
                                      <div class="slider-images col-md-12">
                                          <img src="http://www.venturinistore.it/images/joomlart/demo/default.jpg" class="img-responsive">
                                          <button type="button" onclick="addImage();" title="" class="add-image pull-right">Thêm ảnh [+]</button>
                                      </div>
                                      <div id="img-list" class="col-md-12">
                                          <div class="img">
                                              <?php $image_row = 0; ?>
                                              <div class="row">
                                                  <?php if($room_images) { ?>
                                                          <?php foreach($room_images as $key=>$item){ ?>
                                                              <div class="item-image col-md-3" id="item-<?php echo $key; ?>">
                                                                  <a href="" style="border: 3px solid #e4e4e4" id="thumb-image<?php echo $key; ?>" data-toggle="image" class="img-thumbnail">
                                                                      <img width="100%" src="<?php echo $item['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />
                                                                  </a>
                                                                  <input type="hidden" name="images[<?php echo $key; ?>]" value="<?php echo $item['image']; ?>" id="input-image<?php echo $key; ?>" />
                                                                  <button type="button" onclick="$('#item-<?php echo $key; ?>').remove();" data-toggle="tooltip" title="Xóa" class="remove-imge"><i class="fa fa-minus-circle"></i></button>
                                                              </div>
                                                          <?php $image_row ++;  } ?>
                                                  <?php } ?>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="form-group">
                                      <div class="text-center title-info"><h3>Địa chỉ chính xác (Map)</h3></div>
                                      <div class="col-md-12">
                                          <div id="map-address" style="width: 100%; height: 300px;"></div>
                                          <br>
                                          <div class="row">
                                              <div class="col-sm-6">
                                                  <label class="">Kinh độ: </label>
                                                  <div><input name="lat" id="input-lat" class="form-control" value="<?php echo $lat; ?>"></div>
                                              </div>
                                              <div class="col-sm-6">
                                                  <label class="">Vĩ độ: </label>
                                                  <div><input name="lng" id="input-lng" class="form-control" value="<?php echo $lng; ?>"></div>
                                              </div>
                                              <div class="col-md-12">
                                                  <h3 style="font-size: 18px; margin-top: 15px;">Hướng dẫn: </h3>
                                                  <p>Kéo chấm đỏ trên bản đồ để cập nhật lại vị trí cho phòng trọ...</p>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-7">
                                  <div class="text-center title-info"><h3>Thông tin chính</h3></div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="row">
                                              <div class="col-sm-12" style="margin-bottom: 10px;">
                                                  <label class="">Tên hiển thị</label>
                                                  <div><input name="name" id="input-name" class="form-control" value="<?php echo $name; ?>"></div>
                                              </div>

                                              <div class="col-sm-12" style="margin-bottom: 10px;">
                                                  <label class="">Địa chỉ: <i style="font-size: 12px; color: red; ">Gõ địa chỉ chính xác hay có có thể lấy từ BẢN ĐỒ</i></label>
                                                  <div><input name="address" id="input-address" class="form-control" value="<?php echo $address; ?>"></div>
                                              </div>

                                              <?php $class = 'show'; if(isset($room_id)) $class = 'hidden';  ?>

                                              <div class="col-md-4 item">
                                                  <div class="feature price">
                                                      <b>Tiền thuê: </b> <?php echo $txt_price; ?>
                                                      <input name="price" class="<?php echo $class; ?> form-control" value="<?php echo $price; ?>">
                                                  </div>
                                              </div>
                                              <div class="col-md-4 item">
                                                  <div class="feature acreage">
                                                      <b>Diện tích: </b> <?php echo $acreage; ?> m2
                                                      <input name="acreage" class="<?php echo $class; ?> form-control" value="<?php echo $acreage; ?>">
                                                  </div>
                                              </div>
                                              <div class="col-md-4 item">
                                                  <div class="feature price_deposit">
                                                      <b>Tiền cọc: </b> <?php echo $txt_price_deposit; ?>
                                                      <input name="price_deposit" class="<?php echo $class; ?> form-control" value="<?php echo $price_deposit; ?>">
                                                  </div>
                                              </div>

                                              <div class="col-md-4 item">
                                                  <div class="feature">
                                                      <b>Tiền nước: </b> <?php echo $txt_price_water; ?>
                                                      <input name="price_water" class="<?php echo $class; ?> form-control" value="<?php echo $price_water; ?>">
                                                  </div>
                                              </div>

                                              <div class="col-md-4 item">
                                                  <div class="feature">
                                                      <b>Tiền điện: </b> <?php echo $txt_price_electricity; ?>
                                                      <input name="price_electricity" class="<?php echo $class; ?> form-control" value="<?php echo $price_electricity; ?>">
                                                  </div>
                                              </div>

                                              <div class="col-md-4 item">
                                                  <div class="feature">
                                                      <b>Lượt xem: </b> <?php echo $view; ?> Lượt
                                                      <input name="view" class="<?php echo $class; ?> form-control" value="<?php echo $view; ?>">
                                                  </div>
                                              </div>
                                              <div class="col-md-4 item">
                                                  <div class="feature">
                                                      <b>Gọi liên hệ: </b> <?php echo $call; ?> lần
                                                      <input name="call" class="<?php echo $class; ?> form-control" value="<?php echo $call; ?>">
                                                  </div>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="text-center title-info"><h3>Thông tin cở bản</h3></div>
                                  <div class="row">
                                      <div class="col-md-4">
                                        <div class="form-group">
                                          <label class="col-sm-12">Loại tin</label>
                                          <div class="col-md-12">
                                              <select name="ads" id="input-status" class="form-control">
                                                  <option value="" >--- Loại tin ---</option>
                                                  <?php if ($ads) { ?>
                                                  <option value="1" selected="selected">Quảng cáo</option>
                                                  <option value="0">Tin bình thường</option>
                                                  <?php } else { ?>
                                                  <option value="1">Mở</option>
                                                  <option value="0" selected="selected">Tin bình thường</option>
                                                  <?php } ?>
                                              </select>
                                          </div>
                                        </div>
                                        <div class="form-group">
                                              <label class="col-sm-12">Vị trí đặt</label>
                                              <div class="col-md-12">
                                                  <select name="ads_position" id="input-status" class="form-control">
                                                      <option value="" >--- Loại tin ---</option>
                                                      <?php if ($ads_position) { ?>
                                                      <option value="1" selected="selected">Trang chủ</option>
                                                      <option value="0">Trang tìm kiếm</option>
                                                      <?php } else { ?>
                                                      <option value="1">Trang chủ</option>
                                                      <option value="0" selected="selected">Trang tìm kiếm</option>
                                                      <?php } ?>
                                                  </select>
                                              </div>
                                        </div>
                                        <?php if(isset($room_id)) { ?>
                                            <div class="form-group">
                                                  <label class="col-sm-12">Mã tin đăng</label>
                                                  <div class="col-md-12">
                                                      <input type="text" class="form-control" name="room_id" value="<?php echo $room_id; ?>" >
                                                  </div>
                                            </div>
                                        <?php } ?>
                                      </div>
                                      <div class="col-md-4">
                                          <div class="form-group">
                                              <label class="col-sm-12">Ngày chạy</label>
                                              <div class="col-md-12">
                                                  <input type="text" name="from_date" value="<?php echo $from_date; ?>" class="datetime form-control">
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <label class="col-sm-12">Ngày kết thúc</label>
                                              <div class="col-md-12">
                                                  <input name="to_date" value="<?php echo $to_date; ?>" type="text" class="datetime form-control">
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <label class="col-sm-12">Mã chủ phòng</label>
                                              <div class="col-md-12">
                                                  <input type="text" class="form-control" name="master_id" value="<?php echo $master_id; ?>" >
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-md-4">
                                          <div class="form-group">
                                              <label class="col-sm-12">Số người ở tối đa</label>
                                              <div class="col-md-12">
                                                  <input type="text" name="amount_people" value="<?php echo $amount_people; ?>"  class="form-control">
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <label class="col-sm-12">Giờ đóng cửa</label>
                                              <div class="col-md-12">
                                                  <input type="text" name="close_door" value="<?php echo $close_door; ?>" class="form-control">
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <label class="col-sm-12">Tình trạng</label>
                                              <div class="col-md-12">
                                                  <select name="status" id="input-status" class="form-control">
                                                      <?php if ($status) { ?>
                                                      <option value="1" selected="selected">Đang hoạt động</option>
                                                      <option value="0">tắt</option>
                                                      <?php } else { ?>
                                                      <option value="1">Đang hoạt động</option>
                                                      <option value="0" selected="selected">Tắt</option>
                                                      <?php } ?>
                                                  </select>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="text-center title-info"><h3>Thông tin thêm</h3></div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-group">
                                              <label class="col-sm-12">Nội quy phòng trọ</label>
                                              <div class="col-md-12">
                                                  <textarea name="regulation_room" value="<?php echo $regulation_room; ?>" type="text" class="form-control" rows="5"><?php echo $regulation_room; ?></textarea>
                                              </div>
                                          </div>
                                          <div class="form-group">
                                              <label class="col-sm-12">Nổi bật phòng trọ</label>
                                              <div class="col-md-12">
                                                  <textarea type="text" name="highlight" value="<?php echo  $highlight;  ?>" class="form-control" rows="5"><?php echo  $highlight; ?></textarea>
                                              </div>
                                          </div>

                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <div class="tab-pane" id="tab-data">

                      </div>
                    </div>
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
    var geocoder = new google.maps.Geocoder();
    function geocodePosition(pos) {
        geocoder.geocode({
            latLng: pos
        }, function(responses) {

            if (responses && responses.length > 0) {
                updateMarkerAddress(responses[0].formatted_address);
            } else {
                updateMarkerAddress('Cannot determine address at this location.');
            }
        });
    }


    function updateMarkerPosition(latLng) {
        document.getElementById('input-lat').value = latLng.lat();
        document.getElementById('input-lng').value = latLng.lng();

    }

    function updateMarkerAddress(str) {
        document.getElementById('input-address').value = str;
    }

    var map= new google.maps.Map(document.getElementById('map-address'), {
        center: {lat: <?php echo $lat ? $lat : '10.7654001'; ?>, lng: <?php echo $lng ? $lng : '106.6813622'; ?>},
        zoom: 16,
        scaleControl: false,
        fullscreenControl: false,
        mapTypeControl: false,
        streetViewControl: false,
        overviewMapControl: true,
        scrollwheel: true,
        disableDoubleClickZoom: true,
    });
    var marker = new google.maps.Marker({
        position: {lat: <?php echo $lat ? $lat : '10.7654001'; ?>, lng: <?php echo $lng ? $lng : '106.6813622'; ?>},
        map: map,
        title: '<?php echo $address;  ?>',
        draggable: true
    });
    google.maps.event.addListener(marker, 'drag', function() {
        updateMarkerPosition(marker.getPosition());
    });
    google.maps.event.addListener(marker, 'dragend', function() {
        geocodePosition(marker.getPosition());
    });
    var image_row = <?php echo $image_row; ?>;
    function addImage() {
      html  = '<div class="item-image col-md-3" id="item-' + image_row + '">';
        html  += '<a href="" style="border: 1px solid #e4e4e4" id="thumb-image' + image_row + '" data-toggle="image" class="img-thumbnail">';
          html  += '<img width="100%" src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" />';
        html  += '</a>';
        html  += '<input type="hidden" name="images[' + image_row + ']" value="" id="input-image' + image_row + '" />';
        html  += '<button type="button" onclick="$(\'#item-' + image_row + '\').remove();" data-toggle="tooltip" title="Xóa" class="remove-imge"><i class="fa fa-minus-circle"></i></button>';
      html  += '</div>';
      $('#img-list .img .row').append(html);
      image_row++;
    }
    $('.datetime').datetimepicker({
        pickDate: true,
        pickTime: true
    });
  </script>
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<style type="text/css">
  .img-thumbnail{width: 100%;}
  #img-list .img .row{
      margin-left: -5px;
      margin-right: -5px;
  }
  .item-image{
      padding: 5px;
      margin-bottom: 5px;
  }
  .item-image .remove-imge{
      position: absolute;
      right: -6px;
      top: -6px;
      background-color: #ea4335;
      border: 0px;
      color: #fff;
      height: 25px;
      width: 25px;
      border-radius: 100%;
      z-index: 1;
  }
  .add-image,.add-image:focus{
      font-size: 14px;
      background-color: transparent;
      border: 0px;
      color: #ffffff;
      outline: 0px;
      background-color: #7399a5;
      padding: 3px 10px;
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

  .title-info{
    text-transform: uppercase;
    position: relative;
  }
  .title-info:before{
      content: "";
      position: absolute;
      top: 45%;
      left: 0px;
      width: 100%;
      border-bottom: 1px solid #ccc;
      z-index: 0;
  }
  .title-info h3{
      display: inline-block;
      padding: 7px; 10px;
      background-color: #fff;
      position: relative;
      z-index: 1;
      color: #19699c;
      font-weight: bold;
      font-size: 18px;
  }
    .main-infor .item{
        margin: 5px 0px;
    }
  .main-infor .feature{
      padding:10px 7px; border-radius: 3px; color: #000;
      background-color: #ccc;
  }
  .main-infor .feature.price{
      background-color: #19699c;
      color: #fff;
  }
  .main-infor .feature.acreage{
      background-color: #fc8d21;
      color: #fff;
  }
  .main-infor .feature.price_deposit{
      background-color: #E91E63;
      color: #fff;
  }

</style>
<?php echo $footer; ?>