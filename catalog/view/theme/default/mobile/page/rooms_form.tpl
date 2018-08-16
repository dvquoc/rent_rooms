<?php echo $header?>
<script src="http://maps.googleapis.com/maps/api/js?&libraries=places,drawing&language=vi&key=AIzaSyDDN318nA97mr0gEWZ0nd6SokteK0Y0w08" type="text/javascript"></script>
<link type="text/css" href="/public/assets/css/stylesheetrooms.css" rel="stylesheet" media="screen"/>
<link href="/public/assets/css/opencart.css" type="text/css" rel="stylesheet" />
<link href="/public/assets/css/load-font.css" rel="stylesheet" type="text/css">

<script src='https://www.google.com/recaptcha/api.js'></script>

<link href="/public/assets/plugins/upload_file/dist/styles.imageuploader.css" type="text/css" rel="stylesheet" />
<script src="/public/assets/plugins/upload_file/dist/jquery.imageuploader.js"></script>


<div id="content">
  <div class="page-header">
     
    <div class="container-fluid">
      
      <div class="pull-right">
        <button id="save" type="button" form="form-information" class="btn btn-primary"><i class="fa fa-save"></i> Lưu</button>
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
        <div style="position: absolute;top: 50px;right: 160px;" class="g-recaptcha" data-sitekey="6LfgN2EUAAAAABaWW9V_kzQLRliZnWxg5hp1H__j"></div>
        <div class="error-capcha" style="display: none">
            <p style="color: red">vui lòng check capcha </p>
        </div>
        <div class="row">
          <div class="col-md-12">
              <div class="panel panel-default">
                <div class="panel-heading">
                  <h3 class="panel-title"><i class="fa fa-inbox"></i> <?php echo $text_form; ?></h3>
                   

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
                                     <div class="uploader__box js-uploader__box l-center-box">
                                          <div class="uploader__contents">
                                              <label class="button button--secondary" for="fileinput">Select Files</label>
                                              <input id="fileinput" name="images" class="uploader__file-input" type="file" multiple value="Select Files">
                                          </div>
                                    </div>

                                  </div>
                                  <div class="form-group">
                                      <div class="text-center title-info"><h3>Địa chỉ chính xác (Map)</h3></div>
                                      <div class="col-sm-12">
                                          <div class="row">
                                              <div class="col-sm-6" style="margin-bottom: 10px;">
                                                  <label class="">Tỉnh/Thành phố</label>
                                                  <input name="slug_city" type="hidden" class="form-control">
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
                                                  <div id="validate_city" hidden><span style="color: red">Vui lòng chọn thành phố</span></div>
                                              </div>
                                              <div class="col-sm-6" style="margin-bottom: 10px;">
                                                  <label class="">Quận/Huyện</label>
                                                  <input name="slug_district" type="hidden" class="form-control">
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
                                                   <div id="validate_district" hidden><span style="color: red">Vui lòng chọn Quận/Huyện</span></div>
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
                                                  <div id="validate_lat" hidden><span style="color: red">Trường này không được trống</span></div>
                                              </div>
                                              <div class="col-sm-6">
                                                  <label class="">Vĩ độ: </label>
                                                  <div><input name="lng" id="input-lng" class="form-control" value="<?php echo $location['coordinates'][0]; ?>"></div>
                                                   <div id="validate_lng" hidden><span style="color: red">Trường này không được trống</span></div>
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
                                                  <div>
                                                    <input name="name" id="input-name" class="form-control" value="<?php echo $name; ?>">
                                                    <input name="slug" type="hidden" class="form-control">
                                                  </div>
                                                   <div id="validate_name" hidden><span style="color: red">Trường này không được trống</span></div>
                                              </div>
                                              <?php $class = 'show'; ?>
                                              <div class="col-md-4 item">
                                                  <div class="feature price">
                                                      <b>Tiền thuê: </b> <?php echo $txt_price; ?>
                                                      <input name="price" placeholder="Giá: nhập số và bắt buộc" class="<?php echo $class; ?> form-control" value="<?php echo $price; ?>">
                                                      <div id="validate_price" hidden><span style="color: red">Trường này không được trống</span></div>
                                                  </div>
                                              </div>
                                              <div class="col-md-4 item">
                                                  <div class="feature acreage">
                                                      <b>Diện tích: </b> <?php echo $acreage; ?> m2
                                                      <input name="acreage" placeholder="Giá: Nhập số và bắt buộc" class="<?php echo $class; ?> form-control" value="<?php echo $acreage; ?>">
                                                      <div id="validate_acreage" hidden><span style="color: red">Trường này không được trống</span></div>
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
                                                <label class="col-sm-12">Giờ đóng cửa</label>
                                                <div class="col-md-12">
                                                    <input type="text" name="close_door" value="<?php echo $close_door; ?>" class="form-control">
                                                </div>
                                          </div>
                                          <div class="form-group" style="display: none" >
                                              <label class="col-sm-12">Ngày chạy</label>
                                              <div class="col-md-12">
                                                  <input type="text" name="from_date" value="<?php echo $from_date; ?>" class="datetime form-control">
                                              </div>
                                          </div>
                                          <div class="form-group" style="display: none">
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

