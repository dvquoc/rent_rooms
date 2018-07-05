var eMap = getId('test1');
var eShowDetail = getId('show-detail');
var eShowList = getId('show-list');
var eContentList = getId('content-list');
var firstWidth = eMap.outerWidth;
region.forEach(function(item,key) {
    polygon.push([item[1],item[0]]);
});
$(document).ready(function () {
    $("#close-detail").click(function () {
        $("#show-detail").toggle();
    });
});
var heightShow = window.innerHeight;

eMap.style.height =  heightShow - getId('menu-main').offsetHeight  + 'px';
eShowDetail.style.height = ((heightShow - getId('menu-main').offsetHeight) - 20) + 'px';
eShowList.style.height =  ((heightShow - getId('menu-main').offsetHeight) - 20) + 'px';
eContentList.style.height =  (eShowList - getClass('results-heading')[0].offsetHeight + 60) + 'px';

$("#content-detail").css({'height': $(eShowDetail).outerHeight() - 250});

var markers_data = [];
var bounds = new google.maps.LatLngBounds();
listing.forEach(function(item,key){
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
                event.target.style.backgroundColor ='#00a1ff';
                var ov = new google.maps.OverlayView();
                ov.onAdd = function() {
                    var proj = this.getProjection();
                    var aPoint = proj.fromLatLngToContainerPixel(overlay.getPosition());
                    aPoint.x = aPoint.x + $("#show-list").width()/2;
                    _m.panTo(proj.fromContainerPixelToLatLng(aPoint));
                }
                ov.draw = function() {};
                ov.setMap(_m);
                getId('detail-title').text(context.data.title);
                showHide('show-detail',true);
                var imgs = JSON.parse(context.data.photo);
                var img = imgs[0];
                getId('detail-img').setAttribute('src',img.link);
                getId('detail-address span')[0].textContent(context.data.address);
                var imgs = JSON.parse(context.data.photo);
            },
            mouseover: function (overlay, event, context) {

            },
            mouseout: function (overlay, event, context) {
            }
        }
    }
};
var mapRooms_data = new mapRooms($("#test1"),optionsMap);
