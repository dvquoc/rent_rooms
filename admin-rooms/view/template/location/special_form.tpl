<?php echo $header; ?>

<script src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=places,drawing&language=vi&key=AIzaSyDDN318nA97mr0gEWZ0nd6SokteK0Y0w08" type="text/javascript"></script>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button  class="btn btn-primary" id="save"><i class="fa fa-save"></i> Lưu</button>
                <button type="submit" form="form-information" hidden id="post_save">save</button>
                <a href="<?php echo $cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i> Hủy</a></div>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php 
            $arr_coords =[];
            $arr2=[];
            foreach($special['area'] as $value){ 
                $arr_coords[] = $value;
            }  
            $json = json_encode($arr_coords); 
        ?>
        <input type="hidden" name="polygon" value="<?php echo $json?>">
        <form action="<?php echo $save; ?>" method="post" enctype="multipart/form-data" id="form-information" class="form-horizontal">
            <div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-inbox"></i>Khu vực đặc biệt</h3>
                        </div>
                        <div class="panel-body">
                             <div class="row">
                                <div class="col-sm-12">
                                    <div class="dropdown">
                                        <input name="address" width="90%" id="input-address" class="form-control " value="<?php echo $address; ?>">
                                    </div>
                                </div>
                            </div>
                            <ul class="nav nav-tabs">
                              <li class="active"><a href="#tab-general" data-toggle="tab">Thông tin chính</a></li>
                              <li><a href="#tab-data" data-toggle="tab">SEO</a></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active main-infor" id="tab-general">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label class="">Tên </label>
                                           <input class="form-control" type="text" name="name" value="<?php echo isset($special['name'])?$special['name']:'';?>">
                                           <div id="validate_name" hidden><span style="color: red">Trường này không được trống</span></div>
                                            </br>
                                           <input type="hidden" name="id" value="<?php echo isset($special)?(string)$special['_id']:'' ?>">
                                            <label class="">Thành phố </label>
                                                <select class="form-control" name="city">
                                                    <!-- <option value="null">--- Chọn Tỉnh/Thành phố ---</option> -->
                                                      <?php foreach($citys as $item) { ?>
                                                          <?php if($item["city_id"] == $city[0]["city_id"]) { ?>
                                                                <option selected="selected" value="<?php echo $city[0]['city_id'] ?>"><?php echo $city[0]['name'] ?></option>
                                                          <?php } else{  ?>
                                                                <option value="<?php echo $item['city_id'] ?>"><?php echo $item['name'] ?></option>
                                                          <?php } ?>
                                                      <?php } ?>
                                                </select></br>
                                            <!--      <input class="form-control" type="text" name="city" value="<?php echo isset($special['name'])?$special['city']:'';?>"></br> -->
                                           <label class="">Quận </label>
                                               <select class="form-control" name="district">
                                                <!-- <option value="null">--- Chọn Quận/Huyện ---</option> -->
                                                  <?php foreach($districts as $item) { ?>
                                                      <?php if($item["district_id"] == $district[0]['district_id']) { ?>
                                                            <option selected="selected" value="<?php echo $district[0]['district_id'] ?>"><?php echo $district[0]['name'] ?></option>
                                                      <?php } else { ?>
                                                            <option value="<?php echo $item['district_id'] ?>"><?php echo $item['name'] ?></option>
                                                      <?php } ?>
                                                  <?php } ?>
                                              </select></br>
                                          <!--  <input class="form-control" type="text" name="district" value="<?php echo isset($special['name'])?$special['district']:'';?>"></br> -->
                                          
                                           <label class="">Lượt tìm kiếm </label>
                                           <input class="form-control" type="text" name="view" value="<?php echo isset($special['view'])?$special['view']:'';?>"></br>
                                           <label class="">Bán kình khu vực </label>
                                            <textarea class="form-control" readonly rows="5" name="circle"><?php echo $area?>
                                            </textarea>
                                           <label class="">Lat</label>
                                           <input class="form-control" readonly type="text" name="lat" value="<?php echo isset($special['lat'])?$special['lat']:'';?>">
                                            <div id="validate_lat" hidden><span style="color: red">Trường này không được trống</span></div>
                                           <label class="">Lng</label>
                                           <input class="form-control" readonly type="text" name="lng" value="<?php echo isset($special['lng'])?$special['lng']:'';?>">
                                            <div id="validate_lng" hidden><span style="color: red">Trường này không được trống</span></div>
                                        </div>
                                        <div class="col-md-8">
                                            <div id="map-address" style="width: 100%; height: 500px;"></div>
                                            <h3 style="font-size: 18px; margin-top: 15px;">Hướng dẫn: </h3>
                                            <p>Kéo chấm đỏ trên bản đồ để cập nhật lại vị trí cho phòng trọ...</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab-data">
                                    <label class="">Từ khóa </label>
                                   <input class="form-control" type="text" name="seo_key" value="<?php echo $special['seo_key']?>"></br>
                                   <label class="">Mô tả </label>
                                   <textarea class="form-control" rows="5" name="seo_discription"><?php echo $special['seo_discription']?></textarea>
                                 </div>
                            </div>
                        </div>
                    </div>
                </div>
        </form>
    </div>
    <script type="text/javascript">
        $( document ).ready(function(){
            drawPolygonTest();
        }); 
        var geocoder = new google.maps.Geocoder();
        function geocodePosition(pos) {
            geocoder.geocode({
                latLng: pos
            }, function(responses) {
                console.log(responses);
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
                    if(!$.isEmptyObject(location)) {
                        updateMarkerAddress(responses[0].formatted_address);
                        console.log(responses[0]);
                    } else {
                        alert('Không tìm thấy địa chỉ');
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
        function updateMarkerAddress(str) {
            document.getElementById('input-address').value = str;
        }

        var map= new google.maps.Map(document.getElementById('map-address'), {
            center: {lat: <?php echo isset($special) ? $special['lat'] : '10.7654001'; ?>, lng: <?php echo  isset($special) ? $special['lng'] : '106.6813622'; ?>},
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
        input.style.margin = '20px';
        input.style.width = '50%';
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        var marker = new google.maps.Marker({
            position: {lat: <?php echo isset($special) ? $special['lat'] : '10.7654001'; ?>, lng: <?php echo  isset($special) ? $special['lng'] : '106.6813622'; ?>},
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
            $('input[name=name]').val(place.name);
            $('input[name=lng]').val(place.geometry.location.lng());
            $('input[name=lat]').val(place.geometry.location.lat());
            $.ajax({
                url:'index.php?route=location/special/get_location&token=<?php echo $token;?>',
                type:'POST',
                data:{
                    district:location.district,
                    city:location.city
                },success:function(data){
                    if(typeof(data) != "undefined" && data !== null){
                        var obj = $.parseJSON(data);
                        $('select[name=city] option').removeAttr('selected').filter('[value="'+obj.city_id+'"]').attr('selected', 'selected');
                        $.ajax({
                            url: 'index.php?route=catalog/rooms/getDistricts&token=<?php echo $token; ?>&city_id='+obj.city_id,
                            dataType: 'json',
                            success: function(json) {
                                $('select[name=\'district\']').html('');
                                $.map(json, function(item) {
                                    $('select[name=\'district\']').append('<option value="'+item.id+'">'+item.name+'</option>');
                                });
                            
                                $('select[name=district] option').removeAttr('selected').filter('[value="'+obj.district_id+'"]').attr('selected', 'selected')
                            }
                        });
                    }
                }
            })

            //geocodePosition({lat: place.geometry.location.lat(), lng: place.geometry.location.lng()});
            google.maps.event.addListener(marker, 'dragend', function() {
                geocodePosition(marker.getPosition());
            });

        });

        google.maps.event.addListener(marker, 'dragend', function() {
            geocodePosition(marker.getPosition());
             

        });
        ///test
        var coord_polygon = [];
        var arr = $('input[name=polygon]').val();
        var str = arr.substring(2,arr.length-2);
        var arr_coords = str.split('],[');
        $.each(arr_coords, function (key,item) {
            var item_coords = item.split(',');
            coord_polygon.push({'lat': parseFloat(item_coords[0]), 'lng': parseFloat(item_coords[1])});
          
        });
        var bounds=  new google.maps.LatLngBounds();

        var polygon = new google.maps.Polygon({
            paths: coord_polygon,
            strokeColor: '#FF0000',
            strokeOpacity: 0.5,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0,
            draggable: false,
            clickable:false
        });
        polygon.setMap(map);
        ///test

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

        var drawPolygonTest = function(){
            var lat = $('input[name=lat]').val();
            var lng = $('input[name=lng]').val();
            var circle = $('textarea[name=circle]').val();
            var drawingManager = new google.maps.drawing.DrawingManager({
                    drawingMode: google.maps.drawing.OverlayType.POLYGON,
                    drawingControl: true,
                    drawingControlOptions: {
                        position: google.maps.ControlPosition.TOP_CENTER,
                        drawingModes: [
                          'polygon'
                        ]
                    },
                    polygonOptions: {
                        strokeColor: '#FF0000',
                        strokeOpacity: 0.5,
                        strokeWeight: 3,
                        fillColor: '#FF0000',
                        fillOpacity: 0,
                        draggable: false,
                        clickable:false,
                    }
                });
            drawingManager.setMap(map);
            google.maps.event.addListener(drawingManager, 'polygoncomplete', function (polygon) {
                //popUpPinInfo(marker, circle.radius, map);
                var coordinates = (polygon.getPath().getArray());
                $('textarea[name=circle]').val(coordinates);
            });
        }
        $('.datetime').datetimepicker({
            pickDate: true,
            pickTime: true
        });

        $("select").change(function () {
            if($(this).attr('name') == 'city'){
                $.ajax({
                    url: 'index.php?route=catalog/rooms/getDistricts&token=<?php echo $token; ?>&city_id='+$(this).val(),
                    dataType: 'json',
                    success: function(json) {
                        $('select[name=\'district\']').html('');
                        $.map(json, function(item) {
                            $('select[name=\'district\']').append('<option value="'+item.id+'">'+item.name+'</option>');
                        });
                    }
                });
            }
            if($(this).attr('name') == 'district'){
                var district_select = $(this).val();
                console.log('index.php?route=catalog/rooms/getLocation&token=<?php echo $token; ?>&district_id='+district_select);
                $.ajax({
                    url: 'index.php?route=catalog/rooms/getLocation&token=<?php echo $token; ?>&district_id='+district_select,
                    dataType: 'json',
                    success: function(json) {
                        console.log(JSON.parse(json['location']));
                       // drawPolygon(JSON.parse(json['location']));
                    }
                });
            }
        });
     
       
        $('#save').on('click',function(){
            var name = $('input[name=name]').val();
            var lat = $('input[name=lat]').val();
            var lng = $('input[name=lng]').val();
            if(name.length != 0 && lat.length != 0 && lng.length != 0){
                $('#post_save').trigger('click');
            }else{
                if(name.length == 0 ){
                    $('#validate_name').show(); 
                    setTimeout(function() {
                        $("#validate_name").hide('blind', {}, 500)
                    }, 3000);
                };
                if(lat.length == 0 ){
                   $('#validate_lat').show(); 
                    setTimeout(function() {
                        $("#validate_lat").hide('blind', {}, 500)
                    }, 3000);
                };
                if(lng.length == 0 ){
                   $('#validate_lng').show(); 
                    setTimeout(function() {
                        $("#validate_lng").hide('blind', {}, 500)
                    }, 3000);
                }
            }
        });
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

    #input-address{
        box-shadow: 0 2px 4px rgba(0,0,0,0.2), 0 -1px 0px rgba(0,0,0,0.02);
        position: relative;
        background: #fff;
        border-radius: 2px;
        box-sizing: border-box;
        border:0px;
        padding:20px 20px;
        transition-property: background,box-shadow;
        transition-duration: 0.3s;
        font-size: 14px;
    }
    .pac-logo:after{
        display: none!important;
    }
    .pac-item {
        cursor: default;
        padding: 0 4px;
        text-overflow: ellipsis;
        overflow: hidden;
        white-space: nowrap;
        line-height: 37px;
        text-align: left;
        border-top: 1px solid #e6e6e6;
        font-size: 13px;
        color: #999;
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