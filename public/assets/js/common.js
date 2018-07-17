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
    $("#btn-s-h").click(function () {
        window.location.href = 'http://rents.dev.com/tim-kiem-phong-tro';
    });
    $("#set-location-user").click(function () {
        var dataSave = {
            'city_location_value': $("#city-location").val(),
            'city_location_text': $("#city-location option:selected").text(),
            'district_location_value': $("#district-location").val(),
            'district_location_text': $("#district-location option:selected").text()
        };
        localStorage.setItem("location_user",JSON.stringify(dataSave));
        $(".city-location-show").text(dataSave.city_location_text);
        $(".district-location-show").text(dataSave.district_location_text);
        $("#get-location-user").modal('hide');
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
            console.log(location);
        }
    } else {
       console.log("Không hỗ trợ localstorage");
    }
});

(function($) {

})(window.jQuery);
