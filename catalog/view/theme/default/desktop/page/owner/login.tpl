<?php echo $header ; ?> 
<link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">
<script src='https://www.google.com/recaptcha/api.js'></script>
<div id="wrapper" class="simple-page_wrapper">
    <div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">

        <div id="qc3-body">
            <div class="container">
                <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>
                <div class="login auth-container" id="client-login" style="">
                    <div class="modal-message" style="display: none;"></div>
                    <p class="auth-header">Đăng nhập chủ phòng</p>
                    <form id="form_login" accept-charset="utf-8">
                        <div id="form_error" class="form-errors clearfix" style="display: none;color: red"></div>
                        <div><input type="text" id="phone" placeholder="Nhập Số điện thoại" class="auth-input" name="sdt" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');" required></div>
                        <div><input type="password" id="password" placeholder="Nhập mật khẩu" class="auth-input" name="password" required></div>
                        <div class="mgT7">
                        </div>
                         <div class="form-row">
                            <div class="g-recaptcha" data-sitekey="6LfgN2EUAAAAABaWW9V_kzQLRliZnWxg5hp1H__j"></div>
                            <div class="error-capcha" style="display: none">
                                <p style="color: red">vui lòng check capcha </p>
                            </div>
                        </div>
                        <button class="auth-btn" onclick="login()">Đăng nhập</button>
                        <div class="login-social">
                            <div class="login-separate-line">
                                <div class="login-line "></div>
                                <span>hoặc đăng nhập với</span>
                                <div class="login-line"></div>
                            </div>
                            <div class="login-social-buttons">
                                <a class="auth-facebook-btn auth-clear-hover auth-clear-visited js-action-track_event" href="/dang-nhap-chu-phong/facebook" >
                                    <div class="auth-facebook-icon">
                                        <i class="fa fa-facebook fa-fw"></i>
                                    </div>
                                    <span>Facebook</span>
                                </a>
                                <a class="auth-google-btn auth-clear-hover auth-clear-visited js-action-track_event" href="/dang-nhap-chu-phong/google">
                                    <div class="auth-google-icon">
                                         <i class="fa fa-google fa-fw"></i>
                                    </div>
                                    <span>Google</span>
                                </a>
                            </div>
                        </div>
                        <div>
                            <span>Chưa có tài khoản chủ chủ phòng? </span>
                            <a id="#link-register" class="auth-link js-action-track_event" href="/dang-ky-chu-phong">Đăng ký ngay </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $footer ; ?> 
<script type="text/javascript">
   
    function login(){
        var phone = $('input[name=sdt]').val();
        var password = $('input[name=password]').val();
        if(phone.length != 0 && password.length != 0){
             var form_data =  $("#form_login").serialize();
            $.ajax({
                url: '/dang-nhap-form-chu-phong',
                type:'POST',
                data:form_data,
                success: function(data){
                    if(data == 2){
                        $('.error-capcha').css('display','block');
                    }else{
                        if(data == 0){
                            $('#form_error').empty();
                            $('#form_error').css('display','block');
                            $('#form_error').append( "Tài khoản mật khẩu không chính xác" );
                            $('#form_error').delay(3000).fadeOut();
                            grecaptcha.reset();  
                        }else
                            window.location.href = "/quan-ly-phong-tro";
                    }
                }
            });
        }else{
            $('#form_error').empty();
            $('#form_error').css('display','block');
            $('#form_error').append( "Tài khoản mật khẩu không chính xác" );
            $('#form_error').delay(1000).fadeOut(); 
        }
        event.preventDefault(); 
    }
</script>
