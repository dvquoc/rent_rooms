<?php echo $header; ?>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
<script src="/public/assets/js/map/gmap3.js" type="text/javascript"></script>
<script src="/public/assets/plugins/tippyjs/tippy.all.min.js" type="text/javascript"></script>
<script src="/public/assets/plugins/slide_reveal/slidereveal.js" type="text/javascript"></script>
<link href="/public/assets/plugins/tippyjs/tippy.css" rel="stylesheet">
<link href="/public/assets/plugins/tippyjs/themes/light.css" rel="stylesheet">
<style type="text/css">
    .house-overlay-item{
        background-color: #0d5a84;
        width: 40px;
        height: 20px;
        position: relative;
        color: #fff;
        text-align: center;
        line-height: 20px;
        border-radius: 2px;
        box-shadow: 0 2px 3px 0 rgba(0,0,0,.35);
    }
    .house-overlay-item:after{
        content: "";
        width: 0;
        height: 0;
        border-style: solid;
        border-width: 8px 5px 0 5px;
        border-color: #0d5a84 transparent transparent transparent;
        bottom: -8px;
        left: 15px;
        position: absolute;
    }
    .tippy-tooltip[data-template-id="#my-template-id"] {
        padding: 2rem;
        background: #fff;
    }
    #close-detail{
        position: absolute;
        z-index: 0;
        top: 8px;
        left: 100%;
    }
    .widget-pane-toggle-button{
        width: 23px;
        height: 48px;
        cursor: pointer;
        border-left: 1px solid #D4D4D4;
        box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.3);
        margin: 0;
        padding: 0;
        border: 0;
        border-radius: 0;
        outline: 0;
        font: inherit;
        vertical-align: baseline;
        background: #ffffffd6;
        list-style: none;
        overflow: visible;
    }
    .popover{
        max-width: 300px;
        width: 300px;
    }
</style>
<!--declare-->
<div class="contain-map" style="position: relative">
    <div id="test1" class="gmap3 col-md-12" style="width: 100%; height:950px"></div>
    <div id="show-detail" class="col-md-4" style="background-color: #fff; padding: 0px; box-shadow: 1px 0px 94px -42px #000;">
        <div class="inner" style="position: relative">
            <div id="close-detail">
                <button class="widget-pane-toggle-button noprint"></button>
            </div>
            <div class="img"><img id="detail-img" src="http://lophocthietke.com/wp-content/uploads/2016/06/hoc-thiet-ke-quang-cao-tai-ha-noi.jpg" height="300px" width="100%"> </div>
            <br>
            <div class="col-md-12">
                <h3 id="detail-title">Tiêu đề</h3>
                <p style="margin: 15px 0px; border: 1px solid #eee; padding: 5px 8px;" id="detail-address"><b>Địa chỉ: </b><span></span></p>
                <div class="row">
                    <div id="detail-price" class="col-md-6">
                        <p><b>Giá cho thuê: </b><span>1.2 triệu/tháng</span></p>
                    </div>
                    <div id="detail-area" class="col-md-6">
                        <p><b>Diện tích: </b><span>15 m2</span></p>
                    </div>
                </div>
                <div class="row">
                    <div id="detail-water" class="col-md-6">
                        <p><b>Tiền cọc: </b><span>1 trệu <i style="font-size: 11px; color: red"> (hoàn tháng cuối)</i></span></p>
                    </div>
                    <div id="detail-price" class="col-md-6">
                        <p><b>Toilet: </b><span>Trong nhà</span></p>
                    </div>
                </div>
                <div class="row">
                    <div id="detail-water" class="col-md-6">
                        <p><b>Tiền nước: </b><span>15.000/khối</span></p>
                    </div>
                    <div id="detail-price" class="col-md-6">
                        <p><b>Tiền điện: </b><span>3000/kg</span></p>
                    </div>
                </div>
                <div class="row">
                    <div id="detail-water" class="col-md-6">
                        <p><b>Số lượng người ở: </b><span>3/người</span></p>
                    </div>
                    <div id="detail-price" class="col-md-6">
                        <p><b>Toilet: </b><span>Trong nhà</span></p>
                    </div>
                </div>
                <div class="text-center"><div style="padding: 10px; background-color: #f89406; color: #fff; margin: 10px 0px;">Liên hệ chủ nhà - Gặp: Chị Hương</div></div>
                <p class="alert text-center alert-danger"> Giờ giấc tự do</p>
                <p id="detail-des">
                    <b>Nội quy: </b>
                    A common use of JSON is to exchange data to/from a web server.
                    When receiving data from a web server, the data is always a string.
                    Parse the data with JSON.parse(), and the data becomes a JavaScript object...
                </p>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid-full hidden">
    <div class="row">
        <?php foreach($listing as $item) { ?>
        <div class="item-listing col-md-4">
            <div class="inner-item" id="item_<?php echo $item['_id']; ?>">
                <?php  $img = json_decode($item["photo"],true);  ?>
                <div class="img-item" >
                    <img src="<?php echo  $img[0]['link'] ?>" width="200px" height="200px">
                </div>
                <h3 class="title"><?php echo $item["title"]; ?></h3>
            </div>
        </div>
        <?php } ?>
    </div>
