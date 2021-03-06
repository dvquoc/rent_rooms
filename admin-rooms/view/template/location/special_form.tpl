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
                                        <input name="address_special" width="90%" id="input-address" class="form-control" value="<?php echo $address; ?>">
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
                                    <input class="form-control" type="hidden" name="types_source" value="<?php echo $special['types_source']?>">
                                    <input class="form-control" type="hidden" name="slug_city" value="<?php echo $special['slug_city']?>">
                                    <input class="form-control" type="hidden" name="slug_district" value="<?php echo $special['slug_district']?>">
                                    <input type="hidden" name="place_id" value="">
                                    <label class="">Kiểu khu vực </label>
                                    <select class="form-control" name="types">
                                       <option value="null">--- Chọn khu vực ---</option>
                                       <?php foreach($types as $key => $value) { ?>
                                       <?php if($special['types'] == $key) { ?>
                                       <option selected="selected" value="<?php echo  $key ?>"><?php echo $value ?></option>
                                       <?php } else{  ?>
                                       <option value="<?php echo $key ?>"><?php echo $value ?></option>
                                       <?php } ?>
                                       <?php } ?>
                                   </select></br>
                                   <div id="types" hidden><span style="color: red">Khu vực phải được chọn</span></div>
                                   <label class="">Thành phố </label>
                                   <select class="form-control" name="city">
                                    <option value="null">--- Chọn Tỉnh/Thành phố ---</option>
                                    <?php foreach($citys as $item) { ?>
                                    <?php if($item["city_id"] == $city[0]["city_id"]) { ?>
                                    <option selected="selected" value="<?php echo $city[0]['city_id'] ?>"><?php echo $city[0]['name'] ?></option>
                                    <?php } else{  ?>
                                    <option value="<?php echo $item['city_id'] ?>"><?php echo $item['name'] ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select></br>
                                <div id="city" hidden><span style="color: red">Thành phố phải được chọn</span></div>
                                <!--      <input class="form-control" type="text" name="city" value="<?php echo isset($special['name'])?$special['city']:'';?>"></br> -->
                                <label class="">Quận </label>
                                <select class="form-control" name="district">
                                    <option value="null">--- Chọn Quận/Huyện ---</option>
                                    <?php foreach($districts as $item) { ?>
                                    <?php if($item["district_id"] == $district[0]['district_id']) { ?>
                                    <option selected="selected" value="<?php echo $district[0]['district_id'] ?>"><?php echo $district[0]['name'] ?></option>
                                    <?php } else { ?>
                                    <option value="<?php echo $item['district_id'] ?>"><?php echo $item['name'] ?></option>
                                    <?php } ?>
                                    <?php } ?>
                                </select></br>
                                <div id="district" hidden><span style="color: red">Quận/Huyện phải được chọn</span></div>
                                <!--  <input class="form-control" type="text" name="district" value="<?php echo isset($special['name'])?$special['district']:'';?>"></br> -->
                                
                                <label class="">Lượt tìm kiếm </label>
                                <input class="form-control" type="text" name="view" readonly value="<?php echo isset($special['view'])?$special['view']:'';?>"></br>
                                <label class="">Tọa độ khu vực </label>
                                <textarea class="form-control" readonly rows="5" name="circle"><?php echo $area?> </textarea>
                                <label class="">Lat</label>
                                <input class="form-control" readonly type="text" name="lat" value="<?php echo !empty($special['location']['coordinates'])?$special['location']['coordinates'][1]:'';?>">
                                <div id="validate_lat" hidden><span style="color: red">Trường này không được trống</span></div>
                                <label class="">Lng</label>
                                <input class="form-control" readonly type="text" name="lng" value="<?php echo !empty($special['location']['coordinates'])?$special['location']['coordinates'][0]:'';?>">
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
    
    var check  = false;
    var locationData = {};
    var geocoder = new google.maps.Geocoder();

    function resetLocation(){
        locationData = {};
    }
    function setDetectCityDistrict(){
        if(typeof locationData.city!="undedined"){ 
            var detect_city = $.each($("select[name=city] option"), function(key, item){
                if(new RegExp('[(.*?)\s]?'+locationData.city+"$",'igm').test($(item).text())){
                   $("select[name=city]").val($(item).attr('value')).change();
                   check = true;
                   return false;
               }
           });

            if(!check){
                alert('không lấy được thành phố');
            }
            check =false;
        }else{
            alert("Chưa có locationData, gọi người viết code");
        }
        
    }
    function geocodePosition(pos) {
        resetLocation();
        geocoder.geocode({
            latLng: pos
        }, function(responses) {
            if (responses && responses.length > 0) {
                var address_lengh = responses[0].address_components.length;
                for(var i = address_lengh-1; i>=0; i--){
                    if(responses[0].address_components[i].types[0]=='administrative_area_level_1'){
                        locationData.city= responses[0].address_components[i].long_name;
                    }
                    if(responses[0].address_components[i].types[0]=='administrative_area_level_2'){
                        locationData.district= responses[0].address_components[i].long_name;
                    }
                }
                if(!$.isEmptyObject(locationData)) {
                    updateMarkerAddress(responses[0].formatted_address);
                    updateMarkerPosition(pos.lat(),pos.lng());
                    $('input[name=name]').val(responses[0].formatted_address);
                    $('input[name=place_id]').val(responses[0].place_id);
                    $('input[name=types_source]').val(responses[0].types);
                    if(typeof locationData.city != 'undefined')
                        $('input[name=slug_city]').val(ChangeToSlug(locationData.city));
                    if(typeof locationData.district != 'undefined')
                        $('input[name=slug_district]').val(ChangeToSlug(locationData.district));
                    setDetectCityDistrict();

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
            var path = polygon.getPath()
            var coordinates = [];
            for (var i = 0 ; i < path.length ; i++) {
                var point =[];
                point.push(path.getAt(i).lat());
                point.push(path.getAt(i).lng());
                coordinates.push( point);                   
            }
            $('textarea[name=circle]').val(JSON.stringify(coordinates));
        });
    }

    function updateMarkerPosition(lat,Lng) {
        $('input[name=lng]').val(Lng);
        $('input[name=lat]').val(lat);

    }
    function updateMarkerAddress(str) {
        document.getElementById('input-address').value = str;
    }

    var map= new google.maps.Map(document.getElementById('map-address'), {
        center: {lat: <?php echo !empty($special['location']['coordinates']) ? $special['location']['coordinates'][1] : '10.7654001'; ?>, lng: <?php echo  !empty($special['location']['coordinates']) ? $special['location']['coordinates'][0] : '106.6813622'; ?>},
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
        var address_components = {};
        input.style.margin = '20px';
        input.style.width = '50%';
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        var marker = new google.maps.Marker({
            position: {lat: <?php echo !empty($special['location']['coordinates']) ? $special['location']['coordinates'][1] : '10.7654001'; ?>, lng: <?php echo  !empty($special['location']['coordinates']) ? $special['location']['coordinates'][0] : '106.6813622'; ?>},
            map: map,
            title: '<?php echo $address;  ?>',
            draggable: true,
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

            for(var i = address_lengh-1; i>=0; i--){
                if(place.address_components[i].types[0]=='administrative_area_level_1'){
                    locationData.city= place.address_components[i].long_name;
                    address_components.city_name = place.address_components[i].long_name;
                }
                if(place.address_components[i].types[0]=='administrative_area_level_2'){
                    locationData.district= place.address_components[i].long_name;
                    address_components.district_name = place.address_components[i].long_name;
                }
            }
            $('input[name=name]').val(place.name);
            $('input[name=lng]').val(place.geometry.location.lng());
            $('input[name=lat]').val(place.geometry.location.lat());
            $('input[name=place_id]').val(place.place_id);
            $('input[name=types_source]').val(place.types);
            if(typeof locationData.city != 'undefined')
                $('input[name=slug_city]').val(ChangeToSlug(locationData.city));
            if(typeof locationData.district != 'undefined')
                $('input[name=slug_district]').val(ChangeToSlug(locationData.district));

            geocodePosition(marker.getPosition());

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
        var arr = $.trim($('textarea[name=circle]').val());
        if(arr.length > 0){
            var bounds=  new google.maps.LatLngBounds();
            var arr_coords =$.parseJSON(arr);

            $.each(arr_coords, function (key,item) {
                var arr_temp = [];
                coord_polygon.push({'lat': parseFloat(item[1]), 'lng': parseFloat(item[0])});
                bounds.extend(new google.maps.LatLng(item[1], item[0]));
            });
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
            map.fitBounds(bounds);
            map.setCenter(bounds.getCenter());
            // map.getBoundsZoomLevel(bounds.getBounds());
            map.setZoom();
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

                        $.each($("select[name=district] option"), function(key, item){
                            if(new RegExp('[(.*?)\s]?'+locationData.district+"$",'igm').test($(item).text())){
                               $("select[name=district]").val($(item).attr('value')).change();
                               check = true;
                               return false;
                           }
                       });

                        if(!check){
                            alert('không lấy được thành phố');
                        }
                        

                    }
                });
            }
            
        });
        
        
        $('#save').on('click',function(){
            var name = $('input[name=name]').val();
            var lat = $('input[name=lat]').val();
            var lng = $('input[name=lng]').val();
            var types = $('select[name=types]').val();
            var city = $('select[name=city]').val();
            var district = $('select[name=district]').val();
            if(name.length != 0 && lat.length != 0 && lng.length != 0 && types != 'null' && city != 'null' && district != 'null'){
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
             if(types == 'null' ){
                 $('#types').show(); 
                 setTimeout(function() {
                    $("#types").hide('blind', {}, 500)
                }, 3000);
             }
             if(city == 'null' ){
                 $('#city').show(); 
                 setTimeout(function() {
                    $("#city").hide('blind', {}, 500)
                }, 3000);
             }
             if(district == 'null' ){
                 $('#district').show(); 
                 setTimeout(function() {
                    $("#district").hide('blind', {}, 500)
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