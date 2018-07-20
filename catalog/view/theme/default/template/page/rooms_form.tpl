<?php echo $header?>
<script src="http://maps.googleapis.com/maps/api/js?&libraries=places,drawing&language=vi&key=AIzaSyDDN318nA97mr0gEWZ0nd6SokteK0Y0w08" type="text/javascript"></script>
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
                    <div style="float: right;" class="g-recaptcha" data-sitekey="6LfgN2EUAAAAABaWW9V_kzQLRliZnWxg5hp1H__j"></div>
                    <div class="error-capcha" style="display: none">
                        <p style="color: red">vui lòng check capcha </p>
                    </div>

              </div>
                <div class="panel-body">
                    <ul class="nav nav-tabs">
                      <li class="active"><a href="#tab-general" data-toggle="tab">Thông tin chính</a></li>
                    </ul>
                    <div class="tab-content">
                      <div class="tab-pane active main-infor" id="tab-general">
                          <div class="row">
                              <div class="col-md-5">
                                  <div class="text-center title-info"><h3>Hình ảnh</h3></div>
                                  <div class="form-group">
                                      <div class="slider-images col-md-12">
                                          <?php if(!empty($room_images_lagre)) { ?>
                                              <div id="myCarousel" class="carousel slide" data-ride="carousel">
                                                  <div class="carousel-inner">
                                                        <?php foreach($room_images_lagre as $k=>$item){ ?>
                                                              <div class="item <?php echo $k==0 ? 'active':'' ?>" style="height:430px; overflow: hidden;">
                                                                  <img onerror="this.src='http://www.venturinistore.it/images/joomlart/demo/default.jpg'" src="<?php echo $item->link; ?>" class="img-responsive">
                                                              </div>
                                                        <?php } ?>
                                                  </div>
                                                  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                                                      <span class="glyphicon glyphicon-chevron-left"></span>
                                                      <span class="sr-only">Previous</span>
                                                  </a>
                                                  <a class="right carousel-control" href="#myCarousel" data-slide="next">
                                                      <span class="glyphicon glyphicon-chevron-right"></span>
                                                      <span class="sr-only">Next</span>
                                                  </a>
                                              </div>
                                          <?php } else{ ?>
                                                <img src="http://www.venturinistore.it/images/joomlart/demo/default.jpg" class="img-responsive">
                                          <?php } ?>
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
                                      <div class="col-sm-12">
                                          <div class="row">
                                              <div class="col-sm-6" style="margin-bottom: 10px;">
                                                  <label class="">Tỉnh/Thành phố</label>
                                                  <select class="form-control" name="city_id">
                                                      <option value="null">--- Chọn Tỉnh/Thành phố ---</option>
                                                      <?php foreach($citys as $item) { ?>
                                                          <?php if($item["city_id"] == $city_id) { ?>
                                                                <option selected="selected" value="<?php echo $item['city_id'] ?>"><?php echo $item['name'] ?></option>
                                                          <?php } else{  ?>
                                                                <option value="<?php echo $item['city_id'] ?>"><?php echo $item['name'] ?></option>
                                                          <?php } ?>
                                                      <?php } ?>
                                                  </select>
                                              </div>
                                              <div class="col-sm-6" style="margin-bottom: 10px;">
                                                  <label class="">Quận/Huyện</label>
                                                  <select class="form-control" name="district_id">
                                                      <option value="null">--- Chọn Quận/Huyện ---</option>
                                                      <?php foreach($districts as $item) { ?>
                                                          <?php if($item["district_id"] == $district_id) { ?>
                                                                <option selected="selected" value="<?php echo $item['district_id'] ?>"><?php echo $item['name'] ?></option>
                                                          <?php } else { ?>
                                                                <option value="<?php echo $item['district_id'] ?>"><?php echo $item['name'] ?></option>
                                                          <?php } ?>
                                                      <?php } ?>
                                                  </select>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-sm-12 dropdown" style="margin-bottom: 10px;">
                                          <label class="">Địa chỉ: <i style="font-size: 12px; color: red; ">Gõ địa chỉ chính xác hay có có thể lấy từ BẢN ĐỒ</i></label>
                                          <div class="dropdown">
                                              <input name="address" id="input-address" class="form-control " value="<?php echo $address; ?>">
                                              <div id="address-suggest" style="width: 100%" class="dropdown-menu" style="display: none"></div>
                                          </div>

                                      </div>
                                      <div class="col-md-12">
                                          <div id="map-address" style="width: 100%; height: 400px;"></div>
                                          <br>
                                          <div class="row">
                                              <div class="col-sm-6">
                                                  <label class="">Kinh độ: </label>
                                                  <div><input name="lat" id="input-lat" class="form-control" value="<?php echo $location['coordinates'][1]; ?>"></div>
                                              </div>
                                              <div class="col-sm-6">
                                                  <label class="">Vĩ độ: </label>
                                                  <div><input name="lng" id="input-lng" class="form-control" value="<?php echo $location['coordinates'][0]; ?>"></div>
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

                                              <?php $class = 'show'; ?>

                                              <div class="col-md-4 item">
                                                  <div class="feature price">
                                                      <b>Tiền thuê: </b> <?php echo $txt_price; ?>
                                                      <input name="price" placeholder="Giá: nhập số và bắt buộc" class="<?php echo $class; ?> form-control" value="<?php echo $price; ?>">
                                                  </div>
                                              </div>
                                              <div class="col-md-4 item">
                                                  <div class="feature acreage">
                                                      <b>Diện tích: </b> <?php echo $acreage; ?> m2
                                                      <input name="acreage" placeholder="Giá: Nhập số và bắt buộc" class="<?php echo $class; ?> form-control" value="<?php echo $acreage; ?>">
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
                                          </div>
                                      </div>
                                  </div></br></br>
                                  <div class="text-center title-info"><h3>Thông tin cở bản</h3></div>
                                  <div class="row">
                                     
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
                                         
                                      </div>
                                      <div class="col-md-4">
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

                                  </div></br></br>
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
                                                  <textarea id="highlight-rooms" type="text" name="highlight" value="<?php echo  $highlight;  ?>" class="form-control" rows="5"><?php echo  $highlight; ?></textarea>
                                              </div>
                                          </div>

                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                    </div>
                </div>
              </div>
          </div>
          </div>
      </form>
  </div>
