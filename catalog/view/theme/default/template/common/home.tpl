<?php echo $header; ?>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=drawing,places" type="text/javascript"></script>
<style type="text/css">
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
    .pagination{
        top: 20px;
        right: 10px;
        position: absolute;
    }
    .pagination span{
        display: inline-block;
        padding: 2px;
        background-color: #019c44;
        border-radius: 3px;
        margin-right: 3px;
        width: 27px;
        text-align: center;
        font-size: 14px;
    }
    .house-overlay-item {
        background-color: #019c44;
        border: 1px solid #0b8841;
        width: 30px;
        height: 20px;
        position: relative;
        color: #adf3cb;
        font-weight: 600;
        text-align: center;
        line-height: 20px;
        border-radius: 3px;
        box-shadow: 0 2px 3px 0 rgba(0,0,0,.35);
        margin-left: -20px;
        margin-top: -20px;
        cursor: pointer;
    }

    .house-overlay-item:after{
        content: "";
        width: 0;
        height: 0;
        border-style: solid;
        border-width: 8px 6px 0 6px;
        border-color: #0b8841 transparent transparent transparent;
        bottom: -8px;
        left: 8px;
        position: absolute;
    }
    .ping-small .house-overlay-item{
        background-color: #00BA51;
        width: 10px;
        height: 10px;
        position: relative;
        color: #fff;
        text-align: center;
        line-height: 20px;
        border-radius: 100px;
        box-shadow: none;
        border: 1px solid #eaeaea;
        margin: -5px;
    }
    .ping-small .house-overlay-item:after{
        display: none;
    }
    .ping-small .house-overlay-item span{
        display: none;
    }
    .tippy-tooltip[data-template-id="#my-template-id"] {
        padding: 2rem;
        background: #fff;
    }
    #close-detail{
        position: absolute;
        z-index: 0;
        top: 10px;
        right: 10px;
        color: #333;
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
    #content-list{
        outline-offset: -6px;
        overflow-x: hidden;
        overflow-y: hidden;
    }
    #content-list:hover{
        overflow-y: auto;
    }
    #content-list::-webkit-scrollbar {
        width: 6px;
    }
    #content-list::-webkit-scrollbar-thumb {
        background-color: #888;
    }
    #content-list::-webkit-scrollbar-track {
        background-color: #f0f0f0;
    }
    .address{
        text-overflow: ellipsis;
        overflow: hidden;
        width: 100%;
        height: 1.2em;
        white-space: nowrap;
    }
    .more-info-list,.main-info-list{
        margin-top: 10px;
        text-align: right;
    }
    .more-info-list span.item-main{
        display: inline-block;
        padding: 0px 7px;
        margin-right: 3px;
        color: #fff;
        font-size: 13px;
        background-color: #00BA51;
        border-radius: 3px;
        line-height: 22px;
        float: left;
    }
    .more-info-list span.item-more{
        display: inline-block;
        padding:0 7px;
        margin-right: 3px;
        color: #333;
        font-size: 11px;
        background-color: #f7f7f7;
        border-radius: 3px;
        border: 1px solid #e4e4e4;
        line-height: 22px;
    }
    .item-listing:hover{
        background-color: #eee;
        cursor: pointer;
    }
    .button-map.active{
        background-color: rgb(3, 169, 244) !important;
        color: #fff;
    }
    .guid-map{
        top: auto;
    }
