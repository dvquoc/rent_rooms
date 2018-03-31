if (typeof App !== "object") {
    App = {};
}

App.Function = {
    sortByKey: function(array, key) {
        return array.sort(function(a, b) {
            var x = a[key]; var y = b[key];
            return ((x < y) ? -1 : ((x > y) ? 1 : 0));
        });
    },
    Get: function(url, callback) {
        $.ajax({
            type: "GET",
            url: url,
            contentType: "application/json;charset=utf-8",
            success: function(response) {
                callback(response);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log(response);
            }
        });
    },
    Post: function(url, data, callback) {
        $.ajax({
            type: "POST",
            url: url,
            dataType: 'json',
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            async: true,
            success: function(response) {
                callback(response);
            },
            error: function(response) {
                console.log(response);
            }
        });
    },
    checkAlpha: function(input){
        if($.isArray(input)){
            $.each(input,function(idex,element){
                $(element).on('input',function(){
                    var text=$(this).val();
                    $(this).val(text.replace(/[`~!@#$%^&*()_|+\=?;:'",.<>\{\}\[\]\\]/gi, ''));
                });
            });
        }else{
            $(input).on('input',function(){
                var text=$(this).val();
                $(this).val(text.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>\{\}\[\]\\\/]/gi, ''));
            });
        }
    },
    //type = ['', 'info', 'success', 'warning', 'danger'];
    notify: function(position=[],type='',messaInput='Test thông báo.',element='body',timer =3000,callback =null) {
        return  $.notify({
            icon: "notifications",
            message: messaInput
        }, {
            element: element,
            type: type,
            timer:1000,
            placement: {
                from: position[0],
                align: position[1]
            },
            onClosed:callback
        });
    },
    confirm: function(message, confirm='', cancel='') {
        $("#warning-edit-module .modal-body > p").text(message);
        $('#warning-edit-module').modal('show');
        if(typeof confirm === "function") {
            $("#warning-edit-module .confirm").off();
            $("#warning-edit-module .confirm").click(function(){
                if ($.isFunction(confirm)) {
                    confirm();
                }
            });
        }
        if(typeof cancel === "function") {
            $("#warning-edit-module .cancel").click(function(){
                $("#warning-edit-module .cancel").off();
                if ($.isFunction(cancel)) {
                    cancel();
                }
                $('#warning-edit-module').modal('hide');
            });
        }
    },
    error: function(message, cancel='') {
        $("#error-modal .modal-body > .message").text(message);
        $('#error-modal').modal('show');
        if(typeof cancel === "function") {
            $("#error-modal .cancel").click(function(){
                $("#error-modal .cancel").off();
                if ($.isFunction(cancel)) {
                    cancel();
                }
                $('#error-modal').modal('hide');
            });
        }
    },
	success: function(message, cancel='') {
        $("#success-modal .modal-body > .message").text(message);
        $('#success-modal').modal('show');
        if(typeof cancel === "function") {
            $("#success-modal .cancel").click(function(){
                $("#success-modal .cancel").off();
                if ($.isFunction(cancel)) {
                    cancel();
                }
                $('#success-modal').modal('hide');
            });
        }
    }
};
