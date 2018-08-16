<?php if(!empty($rooms)) { ?>
<?php foreach($rooms as $key=>$item) { ?>
<div class="row" i-column" itemscope="" itemtype="http://schema.org/Product">
<?php
    $slugName = urlencode(str_replace(' ','-',trim($item["slug"])));
    $slugDistrict = urlencode(str_replace(' ','-',trim($item["slug_district"])));
    $slugCity = urlencode(str_replace(' ','-',trim($item["slug_city"])));
            
    $date_current = date('d/m/Y',time());
    $str_date_update = (string)$item['date_update'];
    $date_update= date('d/m/Y',$str_date_update);
    $day = strtotime($date_current) - strtotime($date_update);
    
    if($day == 0 ){
        $time = date('H:i:s',($str_date_update));
    }else{
        $time = ($day > 10)? date('d/m/Y',($str_date_update)):$day;
    }   
?>
<a itemprop="url" href="<?php echo '/phong-tro-'.$slugDistrict.'/'.$slugCity.'/'.$slugName.'-code-'.(string) $item["_id"]; ?>" class="inner-item<?php echo ($key < 3) ? ' is-ads':''; ?>">
<div class="dropdown">
    <button class="context-menu-button icon" data-toggle="dropdown" id="dropdownMenu<?php echo $item['_id']; ?>"
            aria-haspopup="true" aria-expanded="true">test
    </button>
    <ul style="right: 0; left: auto" class="dropdown-menu" aria-labelledby="dropdownMenu<?php echo $item['_id']; ?>"
        style="display: none;">
        <li class="item"><span href="javascript:;"> Lưu xem sau</span></li>
        <li class="item"><span href="javascript:;">Chia sẽ</span></li>
    </ul>
</div>
<div class="col-md-3 list-img">
    <?php  $img = json_decode($item["images"],true); ?>
    <img itemprop="image" alt="PHÒNG TRỌ CHO NAM ĐẦY ĐỦ TIỆN NGHI 1T3NGƯỜI QUẬN 4"
         src="http://www.justitiarul.ro/wp-content/themes/ar2-d57c18d/images/empty_thumbnail.gif"
         onerror="this.src='http://www.justitiarul.ro/wp-content/themes/ar2-d57c18d/images/empty_thumbnail.gif"
         data-src="<?php echo $img[0]['link'];?>" class="lazy img-responsive">
</div>
<div class="col-md-9 list-info pull-right">
    <h3 itemprop="name" class="title"><b><?php echo $item['name'];?> <?php echo $item['name'];?></b></h3>
    <div class="f-i">
        <div class="i d">
            Ngày đăng: <span><?php echo $time;?></span>
        </div>
        <?php if(isset($has_point)) { ?>
        <div class="i d">
            Cách khoản: <span
                    style="background-color: #1f6aae;color: #fff;padding: 2px 4px;border-radius: 2px;"><?php echo ($item['calculated']>
                1000 ? round($item['calculated']/1000,1).' km': round($item['calculated'],0).' m') ?> </span>
        </div>
        <div class="i d">
            <span class="direction-point" data-lat="<?php echo $item['location']['coordinates'][1] ?>"
                  data-lgn="<?php echo $item['location']['coordinates'][0] ?>"
                  style="background-color: #00ba51;color: #fff;padding: 2px 4px;border-radius: 2px;"><i
                        class="fa fa-level-down"></i> chỉ đường</span>
        </div>
        <?php } ?>
    </div>
    <div class="adress" itemprop="address" itemscope=""
         itemtype="http://schema.org/PostalAddress"><?php echo $item['address'];?></div>
    <div class="mf" itemprop="offers" itemscope="" itemtype="http://schema.org/Offer">
        <div class="i price" itemprop="price" content="<?php echo $item['price']/1000000;?>">
            <i class="fa fa-shopping-cart hidden" aria-hidden="true"></i><b><?php echo $item['price']/1000000;?></b>
            Triệu/tháng
        </div>
        <div class="i are">
            <i class="fa fa-area-chart hidden" aria-hidden="true"> </i>
            <b><?php echo $item['acreage'];?></b> m2
        </div>
        <div class="i are"> |</div>
        <div class="i are">
            Tiền nước:
            <i class="fa fa-area-chart hidden" aria-hidden="true"> </i>
            <b><?php echo $item['price_water'];?></b> khối / người
        </div>
        <div class="i are">
            Tiền điện:
            <i class="fa fa-area-chart hidden" aria-hidden="true"> </i>
            <b><?php echo $item['price_electricity'];?></b> kw
        </div>
    </div>

    <button class="btn call-button"><i class="fa fa-phone" aria-hidden="true"></i></button>
</div>
<div class="clearfix"></div>
</a>
</div>
<?php } ?>
<?php }else{ ?>
<div class="text-center">
    <img alt="No homes found" src="//static.trulia-cdn.com/images/search-web/no_results.svg">
    <h3>Rất tiếc ! Chúng tôi đã không tìm thấy phòng trọ nào</h3>
</div>
<?php } ?>
<div id="modal-direction" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="background-color:#00ba51;">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="color: #fff; " id="gridSystemModalLabel">
                    <div id="floating-panel">
                        <select id="mode" style="font-size: 13px; background-color: #00a247; border:0px; padding: 5px; border-radius: 3px; color:#fff;">
                            <option value="TRANSIT">Xe buýt</option>
                            <option value="DRIVING">Xe hơi</option>
                            <option value="BICYCLING">Xe đạp</option>
                            <option value="WALKING">Đi bộ</option>
                        </select>
                    </div>
                </h4>
            </div>
            <div class="modal-body" style="padding: 0px;">
                <div class="row">
                    <div class="col-md-8" style="padding-right: 0px;">
                        <div id="map-direction" style="width:100%; height: 500px;"></div>
                    </div>
                    <div class="col-md-4">
                        <div id="route-dicrection" style="height: 500px; overflow-y:scroll; padding-right: 15px;">
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
</div>
<div id="modal-phone" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div id="show-phone" class="text-center">
                            <h1 style="margin-bottom: 10px; color: #000"><b>0897 567 070</b></h1>
                            <p style="margin: 0;">Hãy gọi vào giờ làm việc 24/7</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<?php if(isset($has_point)) {  ?>
<script type="text/javascript">
    var from = <?php echo json_encode($point); ?>;
    function initMap(position) {
        var directionsDisplay = new google.maps.DirectionsRenderer;
        var directionsService = new google.maps.DirectionsService;
        var map = new google.maps.Map(document.getElementById('map-direction'), {
            zoom: 13,
            center: { lat: 10.8522445, lng: 106.7585893 },
            zoom: 14,
            scaleControl: false,
            fullscreenControl: false,
            mapTypeControl: false,
            streetViewControl: false,
            overviewMapControl: true,
            scrollwheel: true,
            disableDoubleClickZoom: true
        });
        directionsDisplay.setMap(map);
        directionsDisplay.setPanel(document.getElementById('route-dicrection'));

        document.getElementById('mode').addEventListener('change', function() {
            calculateAndDisplayRoute(directionsService, directionsDisplay,position);
        });
        calculateAndDisplayRoute(directionsService, directionsDisplay,position);
    }

    function calculateAndDisplayRoute(directionsService, directionsDisplay,position) {
        var selectedMode = document.getElementById('mode').value;
        directionsService.route({
            origin:   {lat:  from.lat, lng: from.lng},
            destination:  {lat: position[0], lng: position[1]},
            travelMode: google.maps.TravelMode[selectedMode]
        }, function(response, status) {
            if (status === 'OK') {
                directionsDisplay.setDirections(response);
            } else {
                window.alert('Đã có lỗi sảy ra ' + status);
            }
        });
    }
    $(".direction-point").click(function (event) {
        event.preventDefault()
        var sefl = $(this);
        $('#modal-direction').modal('show');
        $('#modal-direction').on('shown.bs.modal', function () {
            $("#route-dicrection").html("");
            initMap([sefl.data('lat'),sefl.data('lgn')]);
        });
    });
</script>
<?php } ?>
<script type="text/javascript">
    $(document).ready(function() {
        $('.call-button').click(function (event) {
            event.preventDefault();
            $("#modal-phone").modal('show');
        });
        $('.context-menu-button').click(function (event) {
            event.preventDefault();
        });
    });
</script>