</style>
<!--declare-->
<div class="contain-map" style="position: relative">
    <div id="test1" class="gmap3 col-md-12" style="width: 100%; height:950px"></div>
    <div id="show-detail" class="col-md-3" style="display:none; z-index: 2; border-radius: 3px; position: absolute; right:10px; top:10px; height: 100%; background-color: #fff; padding: 0px; box-shadow: rgba(0, 0, 0, 0.23) 0px 0px 6px 1px">
        <div class="inner" style="position: relative">
            <div id="close-detail">
                <button class="widget-pane-toggle-button noprint"><i class="glyphicon glyphicon-chevron-right"></i></button>
            </div>
            <div class="img"><img style="border-radius: 3px 3px 0px 0px;" id="detail-img" src="http://lophocthietke.com/wp-content/uploads/2016/06/hoc-thiet-ke-quang-cao-tai-ha-noi.jpg" height="300px" width="100%"> </div>

            <div class="col-md-12" style=" background-color: #fff;">
                <h3 style="margin-top: -42px; background-color: #03a9f4c7; color: #fff; padding: 10px" id="detail-title">Tiêu đề</h3>
                <p style="background-color: #eee; margin: 15px 0px; border: 1px solid #eee; padding: 5px 8px;" id="detail-address"><b>Địa chỉ: </b><span></span></p>
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
                <div class="text-center"><div style="padding: 10px; background-color: #0199de; color: #fff; margin: 10px 0px;">Liên hệ chủ nhà - Gặp: Chị Hương</div></div>
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
    <div id="show-list" class="col-md-3" style="overflow: hidden; border-radius: 3px; position: absolute; right:10px; top:10px; height: 100%; background-color: #fff; padding: 0px; box-shadow: rgba(0, 0, 0, 0.23) 0px 0px 6px 1px">
        <div class="inner" style="position: relative">
            <div class="results-heading" style="position: relative; padding: 10px; background-color:#00BA51; color: #fff; font-size: 18px; padding: 20px 10px;">
                <span class="results-heading-title">(<b><?php echo count($listing); ?></b>) Kết quả tìm kiếm</span>
                <div class="pagination"><span>1</span><span>2</span><span>3</span>...<span>10</span></div>
            </div>
            <div id="content-list">
                <?php foreach($listing as $item) { ?>
                <div class="item-listing" style="height: 125px; overflow: hidden; ">
                    <div class="inner-item" style="padding: 12px; border-bottom: 1px solid #eee;" id="item_<?php echo $item['_id']; ?>">
                        <?php  $img = json_decode($item["photo"],true);  ?>
                        <div class="img-item" style="float: left; ">
                            <img src="<?php echo  $img[0]['link'] ?>" width="100px" height="70px">
                        </div>
                        <div class="info" style="margin-left: 115px;">
                            <h4 class="title"><?php echo $item["title"]; ?></h4>
                            <div class="address"><?php echo $item["address"]; ?></div>
                            <div class="more-info-list">
                                <span class="item-main">1.5 tr</span>
                                <span class="item-main">12 m2</span>
                                <span class="item-more">Cách 30m</span>
                                <span class="item-more">Tự do giờ giấc</span>
                            </div>
                        </div>
                    </div>
                </div>
                <?php } ?>
            </div>
        </div>
    </div>
</div>
<div id="guidMap" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Hướng dẫn</h4>
            </div>
            <div class="modal-body">
                <p>One fine body&hellip;</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="/public/assets/js/map-function.js" type="text/javascript"></script>
<script type="text/javascript">
    var region = <?php echo json_encode($region); ?>;
    var listing = <?php echo json_encode($listing); ?>;
    var polygon = [];
    var zoom = <?php echo $zoom; ?>;
    var eleMap = "#test1";
    var firstWidth = $(eleMap).outerWidth(true);
    $.each(region,function(key,item){
        polygon.push([item[1],item[0]]);
    });
    $(document).ready(function () {
        $("#close-detail").click(function () {
            $("#show-detail").toggle();
        });
    });
    $(eleMap).css({'height': ($(window).height() - $("#menu-main").outerHeight(true))});
    $("#show-detail").css({'height': ($(window).height() - $("#menu-main").outerHeight(true)) - 20});
    $("#show-list").css({'height': ($(window).height() - $("#menu-main").outerHeight(true)) - 20});
    $("#content-list").css({'height': $("#show-list").outerHeight(true) - ($("#results-heading").outerHeight(true) + 60)});
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
                content : '<div data-toggle="popover" class="pin-overlay house-overlay-item pin_'+item._id.$oid+'" data-tippy-html="#item_'+item._id.$oid+'" title="'+item.title+'"><span> 1.2 </span></div>',
                offset : {x: 0 , y:0},
                draggable:true,
            }
        });
    });
    var optionsMap = {
        zoomControl: true,
        zoomControlOptions: {
            position: google.maps.ControlPosition.LEFT_TOP
        },
        scaleControl: false,
        fullscreenControl: false,
        mapTypeControl: false,
        zoom:zoom,
        streetViewControl: false,
        overviewMapControl: true,
        scrollwheel: true,
        disableDoubleClickZoom: true,
        center: bounds.getCenter(),
        draws: polygon,
        controlCustom:['draw-line','draw-popygon'],
        overlays: {
            values: markers_data,
            events: {
                click: function (overlay, event, context) {
                    $(event.target).css({'background-color':'#00a1ff'});
                    var ov = new google.maps.OverlayView();
                    ov.onAdd = function() {
                        var proj = this.getProjection();
                        var aPoint = proj.fromLatLngToContainerPixel(overlay.getPosition());
                        aPoint.x = aPoint.x + $("#show-list").width()/2;
                        _m.panTo(proj.fromContainerPixelToLatLng(aPoint));
                    }
                    ov.draw = function() {};
                    ov.setMap(_m);

                    $("#detail-title").text(context.data.title);
                    $("#show-detail").show();
                    var imgs = JSON.parse(context.data.photo);
                    var img = imgs[0];
                    $("#detail-img").attr('src',img.link);
                    $("#detail-address span").text(context.data.address);
                    var imgs = JSON.parse(context.data.photo);

                },
                mouseover: function (overlay, event, context) {

                },
                mouseout: function (overlay, event, context) {
                }
            }
        }
    };
    var map = $("#test1").mapRooms(optionsMap);
    //map.mapRooms('test');
</script>
