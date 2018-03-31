$(document).ready(function() {
    $(document).on('click','.xform-submit',function (e) {
        var data = $(this).parents('form').first().serializeArray();
        var field_required = $(this).parents('form').find('.required');
        if(!$.isEmptyObject(field_required)){
            $.each(field_required,function (key,item) {
                var val_input = $(item).val().trim();
                if(val_input.length==0)
                    $(item).addClass('error');
            })
        }
        $.ajax({
            url: 'index.php?route=api/form',
            dataType: 'json',
            type: 'POST',
            data:  data,
            success: function (json) {
                if(json.error){
                    App.Function.error(json.message);

                }else{
                    App.Function.success(json.message);
                }
            },
            failure: function(errMsg) {
                alert(errMsg);
            }
        });
    });
});