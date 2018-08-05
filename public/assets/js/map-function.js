function isObject(m) {
    return typeof m === "object";
};

function isString(m) {
    return typeof m === "string";
};

function isNumber(m) {
    return typeof m === "number";
};

function isUndefined(m) {
    return m === undef;
};

function tuple(args, value) {
    var k, i,
        keys = ["data", "tag", "id", "events", "onces"],
        td = {};

    // "copy" the common data
    if (args.td) {
        for (k in args.td) {
            if (args.td.hasOwnProperty(k)) {
                if ((k !== "options") && (k !== "values")) {
                    td[k] = args.td[k];
                }
            }
        }
    }
    // "copy" some specific keys from value first else args.td
    for (i = 0; i < keys.length; i++) {
        copyKey(td, keys[i], value, args.td);
    }

    // create an extended options
    td.options = $.extend({}, args.opts || {}, value.options || {});

    return td;
};

function attachEvents(map, $container, options, object, div) {
    var td = options || {},
        context = {
            data: options.data,
            ele: $container
        };

    function bind(items, handler) {
        if (items) {
            $.each(items, function (name, f) {
                var self = $container, fn = f;
                if ($.isArray(f)) {
                    self = f[0];
                    fn = f[1];
                }
                handler(object, name, function (event) {
                    fn.apply(div, [object, event, context]);
                });
            });
        }
    }

    bind(td.events, google.maps.event.addListener);
    bind(td.onces, google.maps.event.addListenerOnce);
};

function controlAttachEvents(events, object, handler) {
    function bind(items, handler) {
        if (items) {
            $.each(items, function (name, f) {
                var fn = f, self = object;
                if ($.isArray(f)) {
                    self = f[0];
                    fn = f[1];
                }
                handler(self, name, function (event) {
                    fn.apply(self, [event, self]);
                });
            });
        }
    }

    if (events)
        bind(events, handler);
};

function OverlayView(map, $div, opts=null) {
    var self = this,
        listeners = [];
    self.setMap(map);
    self.onAdd = function () {
        var panes = self.getPanes();
        if ($div.hasClass('canvas-marker')){
            panes.overlayImage.appendChild($div.get(0));
            console.log($div.get(0));
            //$(panes['overlayLayer']).append($div);
            $div.get(0).addEventListener("mousemove", function(){

            });
        }
        else{
            $(panes['floatPane']).html("");
            $(panes['floatPane']).append($div);
            if($div.attr('id') == 'pin-container'){
                $.each($div.find('.pin-overlay'),function (key,item) {
                    $.each("dblclick click mouseover mousemove mouseout mouseup mousedown".split(" "), function (i, name) {
                        listeners.push(
                            google.maps.event.addDomListener($(item)[0], name, function (e) {
                                $.Event(e).stopPropagation();
                                google.maps.event.trigger(self, name, [e]);
                            })
                        );
                    });
                });

            }

        }
    };
    self.draw = function () {
        if($div.attr('id') == 'pin-container'){
            $.each($div.find('.pin-overlay'),function (key,item) {
                var position = new google.maps.LatLng($(item).data('lat'), $(item).data('lgn'));
                var ps = self.getProjection().fromLatLngToDivPixel(position);
                if (!$div.hasClass('canvas-marker'))
                    $(item).css("left", (ps.x) + "px").css("top", (ps.y) + "px").fadeIn(300);
            });

        }
    };
    self.onRemove = function () {
        var i;
        for (i = 0; i < listeners.length; i++) {
            google.maps.event.removeListener(listeners[i]);
        }
        $div.remove();
    };
    self.hide = function () {
        $div.hide();
    };
    self.show = function () {
        $div.show();
    };
    self.toggle = function () {
        if ($div) {
            if ($div.is(":visible")) {
                self.hide();
            } else {
                self.show();

            }
        }
    };
    self.toggleDOM = function () {
        self.setMap(self.getMap() ? null : map);
    };
    self.getDOMElement = function () {
        return $div[0];
    };

}

