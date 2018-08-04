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
function ChangeToSlug(title)
{
    var slug;
    /* Đổi chữ hoa thành chữ thường */
    slug = title.toLowerCase();
    /* Đổi ký tự có dấu thành không dấu */
    slug = slug.replace(/á|à|ả|ạ|ã|ă|ắ|ằ|ẳ|ẵ|ặ|â|ấ|ầ|ẩ|ẫ|ậ/gi, 'a');
    slug = slug.replace(/é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ/gi, 'e');
    slug = slug.replace(/i|í|ì|ỉ|ĩ|ị/gi, 'i');
    slug = slug.replace(/ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ/gi, 'o');
    slug = slug.replace(/ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự/gi, 'u');
    slug = slug.replace(/ý|ỳ|ỷ|ỹ|ỵ/gi, 'y');
    slug = slug.replace(/đ/gi, 'd');
    /* Xóa các ký tự đặt biệt */
    slug = slug.replace(/\`|\~|\!|\@|\#|\||\$|\%|\^|\&|\*|\(|\)|\+|\=|\,|\.|\/|\?|\>|\<|\'|\"|\:|\;|_/gi, '');
    /* Đổi khoảng trắng thành ký tự gạch ngang */
    slug = slug.replace(/ /gi, " - ");
    /* Đổi nhiều ký tự gạch ngang liên tiếp thành 1 ký tự gạch ngang */
    /* Phòng trường hợp người nhập vào quá nhiều ký tự trắng */
    slug = slug.replace(/\-\-\-\-\-/gi, '-');
    slug = slug.replace(/\-\-\-\-/gi, '-');
    slug = slug.replace(/\-\-\-/gi, '-');
    slug = slug.replace(/\-\-/gi, '-');
    /* Xóa các ký tự gạch ngang ở đầu và cuối */
    slug = '@' + slug + '@';
    slug = slug.replace(/\@\-|\-\@|\@/gi, '');
    /* In slug ra textbox có id “slug” */
    return slug;
}
function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+ d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

$(document).ready(function() {
    function drawCircle(point, radius, dir) {
        var d2r = Math.PI / 180;
        var r2d = 180 / Math.PI;
        var earthsradius = 3963;
        var points = 32;
        var rlat = (radius / earthsradius) * r2d;
        var rlng = rlat / Math.cos(point.lat() * d2r);
        var extp = new Array();
        if (dir == 1) {
            var start = 0;
            var end = points + 1;
        } else {
            var start = points + 1;
            var end = 0;
        }
        for (var i = start; (dir == 1 ? i < end : i > end); i = i + dir) {
            var theta = Math.PI * (i / (points / 2));
            ey = point.lng() + (rlng * Math.cos(theta));
            ex = point.lat() + (rlat * Math.sin(theta));
            extp.push(new google.maps.LatLng(ex, ey));
        }
        return extp;
    }

    var options_auto = {
        componentRestrictions: {country: 'vn'},
        language: 'vi',
        //bounds: _bounds,
        strictBounds: true,
    };

    control = document.getElementById('search-map-input');
    control.addEventListener("keypress", function () {
        var options = {
            input: control.value,
            region: 'VN',
        };
        function callback(predictions, status) {
            if(status=='OK'){
                for (var i = 0, prediction; prediction = predictions[i]; i++) {
                    results.push(prediction);
                }
                console.log(results);
            }else{
                console.log('Đã có lỗi xảy ra, Gửi thông báo cho quản trị viên webite');
            }
        }
        var service = new google.maps.places.AutocompleteService();
        service.getPlacePredictions(options, callback);
        var results = [];
    });
    var searchBox = new google.maps.places.Autocomplete(control, options_auto);
    searchBox.addListener('place_changed', function () {
        var place = searchBox.getPlace();
        if (!place.geometry) {
            return;
        }
        var myLatlng = new google.maps.LatLng(place.geometry.location.lat(), place.geometry.location.lng());
        var slug = ChangeToSlug(place.name.trim().replace(/\s{1,}/g,'-'));
        $("#search-map-input").data('lat',place.geometry.location.lat());
        $("#search-map-input").data('lgn',place.geometry.location.lng());
        $("#search-map-input").data('slug', slug);
        var location ={
            'city':null,
            'district': null
        };
        $.each(place.address_components,function (key,item) {
            if(item.types.includes('administrative_area_level_2')){
                location.district = item.long_name;
            }
            if(item.types.includes('administrative_area_level_1')){
                location.city = item.long_name;
            }
        });
        var dataSend = {
            'name': place.name,
            'place_id': place.place_id,
            'district_name': location.district,
            'city_name'    : location.city,
            'lat'        : place.geometry.location.lat(),
            'lng'        : place.geometry.location.lng(),
            'adrress'    : place.formatted_address,
            'types'      : place.types,
            'slug'       : slug
        };
        console.log(place);
        console.log(dataSend);
        setCookie('special_search', JSON.stringify(dataSend));
        $.ajax({
            url: "/find/list/save-special",
            type: "POST",
            data: dataSend,
        }).done(function (response) {
            console.log(response);
            if (response.code == 200) {

            } else {

            }
        }).fail(function () {
        }).always(function () {
        });
    });
    var location_user = {
        'city_location_value': 1,
        'city_location_text': 'Hồ Chí Minh',
        'city_slug': 'ho-chi-minh',
        'district_location_value': 1,
        'district_location_text': "Huyện Bình Chánh",
        'district_slug': 'huyen-binh-chanh',
    };
    setCookie('user_location', JSON.stringify(location_user));

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
        setCookie('user_location', JSON.stringify(location_user));
    });

    /* Lấy thông location từ user */
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

    $("ul.list-val-search li a").click(function () {
        var id = $(this).parents('.list-val-search').first().data('to');
        $("#"+id).val($(this).data('item-val'));
    });

    /* Nhấn tìm kiếm phòng trọ */
    $("#btn-s-h").click(function () {
        var params = {};
        $('#price-input').val().trim().length !=0 ? params.gia= $('#price-input').val().trim(): false;
        $('#area-input').val().trim().length !=0 ? params.dien_tich= $('#area-input').val().trim(): false;

        var page_search = $("body").hasClass('find-map') ? "/map-tim-kiem/":"/tim-kiem/";

        if(!($("#search-map-input").data('lat') &&  $("#search-map-input").data('lgn'))){
            window.location.href = page_search+location_user.city_slug+'/'+location_user.district_slug + (!$.isEmptyObject(params) ? "?"+$.param( params ):'');
        }else{
            window.location.href = page_search+'phong-tro-gan-'+$("#search-map-input").data('slug')+'/'+$("#search-map-input").data('lat')+','+$("#search-map-input").data('lgn')+(!$.isEmptyObject(params) ? "?"+$.param( params ):'');
        }
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
