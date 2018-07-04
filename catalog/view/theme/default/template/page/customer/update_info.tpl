<?php echo $header ;
?>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">
<div id="messenger_dialog" style="display: none;">
    Chúng tôi không thể cập nhật được số điện thoại của bạn , vui lòng nhập số điện thoại để hoàn thành đăng ký và sử dụng đầy đủ tính năng của website chúng tôi.
</div>
<div id="wrapper" class="simple-page_wrapper">
    <div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">
        <div id="qc3-body">
            <div class="container">
                <div class="login auth-container" id="client-login" style="">
                    <div class="modal-message" style="display: none;"></div>
                    <p class="auth-header">Cập nhật thông tin</p>
                    <form id="form_update" action="/cus-update-phone" method="post" accept-charset="utf-8">
                        <div class="form-errors clearfix" style="display: none;"></div>
                        <div><input type="text" maxlength="11" placeholder="Nhập Số điện thoại" class="auth-input" id="phone" name="phone" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');" required></div>
                        <div id="check_phone" style="color: red"></div>
                         <div class="sign-up-terms inline-block auth-none-user-select form-row">
                            <input checked="" name="support" class="support-checkbox" id="support" type="checkbox">
                            <label for="agreement">
                                <span class="styled-checkbox-label">
                                    Đống ý nhận trợ giúp từ bộ phận chăm sóc khách hàng của chúng tôi theo số điện thoại này
                                    </span>
                            </label>
                        </div>
                      <!--   <div><input type="password" placeholder="Nhập mật khẩu" class="auth-input" name="password" required></div> -->
                        <button class="auth-btn js-action-track_event" type="submit"> Đồng ý</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
         $("#messenger_dialog").dialog({
            autoOpen : true, 
            show : "blind",
            hide : "blind",
            height: 150,
            width: 350,
            buttons: {
                Ok: function() {
                  $( this ).dialog( "close" );
                }
            }
          });
         $("#phone").focusout(function(){
            var phone_number = $(this).val();
            $.ajax({
                url:"/cus-check-phone",
                type:"POST",
                data:{
                    phone : phone_number,
                },
                success: function(data){
                    if(data == 'exist'){
                        $('#check_phone').empty();
                        $('#check_phone').append( "Số điện thoại đã tồn tại" );
                        $('#check_phone').delay(3000).fadeOut();
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

