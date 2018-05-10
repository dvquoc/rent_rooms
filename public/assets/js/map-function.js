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
        keys = ["data", "tag", "id", "events",  "onces"],
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
function attachEvents(map, $container, options, object, id) {
    var td = options || {},
        context = {
            id: id,
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
                    fn.apply(self, [object , event, context]);
                });
            });
        }
    }
    bind(td.events, google.maps.event.addListener);
    bind(td.onces, google.maps.event.addListenerOnce);
};
function controlAttachEvents(events, object, handler){
    function bind(items, handler) {
        if (items) {
            $.each(items, function (name, f) {
                var  fn = f, self = object;
                if ($.isArray(f)) {
                    self = f[0];
                    fn = f[1];
                }
                handler(self, name, function (event) {
                    fn.apply(self, [event,self]);
                });
            });
        }
    }
    if(events)
        bind(events,handler);
};
function OverlayView (map, opts, latLng, $div) {
    var self = this,
    listeners = [];
    google.maps.OverlayView.call(self);
    self.setMap(map);
    self.onAdd = function () {
        var panes = self.getPanes();
        if (opts.pane in panes) {
            $(panes[opts.pane]).append($div);
        }
        $.each("dblclick click mouseover mousemove mouseout mouseup mousedown".split(" "), function (i, name) {
            listeners.push(
                google.maps.event.addDomListener($div[0], name, function (e) {
                    $.Event(e).stopPropagation();
                    google.maps.event.trigger(self, name, [e]);
                    self.draw();
                })
            );
        });
        listeners.push(
            google.maps.event.addDomListener($div[0], "contextmenu", function (e) {
                $.Event(e).stopPropagation();
                google.maps.event.trigger(self, "rightclick", [e]);
                self.draw();
            })
        );
    };
    self.getPosition = function () {
        return latLng;
    };
    self.setPosition = function (newLatLng) {
        latLng = newLatLng;
        self.draw();
    };
    self.draw = function () {
        var ps = self.getProjection().fromLatLngToDivPixel(latLng);
        $div
            .css("left", (ps.x + opts.offset.x) + "px")
            .css("top", (ps.y + opts.offset.y) + "px");
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
var _m , _mr , polygon_history = [], overlays = [],_bounds=null;
var polygonOptions = {
    strokeColor: '#FF0000',
    strokeOpacity: 0.8,
    strokeWeight: 1,
    fillColor: '#FF0000',
    fillOpacity: 0.08,
    draggable: false,
    clickable:false
};
var _pl = new google.maps.Polyline(polygonOptions);
var _p = new google.maps.Polygon(polygonOptions);
var drawingManager = new google.maps.drawing.DrawingManager({
    drawingMode: google.maps.drawing.OverlayType.POLYGON,
    drawingControl: false,
    polygonOptions: polygonOptions
});
var mapRooms = function($el, options) {
    var seft = this;
    this.bounds = new google.maps.LatLngBounds();
    this.infowindow = new google.maps.InfoWindow();
    var setting = {
        center: [10.7522818,106.4810371],
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
        mousemove: function(){},
        mouseup: function(){},
        mousedown: function(){},
        click: function(){},
        hover: function(){},

    };
    this.setting = $.extend(setting, options);
    this.map = _m = new google.maps.Map($el.get(0),this.setting);
    this.element = $el;
    this.init();
};
// Add prototype for mapRooms and public function in this prototype
$.extend(mapRooms.prototype, {
    init: function () {
        var setting = this.setting;
        var $el = this.element;
        _mr = this;

        if(!$.isEmptyObject(setting.markers))
            this.drawMarker(setting.markers);

        if(!$.isEmptyObject(setting.draws))
            this.drawPolygon(setting.draws,false);

        if(!$.isEmptyObject(setting.overlays))
            this.overlay(setting.overlays);

        this.controlCustomMap();

        _m.addListener('idle', function() {
                if (_m.getZoom() < 15 && !$('.pin-overlay').parent('div').hasClass("ping-small"))
                    $('.pin-overlay').parent('div').addClass('ping-small');
                if(_m.getZoom() > 15 && $('.pin-overlay').parent('div').hasClass("ping-small"))
                    $('.pin-overlay').parent('div').removeClass('ping-small');
        });

        _m.addListener('mouseover', function() {
            $('[data-toggle="tooltip"]').tooltip();
        });

    },
    test: function () {
      console.log("This is Function test");
    },
    controlCustomMap: function () {
        if(true) {
            var drawing_poply = false;
            var enable_draw = false;
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip:'Vẽ tùy chỉnh',
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
                            polygon_history.forEach(function (object,t) {
                                _mr.removeOjectMap(object);
                            });
                            _mr.removeOjectMap(_p);
                            _mr.removeOjectMap(_pl);
                            _mr.overlayAction('toogle');
                        } else {
                            $(this).removeClass('active');
                            if (!$.isEmptyObject(polygon_history[0].getPath().getArray())) {
                                _mr.drawPolygon(polygon_history[0].getPath().getArray(), true);
                            }
                            enable_draw = false;
                            _mr.setOptionForMap(true);
                            _mr.overlayAction('toogle');
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
                            var current_path = _pl.getPath().b;
                            if (current_path.length != 0) {
                                $('#draw-listing').trigger('click');
                                _pl.setMap(null);
                                _pl.setPath([]);
                                _mr.drawPolygon(current_path, true);
                                //loadPinMap(current_path);
                            } else {
                                alert("Nhấn chuột và kéo để vẽ. Thả chuột khi vẽ xong bản đồ");
                            }
                        }
                        drawing_poply = false;
                    }
                }
            });
        }
        if(false) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip:'Vẽ đa giác để chọn phòng',
                class: 'polygon-draw glyphicon glyphicon-pushpin',
                id: 'polygon-draw',
                position: google.maps.ControlPosition.LEFT_TOP,
                events: {
                    click: function (event) {
                        if (!$(this).hasClass('active')) {
                            $(this).addClass('active');
                            _mr.setOptionForMap(false);
                            _mr.removeOjectMap(_p);
                            polygon_history.forEach(function (object,t) {
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
        if(true) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip:'Lấy vị trí của tôi',
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
        if(true) {
            _mr.controlCreate.buttonControl({
                gmap: _m,
                name: '',
                tooltip:'Hướng dẫn sử dụng',
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
        if(false) {
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
    drawMarker: function (dataMarkers) {
        var objs  = [];
        if (!dataMarkers.values.length) {
            return;
        }
        $.each(dataMarkers.values, function(k,v){
            var marker = new google.maps.Marker({
                position: {lat: Number(v.latitude), lng: Number(v.longitude)},
                map: _m
            });
            google.maps.event.addListener(marker, 'mouseover', function(){
                _mr.infowindow.close();
                _mr.infowindow.setContent("<div id='infowindow'>"+ v.data.title +"</div>");
                _mr.infowindow.open(_m, marker);
            });
            _mr.bounds.extend(new google.maps.LatLng(v.latitude, v.longitude));
        });
        if(!_mr.list_latLng_draw && !_mr.bounds.isEmpty())
            _m.fitBounds(_mr.bounds);
    },
    drawPolygon: function (data_input, type = true) {
        _mr.bounds = new google.maps.LatLngBounds();
        var data_draw = [];
        if(type){
            data_draw = data_input;
            $.each(data_input, function(k,v){
                _mr.bounds.extend(v);
            });
        }
        else{
            data_input.push(data_input[0]);
            $.each(data_input, function(k,v){
                data_draw.push(new google.maps.LatLng(v[0], v[1]));
                _mr.bounds.extend(new google.maps.LatLng(v[0], v[1]));
            });
        }
        _bounds = _mr.bounds;
        _p.setPaths(data_draw);
        _p.setMap(_m);
        polygon_history.push(_p);
        _m.fitBounds(_mr.bounds);
    },
    overlay : function (data_overlay) {
        var objs  = [];
        if (!data_overlay.values.length) {
            return;
        }
        overlays = [];
        if (!OverlayView.__initialised) {
            OverlayView.prototype = new google.maps.OverlayView();
            OverlayView.__initialised = true;
        }
        $.each(data_overlay.values, function (i, item) {
            var  obj;
                $div = $(document.createElement("div")).css({
                    border: "none",
                    borderWidth: 0,
                    position: "absolute"
                });
            $div.append(item.options.content);
            obj = new OverlayView(_m,item.options, new google.maps.LatLng(item.latLng[0],item.latLng[1]), $div);
            overlays.push(obj);
            $div = null; // memory leak
            item.events = data_overlay.events;
            attachEvents(_m, _mr.element, item, obj, "gmap3_"+i);
        });
    },
    overlayAction : function (action) {
        $.each(overlays, function (i, item) {
            if(action == 'toogle')
                item.toggle();
        });
    },
    getPath: function (ob) {
        return ob.getPath();
    },
    setOptionForMap: function (status = true){
        var showInforMap = 'off';
        var draggable = false;
        if(status){
            draggable=true;
            showInforMap='on';
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
                        "visibility": showInforMap
                    }]
                },

            ],
            draggable:draggable
        });
    },
    removeOjectMap: function (ojbect) {
        if(_mr.getPath(ojbect).length !=0)
            ojbect.setMap(null);
    },
    controlCreate: {
        optionDiv: function(options){
            var control = document.createElement('DIV');
            control.className = "dropDownItemDiv";
            control.title = options.title;
            control.id = options.id;
            control.innerHTML = options.name;
            google.maps.event.addDomListener(control,'click',options.action);
            return control;
        },
        checkBox: function(options){
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

            google.maps.event.addDomListener(container,'click',function(){
                (document.getElementById(bDiv.id).style.display == 'block') ? document.getElementById(bDiv.id).style.display = 'none' : document.getElementById(bDiv.id).style.display = 'block';
                options.action();
            })
            return container;
        },
        separator: function(){
            var sep = document.createElement('DIV');
            sep.className = "separatorDiv";
            return sep;
        },
        dropDownOptionsDiv: function(options){
            //alert(options.items[1]);
            var container = document.createElement('DIV');
            container.className = "dropDownOptionsDiv";
            container.id = options.id;


            for(i=0; i<options.items.length; i++){
                //alert(options.items[i]);
                container.appendChild(options.items[i]);
            }

            //for(item in options.items){
            //container.appendChild(item);
            //alert(item);
            //}
            return container;
        },
        dropDownControl: function (options){
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
            google.maps.event.addDomListener(container,'click',function(){
                (document.getElementById('myddOptsDiv').style.display == 'block') ? document.getElementById('myddOptsDiv').style.display = 'none' : document.getElementById('myddOptsDiv').style.display = 'block';
                setTimeout( function(){
                    document.getElementById('myddOptsDiv').style.display = 'none';
                }, 1500);
            })
        },
        buttonControl: function(options) {
            var control = document.createElement('DIV');
            control.innerHTML = options.name;
            control.className = options.class ? options.class + " button-map": 'button-map';
            control.title = options.tooltip;
            control.dataset.toggle = "tooltip";
            control.dataset.placement="right";
            options.id ? control.id = options.id: null;
            control.style.userSelect= 'none';
            control.style.boxShadow= 'rgba(0, 0, 0, 0.3) 0px 1px 4px -1px';
            control.style.borderRadius= '2px';
            control.style.cursor= 'pointer';
            control.style.backgroundColor= 'rgb(255, 255, 255)';
            control.style.padding= '7px';
            control.style.fontSize= '14px';
            control.style.fontWeight= 'bold';
            control.style.marginTop= '10px';
            control.style.marginLeft= '10px';
            control.index = 1;
            options.gmap.controls[options.position].push(control);
            $.each(options, function (name, val) {
                if(name=='events')
                    controlAttachEvents(options.events, control, google.maps.event.addDomListener);
                if(typeof name.split("_")[0] != undefined && name.split("_")[0]=='events'){
                    if(name.split("_")[1]=='map')
                        controlAttachEvents(val, _m, google.maps.event.addListener);
                    if(name.split("_")[1]=='draw')
                        controlAttachEvents(val, drawingManager,google.maps.event.addListener);
                }
            });
            return control;
        },
        inputControl: function(options) {
            var control = document.createElement('input');
            control.className = "input-map " + options.class ? options.class: '';
            control.placeholder = "Nhập trường học, khu công nghiệp, công ty, bệnh viện...";
            options.id ? control.id = options.id: null;
            control.style.width= '550px';
            control.style.userSelect= 'none';
            control.style.boxShadow= 'rgba(0, 0, 0, 0.3) 0px 1px 4px -1px';
            control.style.borderRadius= '2px';
            control.style.boxSizing= 'border-box';
            control.style.backgroundColor= 'rgb(255, 255, 255)';
            control.style.border= '0px';
            control.style.padding= '10px 10px';
            control.style.fontSize= '14px';
            control.style.marginTop= '10px';
            control.style.marginLeft= '10px';
            control.index = 1;
            var options_auto = {
                componentRestrictions: {country: 'vn'},
                language: 'vi',
                bounds: _bounds,
                strictBounds: true
            };
            var searchBox = new google.maps.places.Autocomplete(control,options_auto);
            google.maps.event.addListener(searchBox, 'place_changed', function () {
                var place = searchBox.getPlace();
                console.log(place);
            });

            searchBox.addListener('place_changed', function() {
                var place = searchBox.getPlace();
                if (!place.geometry) {
                    return;
                }
                var marker = new google.maps.Marker({
                    map: _m,
                    title: place.name,
                    position: {lat: place.geometry.location.lat(), lng: place.geometry.location.lng()},
                    draggable: true
                });
                _m.setCenter({lat: place.geometry.location.lat(), lng: place.geometry.location.lng()});

                var myLatlng = new google.maps.LatLng(place.geometry.location.lat(),place.geometry.location.lng());
                var circle = new google.maps.Polygon({
                    map: _m,
                    paths: [_mr.drawCircle(myLatlng, 0.8, 1)],
                    strokeColor: "#0000FF",
                    strokeOpacity: 0.5,
                    strokeWeight: 1,
                    fillColor: "#0000FF",
                    fillOpacity: 0.08
                });
                console.log(_mr.drawCircle(myLatlng, 0.8, 1).toString());
                console.log(place);
            });
            options.gmap.controls[options.position].push(control);
            $.each(options, function (name, val) {
                if(name=='events')
                    controlAttachEvents(options.events, control, google.maps.event.addDomListener);
                if(typeof name.split("_")[0] != undefined && name.split("_")[0]=='events'){
                    if(name.split("_")[1]=='map')
                        controlAttachEvents(val, _m, google.maps.event.addListener);
                    if(name.split("_")[1]=='draw')
                        controlAttachEvents(val, drawingManager,google.maps.event.addListener);
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
        if (dir==1) {
            var start=0;
            var end=points+1; // one extra here makes sure we connect the path
        } else {
            var start=points+1;
            var end=0;
        }
        for (var i=start; (dir==1 ? i < end : i > end); i=i+dir)
        {
            var theta = Math.PI * (i / (points/2));
            ey = point.lng() + (rlng * Math.cos(theta)); // center a + radius x * cos(theta)
            ex = point.lat() + (rlat * Math.sin(theta)); // center b + radius y * sin(theta)
            extp.push(new google.maps.LatLng(ex, ey));
        }
        return extp;
    }
});
$.fn.mapRooms = function (options) {
    //initDefaults();
    var $this = $(this), mapRooms_data = $this.data("mapRooms");
    if(isObject(options)) {
        $.each(this, function () {
            if (!mapRooms_data) {
                mapRooms_data = new mapRooms($this,options);
                $this.data("mapRooms", mapRooms_data);
            }else{
                alert("Object đã được khỏi tạo trước đó");
            }
        });
    }else {
        if (options !== undefined && typeof(options) === "string" && options =='test') {
            mapRooms_data.test();
            //mapRooms_data.action('drawMaker',options);
        }
    }
    return this;
}
