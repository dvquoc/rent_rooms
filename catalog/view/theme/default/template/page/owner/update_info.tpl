<?php echo $header ; 
?>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">
<script src="/public/assets/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
<style type="text/css">
    #phone-error{
        color: red;
    }
</style>
<div id="myModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Thông báo</h4>
            </div>
            <div class="modal-body">
                <p>Chúng tôi không thể cập nhật được số điện thoại của bạn , vui lòng nhập số điện thoại để hoàn thành đăng ký và sử dụng đầy đủ tính năng của website chúng tôi.</p>
                <p class="text-warning"><small>Nêu bạn không hoàn thành bước này chúng thôi không thể tạo tài khoản cho bạn</small></p>
            </div>
            <div class="modal-footer">
                <button type="button" id="btn_ok_1"  class="btn btn-primary" data-dismiss="modal">Đồng ý</button>
            </div>
        </div>
    </div>
</div>
<div id="wrapper" class="simple-page_wrapper">
    <div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">
        <div id="qc3-body">
            <div class="container">
                <div class="login auth-container" id="client-login" style="">
                    <div class="modal-message" style="display: none;"></div>
                    <p class="auth-header">Cập nhật thông tin</p>
                    <form id="form_update" action="/cap-nhat-sdt-chu-phong" method="post" accept-charset="utf-8">
                        <div class="form-errors clearfix" style="display: none;"></div>
                        <div><input type="text" maxlength="11" placeholder="Nhập Số điện thoại" class="auth-input" id="phone" name="phone" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');" required></div>
                        <div id="check_phone" style="color: red"></div>
                        <a class="auth-btn js-action-track_event" id="a-submit"> Đồng ý</a>
                        <button class="auth-btn js-action-track_event" id="btn-submit" style="display: none"> Đồng ý</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $("#myModal").modal('show');
         $("#myModal").on("click","btn-primary", function(){
            
         })
        $("#btn_ok_1").click(function (e) {
            $( "#phone" ).focus();
        })
         $("#a-submit").click(function(){
            var phone_number = $('#phone').val();
            $.ajax({
                url:"/kiem-tra-sdt-chu-phong",
                type:"POST",
                data:{
                    phone : phone_number,
                },
                success: function(data){
                    $('#check_phone').fadeIn(1000).text("");
                    if(data == 'exist'){
                        $('#check_phone').empty();
                        $('#check_phone').append( "Số điện thoại đã tồn tại" );
                        $('#check_phone').fadeOut(1000);
                        return false;
                    }else{
                        $('#btn-submit').click();
                    }
                }
            })
        });
        $("#form_update").validate({
            rules: {
                phone: {
                    required: true,
                    minlength: 9,
                    maxlength:11,
                },
            },
            messages: {
                phone: {
                    required: "Vui lòng nhập số điện thoại",
                    minlength: "số điện thoại không xác thực",
                    maxlength: "số điện thoại không xác thực",
                },
            },
        });
    });
</script>

