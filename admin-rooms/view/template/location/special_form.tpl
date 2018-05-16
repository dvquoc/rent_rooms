<?php echo $header; ?>

<script src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=places&language=vi&key=AIzaSyDDN318nA97mr0gEWZ0nd6SokteK0Y0w08" type="text/javascript"></script>
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
                            <h3 class="panel-title"><i class="fa fa-inbox"></i>Khu vực đặc biệt</h3>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-md-4">
                                    <label class="">Tên khu vực</label>
                                    <div class="dropdown">
                                        <input name="name" id="input-name" class="form-control " value="<?php echo $name; ?>">
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="col-sm-12 hidden">
                                <div class="dropdown">
                                    <input name="address" width="90%" id="input-address" class="form-control " value="<?php echo $address; ?>">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div id="map-address" style="width: 100%; height: 700px;"></div>
                                </div>
                                <div class="col-md-12">
                                    <h3 style="font-size: 18px; margin-top: 15px;">Hướng dẫn: </h3>
                                    <p>Kéo chấm đỏ trên bản đồ để cập nhật lại vị trí cho phòng trọ...</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </form>
    </div>
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
        // Create the search box and link it to the UI element.
        var input = document.getElementById('input-address');

        var searchBox = new google.maps.places.Autocomplete(input);
        input.style.margin = '20px';
        input.style.width = '50%';
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        var marker = new google.maps.Marker({
            position: {lat: <?php echo $lat ? $lat : '10.7654001'; ?>, lng: <?php echo $lng ? $lng : '106.6813622'; ?>},
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
            console.log(place);
            //geocodePosition({lat: place.geometry.location.lat(), lng: place.geometry.location.lng()});
            google.maps.event.addListener(marker, 'dragend', function() {
                geocodePosition(marker.getPosition());
            });
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

        $('.datetime').datetimepicker({
            pickDate: true,
            pickTime: true
        });
        $("#tab-general select").change(function () {
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
                        drawPolygon(JSON.parse(json['location']));
                    }
                });
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