<script type="text/javascript">
  $( document ).ready(function() {
  });
   var options = {
    instructionsCopy: 'Drag and Drop, orssss',
    furtherInstructionsCopy: 'Your can also drop more files, or',
    selectButtonCopy: 'Select Files',
    secondarySelectButtonCopy: 'Select More Files',
    dropZone: $(this),
    fileTypeWhiteList: ['jpg', 'png', 'jpeg', 'gif', 'pdf'],
    badFileTypeMessage: 'Sorry, we\'re unable to accept this type of file.',
    ajaxUrl: '/ajax/upload',
    testMode: false
};
$('.js-uploader__box').uploader(options);
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
    var address_components = {};
    var marker = new google.maps.Marker({
        position: {lat: <?php echo $location['coordinates'][1] ? $location['coordinates'][1] : '10.7654001'; ?>, lng: <?php echo $location['coordinates'][0] ? $location['coordinates'][0] : '106.6813622'; ?>},
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
                 address_components.city_name = place.address_components[i].long_name;
            }
            if(place.address_components[i].types[0]=='administrative_area_level_2'){
                location.district= place.address_components[i].long_name;
                address_components.district_name = place.address_components[i].long_name;
            }
        }
        $('input[name=lng]').val(place.geometry.location.lng());
        $('input[name=lat]').val(place.geometry.location.lat());

        $.each($("select[name=city_id] option"), function(key, item){
            if(new RegExp('[(.*?)\s]?'+location.city+"$",'igm').test($(item).text())){
                 $("select[name=city_id]").val($(item).attr('value')).change();
            }
        });
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
                if(new RegExp('[(.*?)\s]?'+address_components.district_name+"$",'igm').test(item.name)){
                     $("select[name=district_id]").val(item.id).change();
                }
            });
          }
        });
      }
    });
    $('#save').on('click',function(){
      var name = $('input[name=name]').val();
      var lat = $('input[name=lat]').val();
      var lng = $('input[name=lng]').val();
      var city = $('select[name=city_id]').val();
      var district = $('select[name=district_id]').val();
      var price = $('input[name=price]').val();
      var acreage = $('input[name=acreage]').val();

   
      if(name.length != 0 && lat.length != 0 && lng.length != 0 && city != 'null' && district != 'null' && price.length!= 0 && acreage.length != 0){
          var slug_name = $('input[name=name]').val();
          var slug_city =  $( "select[name=city_id] option:selected" ).text();
          var slug_district = $( "select[name=district_id] option:selected" ).text();

          $('input[name=slug]').val(ChangeToSlug(slug_name));
          $('input[name=slug_city]').val(ChangeToSlug(slug_city)); 
          $('input[name=slug_district]').val(ChangeToSlug(slug_district));
          var data = $('#form-information').serializeArray();
          var fd = new FormData($('#form-information')[0]);
           
          for (var i = 0; i < state.fileBatch.length; i++) {
            fd.append('files[]', state.fileBatch[i].file, state.fileBatch[i].fileName);
          }
          $.ajax({
            url:'<?php echo $action; ?>',
            type:'POST',
            enctype: 'multipart/form-data',
            contentType: false,
            processData: false,
            data:fd,
            success:function(e){
              window.location.href = "/quan-ly-phong-tro";
            }
          })
         
      }else{
        if(name.length == 0 ){
          $('#validate_name').show(); 
          setTimeout(function() {
            $("#validate_name").hide('blind', {}, 500)
          }, 3000);
          $('input[name=name]').focus();
        };
        if(lat.length == 0 ){
         $('#validate_lat').show(); 
         setTimeout(function() {
          $("#validate_lat").hide('blind', {}, 500)
        }, 3000);
         $('input[name=lat]').focus();
       };
       if(lng.length == 0 ){
         $('#validate_lng').show(); 
         setTimeout(function() {
          $("#validate_lng").hide('blind', {}, 500)
        }, 3000);
         $('input[name=lng]').focus();
       }
       if(city == 'null' ){
         $('#validate_city').show(); 
         setTimeout(function() {
          $("#validate_city").hide('blind', {}, 500)
        }, 3000);
         $('input[name=city]').focus();
       }
       if(district == 'null' ){
         $('#validate_district').show(); 
         setTimeout(function() {
          $("#validate_district").hide('blind', {}, 500)
        }, 3000);
         $('input[name=district]').focus();
       }
        if(name.length == 0 ){
          $('#validate_price').show(); 
          setTimeout(function() {
            $("#validate_price").hide('blind', {}, 500)
          }, 3000);
          $('input[name=price]').focus();
        };
         if(name.length == 0 ){
          $('#validate_acreage').show(); 
          setTimeout(function() {
            $("#validate_acreage").hide('blind', {}, 500)
          }, 3000);
          $('input[name=acreage]').focus();
        };
     }
   })
    
   
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