var eMap = getId('test1');
var eShowDetail = getId('show-detail');
var eShowList = getId('show-list');
var eContentList = getId('content-list');
var firstWidth = eMap.outerWidth;
if(region!=null){
    region.forEach(function(item,key) {
        polygon.push([item[1],item[0]]);
    });
}

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
var region = [];
$.each(polygon,function(key,item){
    region.push([parseFloat(item[1]),parseFloat(item[0])]);
});
var markers_data = [];
var bounds = new google.maps.LatLngBounds();

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
    center: new google.maps.LatLng(center[1], center[0]),
    draws: region,
    controlCustom:['draw-line','draw-popygon'],

};
var mapRooms_data = new mapRooms($("#test1"),optionsMap);