<script language="javascript" type="text/javascript">
       var option_tinymce = {
          selector: '#highlight-rooms',
         
          /*skin: 'light',*/
          height:500,
          app_default: 'cdv',
          relative_urls: false,
          remove_script_host: false,
          document_base_url : "<?php echo HTTP_CATALOG; ?>",
          plugin_url : "<?php echo HTTP_SERVER; ?>admin-rooms/view/javascript/tinymce/plugins/",
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

</script>
<script type="text/javascript">

    var geocoder = new google.maps.Geocoder();
    function geocodePosition(pos) {
        geocoder.geocode({
            latLng: pos
        }, function(responses) {
            if (responses && responses.length > 0) {
                var address_lengh = responses[0].address_components.length;
                var location = {};
                for(var i = address_lengh-1; i>=0; i--){
                    if(responses[0].address_components[i].types[0]=='administrative_area_level_1'){
                        location.city= responses[0].address_components[i].long_name;
                    }
                    if(responses[0].address_components[i].types[0]=='administrative_area_level_2'){
                        location.district= responses[0].address_components[i].long_name;
                    }
                }
            } else {
                alert("Không tìm thấy địa chỉ");
                alert("NHập địa chỉ");
                alert("Nhập Nhập thành phố và Quận/Huyện");
            }
        });
    }
    function updateMarkerPosition(latLng) {
        document.getElementById('input-lat').value = latLng.lat();
        document.getElementById('input-lng').value = latLng.lng();

    }
    var map= new google.maps.Map(document.getElementById('map-address'), {
        center: {lat: <?php echo $location['coordinates'][1] ? $location['coordinates'][1] : '10.7654001'; ?>, lng: <?php echo $location['coordinates'][0] ? $location['coordinates'][0] : '106.6813622'; ?>},
        zoom: 16,
        scaleControl: false,
        fullscreenControl: false,
        mapTypeControl: false,
        streetViewControl: false,
        overviewMapControl: true,
        scrollwheel: true,
        disableDoubleClickZoom: true,
    });
    // Create the search box and link it to the UI element.
    var input = document.getElementById('input-address');
    var searchBox = new google.maps.places.Autocomplete(input);
    searchBox.setTypes(['address']);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var marker = new google.maps.Marker({
        position: {lat: <?php echo $location['coordinates'][1] ? $location['coordinates'][1] : '10.7654001'; ?>, lng: <?php echo $$location['coordinates'][0] ? $location['coordinates'][0] : '106.6813622'; ?>},
        map: map,
        title: '<?php echo $address;  ?>',
        draggable: true
    });

    searchBox.addListener('place_changed', function() {
        var place = searchBox.getPlace();
        if (!place.geometry) {
            return;
        }

        marker.setMap(null);
        marker = new google.maps.Marker({
            map: map,
            title: place.name,
            position: {lat: place.geometry.location.lat(), lng: place.geometry.location.lng()},
            draggable: true
        });

        map.setCenter({lat: place.geometry.location.lat(), lng: place.geometry.location.lng()});
        var address_lengh = place.address_components.length;
        var location = {};
        for(var i = address_lengh-1; i>=0; i--){
            if(place.address_components[i].types[0]=='administrative_area_level_1'){
                location.city= place.address_components[i].long_name;
            }
            if(place.address_components[i].types[0]=='administrative_area_level_2'){
                location.district= place.address_components[i].long_name;
            }
        }
        $('input[name=lng]').val(place.geometry.location.lng());
        $('input[name=lat]').val(place.geometry.location.lat());
        console.log(location.district);
        $.ajax({
          url:'/dia-chi-phong-tro',
          type:'POST',
          data:{
            district:location.district,
            city:location.city
          },success:function(data){
          if(typeof(data) != "undefined" && data !== null){
              var obj = $.parseJSON(data);
              $('select[name=city_id] option').removeAttr('selected').filter('[value="'+obj.city_id+'"]').attr('selected', 'selected');
              $.ajax({
                  url: '/danh-sach-quan-huyen/'+obj.city_id,
                  dataType: 'json',
                  success: function(json) {
                      $('select[name=\'district_id\']').html('');
                      $.map(json, function(item) {
                          $('select[name=\'district_id\']').append('<option value="'+item.id+'">'+item.name+'</option>');
                      });
                  
                      $('select[name=district_id] option').removeAttr('selected').filter('[value="'+obj.district_id+'"]').attr('selected', 'selected')
                  }
              });
            }
          }
        })

        google.maps.event.addListener(marker, 'drag', function() {
            updateMarkerPosition(marker.getPosition());
        });
        google.maps.event.addListener(marker, 'dragend', function() {
            geocodePosition(marker.getPosition());
        });
    });


    google.maps.event.addListener(marker, 'drag', function() {
        updateMarkerPosition(marker.getPosition());
    });
    google.maps.event.addListener(marker, 'dragend', function() {
        geocodePosition(marker.getPosition());
    });

    var bounds=  new google.maps.LatLngBounds();

    var polygon = new google.maps.Polygon({
        paths: [],
        strokeColor: '#FF0000',
        strokeOpacity: 0.5,
        strokeWeight: 3,
        fillColor: '#FF0000',
        fillOpacity: 0,
        draggable: false,
        clickable:false
    });
    
    var drawPolygon = function (data) {
        var data_draw = [];
        bounds = new google.maps.LatLngBounds();
        $.each(data, function (key,item) {
            data_draw.push({'lat': parseFloat(item[0]), 'lng': parseFloat(item[1])});
            bounds.extend(new google.maps.LatLng(item[0], item[1]));
        });
        polygon.setMap(null);
        polygon = new google.maps.Polygon({
            paths: data_draw,
            strokeColor: '#FF0000',
            strokeOpacity: 0.5,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0,
            draggable: false,
            clickable:false
        });
        polygon.setMap(map);
        map.fitBounds(bounds);
        map.setCenter(bounds.getCenter());
        map.getBoundsZoomLevel(bounds.getBounds());
        map.setZoom();
    }
    $("#tab-general select").change(function () {
        if($(this).attr('name') == 'city_id'){
            $.ajax({
                url: '/danh-sach-quan-huyen/'+$(this).val(),
                dataType: 'json',
                success: function(json) {
                    $('select[name=\'district_id\']').html('');
                    $.map(json, function(item) {
                        $('select[name=\'district_id\']').append('<option value="'+item.id+'">'+item.name+'</option>');
                    });
                }
            });
        }
        if($(this).attr('name') == 'district_id'){
            var district_select = $(this).val();
            $.ajax({
                url: 'index.php?route=catalog/rooms/getLocation&token=<?php echo $token; ?>&district_id='+district_select,
                dataType: 'json',
                success: function(json) {
                    console.log(JSON.parse(json['location']));
                    drawPolygon(JSON.parse(json['location']));
                }
            });
        }
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
  </script>
</div>
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
  .feature .show{
    opacity: 0.6;
    border: 0px;
    margin-top: 7px;
  }
</style>
<?php echo $footer; ?>