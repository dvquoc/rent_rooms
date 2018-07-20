function getURLVar(key) {
	var value = [];

	var query = String(document.location).split('?');

	if (query[1]) {
		var part = query[1].split('&');

		for (i = 0; i < part.length; i++) {
			var data = part[i].split('=');

			if (data[0] && data[1]) {
				value[data[0]] = data[1];
			}
		}

		if (value[key]) {
			return value[key];
		} else {
			return '';
		}
	}
}
$(document).ready(function() {
    function loadPinMap(data) {
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
            async:false,
            cache:false,
            beforeSend: function (xhr) {
                //_mr.element.append('<div class="loadding-map"><img src="http://www.coinnews.net/files/support/loading.gif" algin="left">Đang tải dữ liệu...</div>');
            }
        }).done(function (response) {
            var data = response.data.listing;
            console.log(data);
        }).fail(function (jqXHR, textStatus, errorThrown) {
            console.error("Đã có lỗi xảy ra: " + textStatus, errorThrown);
        }).always(function () {
        });
    }
    function drawPolygon(data_input, type = true, full=false) {
        console.log('Draw polygon...');
        bounds = new google.maps.LatLngBounds();
        var data_draw = [];
        if (type) {
            data_input.push(data_input[0]);
            data_draw = data_input;
            $.each(data_input, function (k, v) {
                bounds.extend(v);
            });
        } else {
            data_input.push(data_input[0]);
            $.each(data_input, function (k, v) {
                data_draw.push(new google.maps.LatLng(v[0], v[1]));
                bounds.extend(new google.maps.LatLng(v[0], v[1]));
            });
        }
        loadPinMap(data_draw);
    }
    function drawCircle(point, radius, dir) {
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
    }

    var options_auto = {
        componentRestrictions: {country: 'vn'},
        language: 'vi',
        //bounds: _bounds,
        strictBounds: true
    };
    control = document.getElementById('search-map-input');
    var searchBox = new google.maps.places.Autocomplete(control, options_auto);
    google.maps.event.addListener(searchBox, 'place_changed', function () {
        var place = searchBox.getPlace();
        console.log(place);
    });
    searchBox.addListener('place_changed', function () {
        var place = searchBox.getPlace();
        if (!place.geometry) {
            return;
        }
        var myLatlng = new google.maps.LatLng(place.geometry.location.lat(), place.geometry.location.lng());
        $("#search-map-input").data('lat',place.geometry.location.lat());
        $("#search-map-input").data('lgn',place.geometry.location.lng());
        console.log(drawCircle(myLatlng, 3, 1));
    });
    var location_user = {
        'city_location_value': 1,
        'city_location_text': 'Hồ Chí Minh',
        'city_slug': 'ho-chi-minh',
        'district_location_value': 1,
        'district_location_text': "Huyện Bình Chánh",
        'district_slug': 'huyen-binh-chanh',
    };
    $("#set-location-user").click(function () {
        var dataSave = {
            'city_location_value': $("#city-location").val(),
            'city_location_text': $("#city-location option:selected").text(),
            'city_slug': $("#city-location option:selected").data('slug'),
            'district_location_value': $("#district-location").val(),
            'district_location_text': $("#district-location option:selected").text(),
            'district_slug': $("#district-location option:selected").data('slug')
        };
        localStorage.setItem("location_user",JSON.stringify(dataSave));
        $(".city-location-show").text(dataSave.city_location_text);
        $(".district-location-show").text(dataSave.district_location_text);
        $("#get-location-user").modal('hide');
        location_user =dataSave;
    });
    if (typeof(Storage) !== "undefined") {
        if(!localStorage.getItem("location_user")) {
            setTimeout(function () {
                $("#get-location-user").modal('show');
            }, 3000);
        }else{
            var location = JSON.parse(localStorage.getItem("location_user"));
            $(".city-location-show").text(location.city_location_text);
            $(".district-location-show").text(location.district_location_text);
            location_user = location;
            console.log(location);
        }
    } else {
       console.log("Không hỗ trợ localstorage");
    }
    $("#btn-s-h").click(function () {
        console.log(location_user);
        var params = {};
        $('#price-input').val().trim().length !=0 ? params.gia= parseFloat($('#price-input').val().trim()): false;
        $('#area-input').val().trim().length !=0 ? params.dien_tich= parseFloat($('#area-input').val().trim()): false;
        ($("#search-map-input").data('lat') &&  $("#search-map-input").data('lgn')) ? params.location= $("#search-map-input").data('lat')+','+$("#search-map-input").data('lgn') : false;
        window.location.href = '/tim-kiem-phong-tro/'+location_user.city_slug+'/'+location_user.district_slug + (!$.isEmptyObject(params) ? "?"+$.param( params ):'');
    });

    function success(position) {
        var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        console.log(latlngs);
    }

    function error(msg) {
        var s = document.querySelector('#status');
        console.log(arguments);
    }

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(success, error);
    } else {
        error('not supported');
    }


});

(function($) {

})(window.jQuery);
