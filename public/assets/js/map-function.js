if (typeof MapLocal !== "object") {
    MapLocal = {};

}
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
                self.show();
            } else {
                self.hide();
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
MapLocal = {
    map:null,
    enable_draw: false,
    drawing_poply:false,
    list_latLng_draw: [],
    bounds: new google.maps.LatLngBounds(),
    infowindow : new google.maps.InfoWindow(),
    initMap:function(ele, options= {}){
       var map = new google.maps.Map(document.getElementById(ele),options);
       map.addListener('mousedown', function() {
            if (MapLocal.enable_draw) {
                MapLocal.drawing_poply = true;
                flightPath = new google.maps.Polyline({
                    strokeColor: '#FF0000',
                    strokeOpacity: 1.0,
                    strokeWeight: 2,
                    draggable: false,
                    clickable:false
                });
                flightPath.setMap(map);
            }
        });
       map.addListener('mousemove', function(event) {
            var myLatLng = event.latLng;
            var latLgn = [myLatLng.lat(),myLatLng.lng()];
            if(MapLocal.enable_draw && MapLocal.drawing_poply) {
                MapLocal.list_latLng_draw.push(myLatLng);
                var path = flightPath.getPath();
                path.push(myLatLng);
            }
        });
       map.addListener('mouseup', function() {
            if (MapLocal.enable_draw) {
                if(MapLocal.list_latLng_draw.length!=0) {
                    $('#draw-listing').trigger('click');
                    flightPath.setMap(null);
                    drawPolygon(MapLocal.list_latLng_draw, true);
                    loadPinMap(MapLocal.list_latLng_draw);
                    MapLocal.list_latLng_draw = [];
                }else{
                    alert("Nhấn chuột và kéo để vẽ. Thả chuột khi vẽ xong bản đồ");
                }
            }
           MapLocal.drawing_poply = false;
        });
        MapLocal.map = map;
       MapLocal.controlCustomMap();
       return this;
    },
    marker_draw: function (dataListing) {
        console.log(dataListing);
    $.each(dataListing, function(k,v){
        var marker = new google.maps.Marker({
            position: {lat: Number(v.latitude), lng: Number(v.longitude)},
            map: MapLocal.map
        });
        google.maps.event.addListener(marker, 'mouseover', function(){
            MapLocal.infowindow.close(); // Close previously opened infowindow
            MapLocal.infowindow.setContent( "<div id='infowindow'>"+ v.data.title +"</div>");
            if(!MapLocal.drawing_poply)
                MapLocal.infowindow.open(MapLocal.map, marker);
        });
        MapLocal.bounds.extend(new google.maps.LatLng(v.latitude, v.longitude));
    });
    if(!MapLocal.list_latLng_draw && !bounds.isEmpty())
        map.fitBounds(bounds);
},
    drawPolygon: function (data_input, type = true) {
        MapLocal.bounds = new google.maps.LatLngBounds();
        var data_draw = [];
        if(type){
            data_draw = data_input;
            $.each(data_input, function(k,v){
                MapLocal.bounds.extend(v);
            });
        }
        else{
            data_input.push(data_input[0]);
            $.each(data_input, function(k,v){
                data_draw.push(new google.maps.LatLng(v[0], v[1]));
                MapLocal.bounds.extend(new google.maps.LatLng(v[0], v[1]));
            });
        }

        bermudaTriangle = new google.maps.Polygon({
            paths: data_draw,
            strokeColor: '#FF0000',
            strokeOpacity: 0.5,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0,
            draggable: false,
            clickable:false
        });
        bermudaTriangle.setMap(MapLocal.map);
        MapLocal.map.fitBounds(MapLocal.bounds);
    },
    setOptionForMap: function (){
        var showInforMap = 'off';
        var draggable = false;
        if(!MapLocal.enable_draw){
            draggable=true;
            showInforMap='on';
        }
        MapLocal.map.setOptions({
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
    controlCustomMap: function () {
        var containerControl = document.createElement('div');
        var draw = $("<div id='draw-listing' class='draw-listing' style='margin-top: 10px;user-select: none; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; background-color: rgb(255, 255, 255); padding: 7px 10px; font-size: 14px; font-weight: bold'>");
            draw.text("Vẽ để lọc");
            draw.click(function () {
                if (!$(this).hasClass('active')) {
                    $(this).addClass('active');
                    $(this).text('Bỏ vẽ');
                    MapLocal.enable_draw = true;
                    MapLocal.setOptionForMap();
                    /* Xóa hết line khi khởi tạo */
                    if(bermudaTriangle !=null)
                        bermudaTriangle.setMap(null);
                    if(flightPath!=null)
                        flightPath.setMap(null);
                } else {
                    $(this).removeClass('active');
                    $(this).text('Vẽ để lọc');
                    if(!MapLocal.drawing_poply && !$.isEmptyObject(MapLocal.data_localtion_first))
                        MapLocal.drawPolygon(data_localtion_first,false);
                    MapLocal.enable_draw = false;
                    MapLocal.setOptionForMap();
                }
            });
        containerControl.appendChild(draw.get(0));
        MapLocal.map.controls[google.maps.ControlPosition.TOP_CENTER].push(containerControl);
    },
    loadPinMap: function (dataSend) {
        var districtsList = [];
        var data_send = {};
        data_send.areaZoning = dataSend;
        $('#crm_jm_formCustomSearchListing .districtsList').each(function() {
            districtsList.push({"id":$(this).val()});
        });
        data_send.districtsList = districtsList;
        //return false;
        $.ajax({
            type: "POST",
            url: "/lead/get-pin/"+lead.leadId,
            dataType: 'json',
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data_send),
            async: true,
            cache: false,
            beforeSend: function () {
                $("#loadding-map").html('<b style="color: red;">Đang tải bản đồ...</b>');
                $("#loadding-map").show();
            },
            success: function(data) {
                if(data){
                    marker_draw({'data':data});
                }
                else{
                    $("#map-filter-container").text("Không có listing để hiển thị");
                }
                $("#loadding-map").hide();

            },
            error: function(xhr, ajaxOptions, thrownError) {
                $("#loadding-map").html('<b style="color: red;">Đã có lỗi xảy ra');
                console.log(xhr.responseText);
            }
        });
    },
    resetFilter: function (type='map'){
    $.ajax({
        type: "GET",
        url: "/lead/reset-filter/"+lead.leadId+"?type="+type,
        async: true,
        cache: false,
        beforeSend: function () {
            $("#loadding-map").html('<b style="color: red;">Đang làm mới...</b>');
            $("#loadding-map").show();
        },
        success: function(data) {
            console.log(data);
            if(data.result) {
                data_localtion_first =null;
                $("#location_map").val("");
                $('#load-map-draw').trigger('click');
                $('#crm_jm_formCustomSearchListing .btn-info').trigger("click");
            } else {
                alert("Đã có lỗi sảy ra...");
            }
            $("#loadding-map").hide();
        },
        error: function(xhr, ajaxOptions, thrownError) {
            $("#loadding-map").html('<b style="color: red;">Đã có lỗi xảy ra');
            console.log(xhr.responseText);
        }
    });
},
    overlay : function (args, internal) {
        var objs = [],
        multiple = "values" in args.td;
        if (!multiple) {
            args.td.values = [{latLng: args.latLng, options: args.opts}];
        }
        if (!args.td.values.length) {
            manageEnd(args, false);
            return;
        }
        if (!MapLocal.OverlayView.__initialised) {
            MapLocal.OverlayView.prototype = new defaults.classes.OverlayView();
            MapLocal.OverlayView.__initialised = true;
        }
        $.each(args.td.values, function (i, value) {
            var id, obj, td = tuple(args, value),
                $div = $(document.createElement("div")).css({
                    border: "none",
                    borderWidth: 0,
                    position: "absolute"
                });
            $div.append(td.options.content);
            obj = new OverlayView(map, td.options, toLatLng(td) || toLatLng(value), $div);
            objs.push(obj);
            $div = null; // memory leak
            if (!internal) {
                id = store.add(args, "overlay", obj);
                attachEvents($this, {td: td}, obj, id);
            }
        });
    },
    OverlayView: function (map, opts, latLng, $div) {
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
                    gm.event.addDomListener($div[0], name, function (e) {
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
                    self.show();
                } else {
                    self.hide();
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
};
var mapRooms = function($el, options) {
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
    this.map = new google.maps.Map($el.get(0),this.setting);
    // Attributes
    this.element = $el;
    this.init();
};
// Add prototype for mapRooms and public function in this prototype
$.extend(mapRooms.prototype, {
    init: function () {
        var setting = this.setting;
        var $el = this.element;

        this.controlCustomMap();

        if(!$.isEmptyObject(setting.markers) && false)
            this.drawMarker(setting.markers);


        if(!$.isEmptyObject(setting.draws))
            this.drawPolygon(setting.draws,false);

        if(!$.isEmptyObject(setting.overlay))
            this.overlay(setting.overlay);

    },
    test: function () {
      console.log("This is Function test");
    },
    controlCustomMap: function () {
        var map  = this.map, self  = this;
        var containerControl = document.createElement('div');
        var draw = $("<div id='draw-listing' class='draw-listing' style='margin-top: 10px;user-select: none; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; background-color: rgb(255, 255, 255); padding: 7px 10px; font-size: 14px; font-weight: bold'>");
        draw.text("Vẽ để lọc");
        draw.click(function () {
            if (!$(this).hasClass('active')) {
                $(this).addClass('active');
                $(this).text('Bỏ vẽ');
                MapLocal.enable_draw = true;
                MapLocal.setOptionForMap();
                /* Xóa hết line khi khởi tạo */
                if(bermudaTriangle !=null)
                    bermudaTriangle.setMap(null);
                if(flightPath!=null)
                    flightPath.setMap(null);
            } else {
                $(this).removeClass('active');
                $(this).text('Vẽ để lọc');
                if(!MapLocal.drawing_poply && !$.isEmptyObject(MapLocal.data_localtion_first))
                    MapLocal.drawPolygon(data_localtion_first,false);
                MapLocal.enable_draw = false;
                MapLocal.setOptionForMap();
            }
        });
        containerControl.appendChild(draw.get(0));
        map.controls[google.maps.ControlPosition.TOP_CENTER].push(containerControl);
    },
    drawMarker: function (dataListing) {
        var map  = this.map, self  = this;
        $.each(dataListing, function(k,v){
            var marker = new google.maps.Marker({
                position: {lat: Number(v.latitude), lng: Number(v.longitude)},
                map: map
            });
            google.maps.event.addListener(marker, 'mouseover', function(){
                self.infowindow.close(); // Close previously opened infowindow
                self.infowindow.setContent("<div id='infowindow'>"+ v.data.title +"</div>");
                if(!self.drawing_poply)
                    self.infowindow.open(map, marker);
            });
            self.bounds.extend(new google.maps.LatLng(v.latitude, v.longitude));
        });
        if(!self.list_latLng_draw && !self.bounds.isEmpty())
            map.fitBounds(self.bounds);
    },
    drawPolygon: function (data_input, type = true) {
        var map  = this.map, self  = this;
        self.bounds = new google.maps.LatLngBounds();
        var data_draw = [];
        if(type){
            data_draw = data_input;
            $.each(data_input, function(k,v){
                self.bounds.extend(v);
            });
        }
        else{
            data_input.push(data_input[0]);
            $.each(data_input, function(k,v){
                data_draw.push(new google.maps.LatLng(v[0], v[1]));
                self.bounds.extend(new google.maps.LatLng(v[0], v[1]));
            });
        }

        var bermudaTriangle = new google.maps.Polygon({
            paths: data_draw,
            strokeColor: '#FF0000',
            strokeOpacity: 0.5,
            strokeWeight: 3,
            fillColor: '#FF0000',
            fillOpacity: 0,
            draggable: false,
            clickable:false
        });
        bermudaTriangle.setMap(map);
        map.fitBounds(self.bounds);
    },
    overlay : function (data_overlay, internal=true) {
        var map  = this.map, self  = this;
        var objs = [];
        if (!data_overlay.values.length) {
            return;
        }
        if (!OverlayView.__initialised) {
            OverlayView.prototype = new google.maps.OverlayView();
            OverlayView.__initialised = true;
        }
        $.each(data_overlay.values, function (i, item) {
            var id, obj;
                $div = $(document.createElement("div")).css({
                    border: "none",
                    borderWidth: 0,
                    position: "absolute"
                });
            $div.append(item.options.content);
            obj = new OverlayView(map,item.options, new google.maps.LatLng(item.latLng[0],item.latLng[1]), $div);
            $div = null; // memory leak
            item.events = data_overlay.events;
            id = "gmap3_"+i;
            attachEvents(map,self.element, item, obj, id);
        });
    },
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
