<?php echo $header ;
if(!isset($_COOKIE['origin_ref']))
{
    setcookie('origin_ref', $_SERVER['HTTP_REFERER']);
}
?>
<link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">

<div id="wrapper" class="simple-page_wrapper">
    <div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">
        <div id="qc3-body">
            <div class="container">
                <div class="login auth-container" id="client-login" style="">
                    <div class="modal-message" style="display: none;"></div>
                    <p class="auth-header">Cập nhật thông tin</p>
                    <form id="form_update" action="/test" method="post" accept-charset="utf-8">
                        <div class="form-errors clearfix" style="display: none;"></div>
                        <?php if($phone == ''){?>
                            <div><input type="text" maxlength="11" placeholder="Nhập Số điện thoại" class="auth-input" id="phone" name="phone" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');" required></div>
                            <div id="check_phone" style="color: red"></div>
                        <?php }else{?>
                            <div><input type="text" placeholder="Nhập Email" class="auth-input" name="email"></div>
                        <?php }?>
                        <div><input type="password" placeholder="Nhập mật khẩu" class="auth-input" name="password" required></div>
                        <button class="auth-btn js-action-track_event" type="submit" data-track_event-category="Button" data-track_event-action="Login" data-track_event-label="Login page"> Đồng ý</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
         $("#phone").focusout(function(){
            var phone_number = $(this).val();
            $.ajax({
                url:"/check-phone",
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
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: true,
                    minlength: 5
                },
            },
            messages: {
                phone: {
                    required: "Vui lòng nhập số điện thoại",
                    minlength: "số điện thoại không xác thực",
                    maxlength: "số điện thoại không xác thực",
                },
                email:{
                    required:"Vui lòng nhập emai",
                    email:"Email không chính xac"
                },
                password:{
                    required:"Vui lòng nhập mật khẩu",
                    minlength:"Mật khẩu it nhất 5 ký tự",
                },
            },
        });
    });
</script>

