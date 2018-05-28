<?php echo $header; ?>

<link href="/public/assets/css/list-map-page.css" rel="stylesheet" type="text/css">
<!--declare-->
<div class="contain-map contain-fluid-full" style="position: relative">
    <div id="test1" class="gmap3" style="width: 100%; height:950px"></div>
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
    <div id="show-list" class="col-md-3" style="border-radius: 3px; position: absolute; right:10px; top:10px; height: 100%; background-color: #fff; padding: 0px;box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;">
        <div style="position: absolute; left: -167px; top: 0px; z-index: 1; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px;">
            <button class="btn" style="background-color: #fff" data-toggle="tooltip" data-placement="bottom" title="Chúng tối hỗ trợ bạn xem ở chế độ danh sách">
                <i class="glyphicon glyphicon-list-alt" style="margin-right: 2px;"></i>
                Xem dạng danh sách
            </button>
        </div>
        <div class="inner" style="position: relative; overflow: hidden; height: 100%">
            <div class="results-heading" style="position: relative; padding: 10px; background-color:#00BA51; color: #fff; font-size: 18px; padding: 20px 10px;">
                <span class="results-heading-title">(<b><?php echo count($listing); ?></b>) Kết quả tìm kiếm</span>
                <div class="pagination"><span>1</span><span>2</span><span>3</span>...<span>10</span></div>
            </div>
            <div id="content-list">
                <?php foreach($listing as $item) { ?>
                <div class="item-listing" style="height: 125px; overflow: hidden; ">
                    <div class="inner-item" style="padding: 12px; border-bottom: 1px solid #eee;" id="item_<?php echo $item['_id']; ?>">
                        <?php  $img = json_decode($item["images"],true);  ?>
                        <div class="img-item" style="float: left; ">
                            <img src="<?php echo  $img[0]['link'] ?>" width="100px" height="70px" onerror="this.src='http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg'">
                        </div>
                        <div class="info" style="margin-left: 115px;">
                            <h3 class="title" style="margin-bottom: 3px;"><?php echo $item["name"]; ?></h3>
                            <div class="address" style="font-size: 13px"><?php echo $item["address"]; ?></div>
                            <div class="more-info-list">
                                <span class="item-main"><?php echo $item["price"]/1000000; ?> tr</span>
                                <span class="item-main"><?php echo $item["acreage"]; ?> m2</span>
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
<div id="addRoom" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Nhập thông tin</h4>
            </div>
            <div class="modal-body">
                <p>Nhập thông tin trọ</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Thêm phòng trọ</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script src="/public/assets/js/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="/public/assets/js/bootstrap/js/bootstrap.min.js" defer type="text/javascript"></script>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=drawing,places" type="text/javascript"></script>
<script src="/public/assets/js/map-function.js" type="text/javascript"></script>
<script src="/public/assets/js/list-map-page.js" defer type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });
    var region = <?php echo json_encode($region); ?>;
    var listing = <?php echo json_encode($listing); ?>;
    var polygon = [];
    var zoom = <?php echo $zoom; ?>;
    var getId = function(id) {
        return document.getElementById(id);
    }
    var getClass = function(c) {
        return document.getElementsByClassName(c);
    }
    /* showHide is function from jquery */
    var showHide = function( elements, show ) {
        var display, elem,
            values = [],
            index = 0,
            length = elements.length;

        // Determine new display value for elements that need to change
        for ( ; index < length; index++ ) {
            elem = elements[ index ];
            if ( !elem.style ) {
                continue;
            }

            display = elem.style.display;
            if ( show ) {

                // Since we force visibility upon cascade-hidden elements, an immediate (and slow)
                // check is required in this first loop unless we have a nonempty display value (either
                // inline or about-to-be-restored)
                if ( display === "none" ) {
                    values[ index ] = dataPriv.get( elem, "display" ) || null;
                    if ( !values[ index ] ) {
                        elem.style.display = "";
                    }
                }
                if ( elem.style.display === "" && isHiddenWithinTree( elem ) ) {
                    values[ index ] = getDefaultDisplay( elem );
                }
            } else {
                if ( display !== "none" ) {
                    values[ index ] = "none";

                    // Remember what we're overwriting
                    dataPriv.set( elem, "display", display );
                }
            }
        }

        // Set the display of the elements in a second loop to avoid constant reflow
        for ( index = 0; index < length; index++ ) {
            if ( values[ index ] != null ) {
                elements[ index ].style.display = values[ index ];
            }
        }

        return elements;
    }
</script>
</div>