</div>
<script src="/public/assets/js/map-function.js" type="text/javascript"></script>
<script type="text/javascript">
    $('#show-detail').slideReveal();
    var region = <?php echo json_encode($region); ?>;
    var listing = <?php echo json_encode($listing); ?>;
    var polygon = [];
    var zoom = <?php echo $zoom; ?>;
    var eleMap = "#test1";
    var firstWidth = $(eleMap).outerWidth(true);
    $.each(region,function(key,item){
        polygon.push([item[1],item[0]]);
    });
    $(function(){
        var slider = $("#show-detail").slideReveal({
            width: "33.333333333333%",
            position:'left',
            shown: function(sliders, trigger){
                var currentWidth =  firstWidth - slider.data('slide-reveal-model').getWidth();
                $(eleMap).css({'width': currentWidth+23});
            }
        });
        $("#close-detail").click(function () {
            slider.slideReveal("toggle");
        });
        $(eleMap).css({'height': $(window).height()});
        var markers_data = [];
        var bounds = new google.maps.LatLngBounds();
        $.each(listing,function(key,item){
            bounds.extend(new google.maps.LatLng(item.location.coordinates[1],item.location.coordinates[0]));
            markers_data.push({
                latitude: item.location.coordinates[1],
                longitude: item.location.coordinates[0],
                latLng: [item.location.coordinates[1], item.location.coordinates[0]],
                data:item,
                options:{
                    pane: "floatPane",
                    content : '<div data-toggle="popover" class="pin-overlay house-overlay-item pin_'+item._id.$oid+'" data-tippy-html="#item_'+item._id.$oid+'" title="'+item.title+'"><span>1,2 tr</span></div>',
                    offset : {x: -20 , y:-20},
                    draggable:true,
                }
            });
        });
        var optionsMap = {
            scaleControl: false,
            fullscreenControl: false,
            mapTypeControl: false,
            zoom:zoom,
            streetViewControl: false,
            overviewMapControl: true,
            scrollwheel: true,
            disableDoubleClickZoom: true,
            center: bounds.getCenter(),
            markers: markers_data,
            draws: polygon,
            overlay: {
                values: markers_data,
                events: {
                    click: function (overplay, event, context) {
                        console.log(event[0].target);
                        $(event.target).css({'background-color':'#00a1ff'});
                        this.data('mapRooms').map.panTo(overplay.getPosition());
                        $("#detail-title").text(context.data.title);
                        var imgs = JSON.parse(context.data.photo);
                        var img = imgs[0];
                        console.log(context);
                        $("#detail-img").attr('src',img.link);
                        $("#detail-address span").text(context.data.address);
                        slider.slideReveal("show");
                        $(event[0].target).popover('hide');
                        var imgs = JSON.parse(context.data.photo);
                        console.log(imgs);
                        var img = imgs[0];
                        var option = {
                            title: context.data.address,
                            content: "<img class='img-responsive' src='"+img.link+"'/>",
                            html: true,
                            placement: "top",
                            trigger: "click"
                        };
                        $(event[0].target).popover(option).popover('show');
                    },
                    mouseover: function (overlay, event, context) {
                    },
                    mouseout: function (overlay, event, context) {
                        $(event[0].target).popover('hide');
                    },
                }
            }
        };
        var map = $("#test1").mapRooms(optionsMap);
        map.mapRooms('test');
        // var mapAction = MapLocal.initMap('test1',optionsMap);
        // mapAction.marker_draw(markers_data);
    });
</script>