var _Canvas = function (element) {
    this.canvas = document.createElement("canvas");
    this.context = this.canvas.getContext('2d');
    this.canvas.id = "display";
    var style = {'height':300};
    for (var index in style) {
        this.canvas[index] = style[index];
    }
    element == undefined ? document.body.appendChild(this.canvas) : element.appendChild(this.canvas);
    this.canvas.addEventListener("click", this.click.bind(this), false);
}
_Canvas.prototype.of = function (mouse) {
    alert("x: " + mouse[0] + ", y: " + mouse[1]);
}
_Canvas.prototype.click = function (e) {
    this.mouse = [e.clientX, e.clientY];
    return this.of(this.mouse);
}
/* Add event click */
function isIntersect(mp,p) {
    return Math.sqrt((mp.x-p.x) ** 2 + (mp.y - p.y) ** 2) < 6;
}
/* Add event click */
function isInTooltip(mp,o,p) {
    if(
        (mp.x < o.offset().left
            || mp.x > o.offset().left + o.width())
        ||(mp.y < o.offset().top
            ||((mp.y > o.offset().top + o.height()- 26) && ((mp.x < p.x - 10) || ( mp.x > p.x + 10)) ))
    )
        return false;
    return true;
}
var _m, _mr, polygon_history = [], overlays = [], _bounds = null, _canvas = null, nubLayout = 10, layoutEleData=[];
var data_maker = [];
var class_ov = new google.maps.OverlayView();
var polygonOptions = {
    strokeColor: '#FF0000',
    strokeOpacity: 0.8,
    strokeWeight: 1,
    fillColor: '#FF0000',
    fillOpacity: 0.08,
    draggable: false,
    clickable: false
};
var _pl = new google.maps.Polyline(polygonOptions);
var _p = new google.maps.Polygon(polygonOptions);
var drawingManager = new google.maps.drawing.DrawingManager({
    drawingMode: google.maps.drawing.OverlayType.POLYGON,
    drawingControl: false,
    polygonOptions: polygonOptions
});
var mapRooms = function ($el, options) {
    var seft = this;
    this.bounds = new google.maps.LatLngBounds();
    this.infowindow = new google.maps.InfoWindow();
    var setting = {
        center: [10.7522818, 106.4810371],
        zoom: 14,
        scaleControl: false,
        fullscreenControl: false,
        mapTypeControl: false,
        streetViewControl: false,
        overviewMapControl: true,
        scrollwheel: true,
        disableDoubleClickZoom: true,
        makers: null,
        trigger: undefined,
        mousemove: function () {
        },
        mouseup: function () {
        },
        mousedown: function () {
        },
        click: function () {
        },
        hover: function () {
        },

    };
    this.setting = $.extend(setting, options);
    this.map = _m = new google.maps.Map($el.get(0), this.setting);
    this.element = $el;
    if (!OverlayView.__initialised) {
        OverlayView.prototype = class_ov;
        OverlayView.__initialised = true;
    }
    this.init();
};
// Add prototype for mapRooms and public function in this prototype
$.extend(mapRooms.prototype, {
    init: function () {
        _mr = this;
        this.controlCustomMap();
        this.eventMap();
        _mr.setOptionForMap({draggable:true,showInforMap:'off'});
        //_mr.overlay(this.setting.overlays);
        _mr.drawPolygon(this.setting.draws,true,false);
    },
    eventMap:function () {
        /* Zoom change */
        _m.addListener('zoom_changed', function () {
            if (_m.getZoom() <= 13 && !$('.pin-overlay').parent('div').hasClass("ping-small"))
                $('.pin-overlay').parent('div').addClass('ping-small');
            if (_m.getZoom() >= 13 && $('.pin-overlay').parent('div').hasClass("ping-small"))
                $('.pin-overlay').parent('div').removeClass('ping-small');
            if(typeof canvas != "undefined" && _canvas!=null)
                _canvas.clearRect(0, 0, _mr.element.width(), _mr.element.height());
            $("#toolip-detail-on-pin").fadeOut('fast');
            $("#toolip-detail-on-pin").find('.arrow').fadeOut('fast');
        });

        /* mouseover Event */
        _m.addListener('mouseover', function () {
            $('[data-toggle="tooltip"]').tooltip();
        });

        /* dragstart Event */
        var firstMouse = [];
        _m.addListener('dragstart', function () {
            $("#pin-container").remove();
            firstMouse.push($("#root").offset().left);
            firstMouse.push($("#root").offset().top);
            if(typeof canvas != "undefined" && _canvas!=null)
                _canvas.clearRect(0, 0, _mr.element.width(), _mr.element.height());
        });


        /* Idle Event */
        var count1 = 0;
        this.map.addListener( 'idle', function() {
                var border = [];
                border.push(_mr.fromPixelToLatLng({x: 20, y: 20}));
                border.push(_mr.fromPixelToLatLng({x: _mr.element.width() - $("#content-list").width(), y: 20}));
                border.push(_mr.fromPixelToLatLng({
                    x: _mr.element.width() - $("#content-list").width(),
                    y: _mr.element.height()
                }));
                border.push(_mr.fromPixelToLatLng({x: 0, y: _mr.element.height()}));
                border.push(_mr.fromPixelToLatLng({x: 20, y: 20}));
                if (count1 == 0 && _canvas == null) {
                    _mr.drawCanvas();
                } else {
                    //$("#fastmarker-overlay-canvas").css({'transform': 'translate3d(' + -(_mr.element.width() / 2) + 'px,' + -(_mr.element.height() / 2) + 'px, 0px'});
                }
                count1++;
                firstMouse = [];
                border.push(border[0]);
                _mr.drawPolygon(border, true, true);
        });

        /* Center changed Event */
        _m.addListener('center_changed', function () {
            $("#pin-container").remove();
            if (typeof canvas != "undefined" && canvas != null) {
                var moveX = firstMouse.length ? -(_mr.element.width() / 2) + (firstMouse[0] - $("#root").offset().left) : -(_mr.element.width() / 2);
                var moveY = firstMouse.length ? -(_mr.element.height() / 2) + (firstMouse[1] - $("#root").offset().top) : -(_mr.element.height() / 2);
                $("#fastmarker-overlay-canvas").css({'transform': 'translate3d(' + (moveX) + 'px,' + (moveY) + 'px, 0px'});
                _canvas.clearRect(0, 0, _mr.element.width(), _mr.element.height());
            }

        });

    },
    resetDataPinSmall:function(){
        layoutEleData = [];
        for (var i=1; i<=nubLayout; i++){
            layoutEleData.push([]);
            for (var j=1; j<=nubLayout; j++) {
                layoutEleData[i-1].push([]);
            }
        }
    },
    drawCanvas: function () {
        /* Canvas into map */
        $div = $(document.createElement("div")).css({}).addClass('canvas-marker');
        //var myCanvas = new Canvas($div);
        $div.append('<canvas class="fastmarker-overlay-canvas" id="fastmarker-overlay-canvas" width="' + this.element.width() + '" height="' + this.element.height() + '" style="user-select: none; transform: translate3d(' + -(this.element.width() / 2) + 'px,' + -(this.element.height() / 2) + 'px, 0px);"></canvas>');
        new OverlayView(_m, $div);

        /*  Set to context 2d to draw pin small into map */
        canvas = $div.find("#fastmarker-overlay-canvas")[0];
        _canvas = canvas.getContext("2d");
        _canvas.fillStyle = "#0b8841";

        /* Add elment root to know move pixel */
        $div = $(document.createElement("div")).css({'color': '#fff'});
        $div.append('<div id="root" style="display: none; user-select: none;">Root</div>');
        var opts = { offset: {x: 0, y: 0}};
        new OverlayView(_m, $div, opts);

        /* mousemover canvas Event */
        var show = false;
        var t = $("#toolip-detail-on-pin");
        var lastClick = {x:0,y:0};
        $(document).on('mousemove','.canvas-marker',function (e) {
            const p = { x: e.offsetX, y: e.offsetY };
            var colKey = Math.ceil((p.x/(_mr.element.width()-$("#content-list").width())*100)/nubLayout)-1;
            var rowKey= Math.ceil((p.y/_mr.element.height()*100)/nubLayout)-1;
            if (!isInTooltip(p, t, lastClick) && lastClick.y!=0) {
                t.fadeOut(1);
                t.find('.arrow').fadeOut(1);
                $(".canvas-marker").css({'cursor':''});
            }
            layoutEleData[rowKey][colKey].forEach(function (i, k) {
                if (isIntersect(p, i)) {
                    $(".canvas-marker").css({'cursor':'pointer'});
                    lastClick = i;
                    return false;
                }
            });

        });
        $(document).on('click','.canvas-marker',function (e) {
            console.log(e);
            const p = { x: e.offsetX, y: e.offsetY };
            var colKey = Math.ceil((p.x/(_mr.element.width()-$("#content-list").width())*100)/nubLayout)-1;
            var rowKey= Math.ceil((p.y/_mr.element.height()*100)/nubLayout)-1;
            if (!isInTooltip(p, t, lastClick) && lastClick.y!=0) {
                t.fadeOut(1);
                t.find('.arrow').fadeOut(1);
            }
            layoutEleData[rowKey][colKey].forEach(function (i, k) {
                if (isIntersect(p, i)) {
                    $(".canvas-marker").css({'cursor':'pointer'});
                    lastClick = i;
                    console.log(layoutEleData[rowKey][colKey]);
                    t.fadeIn('fast').css({'left': i.x - t.width() / 2, top: i.y - (t.outerHeight(true)/2) -30});
                    t.find('.arrow').fadeIn('fast').css({'left': (i.x - t.offset().left) - 2 + "px"});

                    t.find("#show-price-tooltip span").text(i.data.price.toLocaleString('de-DE'));
                    t.find("#show-acreage-tooltip span").text(i.data.acreage.toLocaleString('de-DE'));
                    t.find("#show-electricity-tooltip span").text(i.data.price_electricity.toLocaleString('de-DE'));
                    t.find("#show-water-tooltip span").text(i.data.price_water.toLocaleString('de-DE'));
                    t.find("#show-deposit-tooltip span").text(i.data.price_deposit.toLocaleString('de-DE'));
                    $("#detail-title").text(i.data.name);
                    $("#show-detail").show();
                    $("#detail-address span").text(i.data.address);
                    var imgs = JSON.parse(i.data.images);
                    return false;
                }
            });

        });
    },
    addItemToCanvas: function () {
        layoutEleData.forEach(function (t, k) {
            t.forEach(function (z,key) {
                z.forEach(function (i,key) {
                    _canvas.beginPath();
                    _canvas.arc(i.x, i.y, 2, 0, 2 * Math.PI, false);
                    _canvas.lineWidth = 1;
                    _canvas.strokeStyle = '#fff';
                    _canvas.stroke();
                    _canvas.fill();
                    _canvas.closePath();
                });
            });
       });
    },
    test: function () {
        console.log("This is Function test");
    },
    controlCustomMap: function () {
        if (true) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip: 'Xem sau và so sánh',
                class: 'glyphicon glyphicon-heart',
                id: 'save-map',
                position: google.maps.ControlPosition.LEFT_TOP,
                events: {
                    click: function (event) {
                        $("#addRoom").modal('show');
                        $("#addRoom").on('shown.bs.modal', function (e) {
                            // do something...
                        })
                    }
                }
            });
        }
        if (true) {
            var drawing_poply = false;
            var enable_draw = false;
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip: 'Vẽ tùy chỉnh',
                class: 'draw-listing glyphicon glyphicon-pencil',
                id: 'draw-listing',
                position: google.maps.ControlPosition.LEFT_TOP,
                events: {
                    click: function (event) {
                        if (!$(this).hasClass('active')) {
                            $(this).addClass('active');
                            enable_draw = true;
                            _mr.setOptionForMap(false);
                            /* Xóa hết line khi khởi tạo */
                            _mr.removeOjectMap(_p);
                            polygon_history.forEach(function (object, t) {
                                _mr.removeOjectMap(object);
                            });
                            _mr.removeOjectMap(_p);
                            _mr.removeOjectMap(_pl);
                            _mr.overlayAction('delete');
                        } else {
                            $(this).removeClass('active');
                            if (!$.isEmptyObject(polygon_history[0].getPath().getArray())) {
                                _mr.drawPolygon(polygon_history[0].getPath().getArray(), true);
                            }
                            enable_draw = false;
                            _mr.setOptionForMap(true);
                            _mr.overlayAction('delete');
                        }
                    }
                },
                events_map: {
                    mousedown: function (e) {
                        if (enable_draw) {
                            drawing_poply = true;
                            _pl.setMap(_m);
                        }
                    },
                    mousemove: function (e) {
                        var myLatLng = e.latLng;
                        var latLgn = [myLatLng.lat(), myLatLng.lng()];
                        if (enable_draw && drawing_poply) {
                            var path = _pl.getPath();
                            path.push(myLatLng);
                        }
                    },
                    mouseup: function (e) {
                        if (enable_draw) {
                            var current_path = _pl.getPath().getArray();
                            if (current_path.length != 0) {
                                $('#draw-listing').trigger('click');
                                _pl.setMap(null);
                                _pl.setPath([]);
                                _mr.drawPolygon(current_path, true);
                            } else {
                                alert("Nhấn chuột và kéo để vẽ. Thả chuột khi vẽ xong bản đồ");
                            }
                        }
                        drawing_poply = false;
                    }
                }
            });
        }
        if (false) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip: 'Vẽ đa giác để chọn phòng',
                class: 'polygon-draw glyphicon glyphicon-pushpin',
                id: 'polygon-draw',
                position: google.maps.ControlPosition.LEFT_TOP,
                events: {
                    click: function (event) {
                        if (!$(this).hasClass('active')) {
                            $(this).addClass('active');
                            _mr.setOptionForMap(false);
                            _mr.removeOjectMap(_p);
                            polygon_history.forEach(function (object, t) {
                                _mr.removeOjectMap(object);
                            });
                            drawingManager.setMap(_m);
                            drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON);
                            _mr.overlayAction('toogle');
                        } else {
                            $(this).removeClass('active');
                            if (!$.isEmptyObject(polygon_history[0].getPath().getArray())) {
                                _mr.drawPolygon(polygon_history[0].getPath().getArray(), true);
                            }
                            _mr.setOptionForMap(true);
                            drawingManager.setMap(null);
                            _mr.overlayAction('toogle');
                        }
                    }
                },
                events_draw: {
                    overlaycomplete: function (e) {
                        drawingManager.setDrawingMode(null);
                        console.log(e.type);
                        if (e.type != google.maps.drawing.OverlayType.MARKER) {
                            drawingManager.setDrawingMode(null);
                            var newShape = e.overlay;
                            newShape.type = e.type;
                            newShape.setEditable(true);
                        }
                    },
                    polygoncomplete: function (polygon) {
                        $("#polygon-draw").trigger('click');
                        var coordinates = (polygon.getPath().getArray());
                        var paths = polygon.getPaths();
                        polygon_history.push(polygon);
                        paths.forEach(function (path, i) {
                            google.maps.event.addListener(path, "insert_at", function () {
                                console.log(path);
                            });
                            google.maps.event.addListener(path, "set_at", function () {
                                console.log(path);
                            });
                            google.maps.event.addListener(path, "remove_at", function () {
                                console.log(path);
                            });
                        });
                        drawingManager.setMap(null);
                    }
                }
            });
        }
        if (true) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip: 'Lấy vị trí của tôi',
                class: 'my-location glyphicon glyphicon-record',
                id: 'my-location',
                position: google.maps.ControlPosition.LEFT_TOP,
                events: {
                    click: function (event) {
                        alert("Lấy vị trí hiện tại");
                    }
                }
            });
        }
        if (true) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip: 'Hướng dẫn sử dụng',
                class: 'guid-map glyphicon glyphicon-book',
                id: 'guid-map',
                position: google.maps.ControlPosition.LEFT_TOP,
                events: {
                    click: function (event) {
                        $("#guidMap").modal('show');
                        $("#guidMap").on('shown.bs.modal', function (e) {
                            // do something...
                        })
                    }
                }
            });
        }
        if (true) {
            _mr.controlCreate.inputControl({
                gmap: _m,
                name: 'input-search',
                class: 'input-search',
                id: 'input-search',
                position: google.maps.ControlPosition.TOP_LEFT,
                events: {
                    focus: function (event) {
                        $(this).val("");
                    }
                }
            });
        }
    },
    drawPolygon: function (data_input, type = true, full=false) {
        console.log('Draw polygon...');
        _mr.bounds = new google.maps.LatLngBounds();
        var data_draw = [];
        if (type) {
            //data_input.push(data_input[0]);
            data_draw = data_input;
            $.each(data_input, function (k, v) {
                _mr.bounds.extend(v);
            });
        } else {
            data_input.push(data_input[0]);
            $.each(data_input, function (k, v) {
                data_draw.push(new google.maps.LatLng(v[0], v[1]));
                _mr.bounds.extend(new google.maps.LatLng(v[0], v[1]));
            });
        }
        _bounds = _mr.bounds;
        if (!full){
            _p.setPaths(data_draw);
            console.log(_p.getPaths());
            _p.setMap(_m);
            _m.setZoom(_mr.getBoundsZoomLevel(_bounds));
        }
        // polygon_history.push(_p);
        _mr.loadPinMap(data_draw);
        // _m.fitBounds(_mr.bounds);
        // _m.setZoom(_m.getZoom() + 1);
        // _m.panBy($("#show-list").width()/2,0);
    },
    getBoundsZoomLevel: function(bounds) {
        var WORLD_DIM = { height: 256, width: 256 };
        var ZOOM_MAX = 21;

        function latRad(lat) {
            var sin = Math.sin(lat * Math.PI / 180);
            var radX2 = Math.log((1 + sin) / (1 - sin)) / 2;
            return Math.max(Math.min(radX2, Math.PI), -Math.PI) / 2;
        }

        function zoom(mapPx, worldPx, fraction) {
            return Math.floor(Math.log(mapPx / worldPx / fraction) / Math.LN2);
        }

        var ne = bounds.getNorthEast();
        var sw = bounds.getSouthWest();

        var latFraction = (latRad(ne.lat()) - latRad(sw.lat())) / Math.PI;

        var lngDiff = ne.lng() - sw.lng();
        var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

        var latZoom = zoom(_mr.element.height(), WORLD_DIM.height, latFraction);
        var lngZoom = zoom(_mr.element.width(), WORLD_DIM.width, lngFraction);

        return Math.min(latZoom, lngZoom, ZOOM_MAX);
    },
    overlay: function (data_overlay) {
        var objs = [];
        if (!data_overlay.values.length) {
            return;
        }
        $div = $(document.createElement("div")).css({
            border: "none",
            borderWidth: 0,
            position: "absolute"
        });
        $div.attr('id','pin-container');
        $.each(data_overlay.values, function (i, item) {
            $(item.options.content).data('lat',item.latLng[0]);
            $(item.options.content).data('lgn',item.latLng[1]);
            $div.append($(item.options.content));
        });

        var obj = new OverlayView(_m, $div);
        // item.events = data_overlay.events;
        // attachEvents(_m, _mr.element, item, obj, $div);
        // $div = null; // memory leak
    },
    overlayAction: function (action) {
        $.each(overlays, function (i, item) {
            if (action == 'toogle')
                item.toggle();
            if (action == 'delete')
                item.toggleDOM();
        });
    },
    getPath: function (ob) {
        return ob.getPath();
    },
    setOptionForMap: function (style) {
        var showInforMap = 'off';
        var draggable = false;
        if (style) {
            draggable = style.draggable;
            showInforMap = style.showInforMap;
        }
        _m.setOptions({
            styles: [
                {
                    featureType: 'poi',
                    elementType: 'all',
                    stylers: [{
                        "visibility": showInforMap
                    }]
                },
                {
                    featureType: 'administrative',
                    elementType: 'all',
                    stylers: [{
                        "visibility": showInforMap
                    }]
                },
                {
                    featureType: 'transit',
                    elementType: 'all',
                    stylers: [{
                        "visibility": 'on'
                    }]
                },

            ],
            draggable: draggable
        });
    },
    removeOjectMap: function (ojbect) {
        if (_mr.getPath(ojbect).length != 0)
            ojbect.setMap(null);
    },
    controlCreate: {
        optionDiv: function (options) {
            var control = document.createElement('DIV');
            control.className = "dropDownItemDiv";
            control.title = options.title;
            control.id = options.id;
            control.innerHTML = options.name;
            google.maps.event.addDomListener(control, 'click', options.action);
            return control;
        },
        checkBox: function (options) {
            //first make the outer container
            var container = document.createElement('DIV');
            container.className = "checkboxContainer";
            container.title = options.title;

            var span = document.createElement('SPAN');
            span.role = "checkbox";
            span.className = "checkboxSpan";

            var bDiv = document.createElement('DIV');
            bDiv.className = "blankDiv";
            bDiv.id = options.id;

            var image = document.createElement('IMG');
            image.className = "blankImg";
            image.src = "http://maps.gstatic.com/mapfiles/mv/imgs8.png";

            var label = document.createElement('LABEL');
            label.className = "checkboxLabel";
            label.innerHTML = options.label;

            bDiv.appendChild(image);
            span.appendChild(bDiv);
            container.appendChild(span);
            container.appendChild(label);

            google.maps.event.addDomListener(container, 'click', function () {
                (document.getElementById(bDiv.id).style.display == 'block') ? document.getElementById(bDiv.id).style.display = 'none' : document.getElementById(bDiv.id).style.display = 'block';
                options.action();
            })
            return container;
        },
        separator: function () {
            var sep = document.createElement('DIV');
            sep.className = "separatorDiv";
            return sep;
        },
        dropDownOptionsDiv: function (options) {
            //alert(options.items[1]);
            var container = document.createElement('DIV');
            container.className = "dropDownOptionsDiv";
            container.id = options.id;


            for (i = 0; i < options.items.length; i++) {
                //alert(options.items[i]);
                container.appendChild(options.items[i]);
            }

            //for(item in options.items){
            //container.appendChild(item);
            //alert(item);
            //}
            return container;
        },
        dropDownControl: function (options) {
            var container = document.createElement('DIV');
            container.className = 'container';

            var control = document.createElement('DIV');
            control.className = 'dropDownControl';
            control.innerHTML = options.name;
            control.id = options.name;
            var arrow = document.createElement('IMG');
            arrow.src = "http://maps.gstatic.com/mapfiles/arrow-down.png";
            arrow.className = 'dropDownArrow';
            control.appendChild(arrow);
            container.appendChild(control);
            container.appendChild(options.dropDown);

            options.gmap.controls[options.position].push(container);
            google.maps.event.addDomListener(container, 'click', function () {
                (document.getElementById('myddOptsDiv').style.display == 'block') ? document.getElementById('myddOptsDiv').style.display = 'none' : document.getElementById('myddOptsDiv').style.display = 'block';
                setTimeout(function () {
                    document.getElementById('myddOptsDiv').style.display = 'none';
                }, 1500);
            })
        },
        buttonControl: function (options) {
            var control = document.createElement('DIV');
            control.innerHTML = options.name;
            control.className = options.class ? options.class + " button-map" : 'button-map';
            control.title = options.tooltip;
            control.dataset.toggle = "tooltip";
            control.dataset.placement = "right";
            options.id ? control.id = options.id : null;
            control.style.userSelect = 'none';
            control.style.boxShadow = 'rgba(0, 0, 0, 0.3) 0px 1px 4px -1px';
            control.style.borderRadius = '2px';
            control.style.cursor = 'pointer';
            control.style.backgroundColor = 'rgb(255, 255, 255)';
            control.style.padding = '7px';
            control.style.fontSize = '14px';
            control.style.fontWeight = 'bold';
            control.style.marginTop = '10px';
            control.style.marginLeft = '10px';
            control.index = 1;
            options.gmap.controls[options.position].push(control);
            $.each(options, function (name, val) {
                if (name == 'events')
                    controlAttachEvents(options.events, control, google.maps.event.addDomListener);
                if (typeof name.split("_")[0] != undefined && name.split("_")[0] == 'events') {
                    if (name.split("_")[1] == 'map')
                        controlAttachEvents(val, _m, google.maps.event.addListener);
                    if (name.split("_")[1] == 'draw')
                        controlAttachEvents(val, drawingManager, google.maps.event.addListener);
                }
            });
            return control;
        },
        inputControl: function (options) {
            var control = document.createElement('input');
            control.className = "input-map " + options.class ? options.class : '';
            control.placeholder = "Nhập trường học, khu công nghiệp, công ty, bệnh viện...";
            options.id ? control.id = options.id : null;
            control.style.width = '550px';
            control.style.userSelect = 'none';
            control.style.boxShadow = 'rgba(0, 0, 0, 0.3) 0px 1px 4px -1px';
            control.style.borderRadius = '2px';
            control.style.boxSizing = 'border-box';
            control.style.backgroundColor = 'rgb(255, 255, 255)';
            control.style.border = '0px';
            control.style.padding = '10px 10px';
            control.style.fontSize = '14px';
            control.style.marginTop = '10px';
            control.style.marginLeft = '10px';
            control.index = 1;
            var options_auto = {
                componentRestrictions: {country: 'vn'},
                language: 'vi',
                bounds: _bounds,
                types:['establishment','point_of_interest'],
                strictBounds: true
            };
            control = document.getElementById('search-map-input');
            var searchBox = new google.maps.places.Autocomplete(control, options_auto);
            google.maps.event.addListener(searchBox, 'place_changed', function () {
                var place = searchBox.getPlace();
                console.log(place);
            });
            var marker = new google.maps.Marker({
                map: _m,
                draggable: false
            });
            searchBox.addListener('place_changed', function () {
                var place = searchBox.getPlace();
                if (!place.geometry) {
                    return;
                }
                marker.setMap(null);
                marker = new google.maps.Marker({
                    map: _m,
                    title: place.name,
                    position: {lat: place.geometry.location.lat(), lng: place.geometry.location.lng()},
                });
                _m.setCenter({lat: place.geometry.location.lat(), lng: place.geometry.location.lng()});
                var myLatlng = new google.maps.LatLng(place.geometry.location.lat(), place.geometry.location.lng());
                _mr.drawPolygon(_mr.drawCircle(myLatlng, 3, 1), true);
            });
            $.each(options, function (name, val) {
                if (name == 'events')
                    controlAttachEvents(options.events, control, google.maps.event.addDomListener);
                if (typeof name.split("_")[0] != undefined && name.split("_")[0] == 'events') {
                    if (name.split("_")[1] == 'map')
                        controlAttachEvents(val, _m, google.maps.event.addListener);
                    if (name.split("_")[1] == 'draw')
                        controlAttachEvents(val, drawingManager, google.maps.event.addListener);
                }
            });
            return control;
        }
    },
    drawCircle: function (point, radius, dir) {
        var d2r = Math.PI / 180;   // degrees to radians
        var r2d = 180 / Math.PI;   // radians to degrees
        var earthsradius = 3963; // 3963 is the radius of the earth in miles

        var points = 32;

        // find the raidus in lat/lon
        var rlat = (radius / earthsradius) * r2d;
        var rlng = rlat / Math.cos(point.lat() * d2r);

        var extp = new Array();
        if (dir == 1) {
            var start = 0;
            var end = points + 1; // one extra here makes sure we connect the path
        } else {
            var start = points + 1;
            var end = 0;
        }
        for (var i = start; (dir == 1 ? i < end : i > end); i = i + dir) {
            var theta = Math.PI * (i / (points / 2));
            ey = point.lng() + (rlng * Math.cos(theta)); // center a + radius x * cos(theta)
            ex = point.lat() + (rlat * Math.sin(theta)); // center b + radius y * sin(theta)
            extp.push(new google.maps.LatLng(ex, ey));
        }
        return extp;
    },
    loadPinMap: function (data) {
        console.log('load map...');
        this.resetDataPinSmall();
        var region = [];
        $.each(data, function (key, item) {
            region.push([item.lng(), item.lat()])
        });
        var dataSend = {
            region: JSON.stringify(region),
            other: null
        };
        $.ajax({
            url: "/find/map/find-map",
            data: dataSend,
            type: "post",
            dataType: "json",
            async:true,
            cache:false,
            beforeSend: function (xhr) {
                _mr.element.append('<div class="loadding-map"><img src="http://www.coinnews.net/files/support/loading.gif" algin="left">Đang tải dữ liệu...</div>');
            }
        }).done(function (response) {
            var data = response.data.listing;
            markers_data = [];
            _mr.overlayAction('delete');
            if($.isEmptyObject(data)){
                $(".no-result").show();
            }else{
                $(".no-result").hide();
            }
            $("#content-list .item-listing").remove();
            $.each(data, function (key, item) {
                markers_data.push({
                    latitude: item.location.coordinates[1],
                    longitude: item.location.coordinates[0],
                    latLng: [item.location.coordinates[1], item.location.coordinates[0]],
                    data: item,
                    options: {
                        pane: "floatPane",
                        content: '<div  data-toggle="popover" data-lat="'+item.location.coordinates[1]+'" data-lgn="'+item.location.coordinates[0]+'" class="pin-overlay house-overlay-item pin_' + item._id.$oid + '" data-tippy-html="#item_' + item._id.$oid + '" title="' + item.title + '"><span>' + item.price / 1000000 + '</span></div>',
                        offset: {x: 0, y: 0},
                        draggable: true,
                    }
                });
                var html = "";
                    html+='<div class="item-listing" style="overflow: hidden; ">';
                    html+='<div class="inner-item" style="padding: 12px 12px 7px; border-bottom: 1px solid #eee;" id="item_'+item._id.$oid+'">';
                    var image = item.images;
                    html+='<div class="img-item" style="float: left; ">';
                    html+='<img src="sfsdss" width="100px" height="70px" onerror="this.src=\'http://cdn.propzy.vn/images/806ecb4587f5350590834aac79d44759_image.jpg\'">';
                    html+='</div>';
                    html+='<div class="info" style="margin-left: 115px;">';
                    html+='<h3 class="title" style="margin-bottom: 3px;"><b>'+item.name+'</b></h3>';
                    html+='<div class="address" style="font-size: 13px">'+item.address+'</div>';
                    html+='<div class="more-info-list">';
                    html+='<span class="item-main"><b>'+(item.price/1000000)+'</b> Triệu / tháng</span>';
                    html+='<span class="item-main"><b>'+item.acreage+'</b> m2</span>';
                    html+='<span class="item-more">30m</span>';
                    html+='</div>';
                    html+='</div>';
                    html+='</div>';
                    html+='</div>';
                $("#content-list").append($(html));
                $("#content-list").on('click',$(html),function () {
                    $("#detail-title").text($(this).find(".title").text());
                    $("#show-detail").show();
                    $("#detail-address span").text($(this).find(".address").text());
                })
            });
            _mr.overlay({
                values: markers_data,
                events: {
                    click: function (overlay, event, context) {
                        $('.house-overlay-item').removeClass('active');
                        $(this).find('.house-overlay-item').first().addClass('active');
                        $("#detail-title").text(context.data.name);
                        $("#show-detail").show();
                        $("#detail-address span").text(context.data.address);
                        var imgs = JSON.parse(context.data.images);
                    }
                }
            });
            response.data.listing_small.forEach(function(item,k){
                var latLgn = _mr.fromLatLngToPixel(new google.maps.LatLng(item.location.coordinates[1], item.location.coordinates[0]));
                var colKey  = Math.ceil(((latLgn.x/(_mr.element.width()-$("#content-list").width()))*100)/nubLayout)-1;
                var rowKey = Math.ceil(((latLgn.y/_mr.element.height())*100)/nubLayout)-1;
                layoutEleData[rowKey][colKey].push({
                    latLng: [item.location.coordinates[1], item.location.coordinates[0]],
                    x:latLgn.x,
                    y:latLgn.y,
                    data: item
                });
            });
            if(_canvas!=null)
                _canvas.clearRect(0, 0, _mr.element.width(), _mr.element.height());
            _mr.addItemToCanvas();
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.error("Đã có lỗi xảy ra: " + textStatus, errorThrown);
        }).always(function () {
            _mr.element.find('.loadding-map').remove();
        });

    },
    fromLatLngToPixel: function (position) {
        var scale = Math.pow(2, _m.getZoom());
        var proj = _m.getProjection();
        var bounds = _m.getBounds();

        var nw = proj.fromLatLngToPoint(
            new google.maps.LatLng(
                bounds.getNorthEast().lat(),
                bounds.getSouthWest().lng()
            ));
        var point = proj.fromLatLngToPoint(position);

        return new google.maps.Point(
            Math.floor((point.x - nw.x) * scale),
            Math.floor((point.y - nw.y) * scale));
    },
    fromPixelToLatLng: function (pixel) {
        var scale = Math.pow(2, _m.getZoom());
        var proj = _m.getProjection();
        var bounds = _m.getBounds();

        var nw = proj.fromLatLngToPoint(
            new google.maps.LatLng(
                bounds.getNorthEast().lat(),
                bounds.getSouthWest().lng()
            ));
        var point = new google.maps.Point();
        point.x = pixel.x / scale + nw.x;
        point.y = pixel.y / scale + nw.y;
        return proj.fromPointToLatLng(point);
    },
});
$.fn.mapRooms = function (options) {
    //initDefaults();
    var $this = $(this), mapRooms_data = $this.data("mapRooms");
    if (isObject(options)) {
        $.each(this, function () {
            if (!mapRooms_data) {
                mapRooms_data = new mapRooms($this, options);
                $this.data("mapRooms", mapRooms_data);
            } else {
                alert("Object đã được khỏi tạo trước đó");
            }
        });
    } else {
        if (options !== undefined && typeof(options) === "string" && options == 'test') {
            mapRooms_data.test();
            //mapRooms_data.action('drawMaker',options);
        }
    }
    return this;
}
