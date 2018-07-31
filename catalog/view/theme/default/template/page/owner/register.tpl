<?php echo $header ;?>
 <link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">
    <script src="/public/assets/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
 <script src='https://www.google.com/recaptcha/api.js'></script>
<style type="text/css">
    .error{
        color: red;
    }
</style>
<div id="wrapper" class="simple-page_wrapper">
	<div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">
    	<div id="qc3-body">
    		<div class="container">
                 <?php if ($error_warning) { ?>
                <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>
                <?php if ($success) { ?>
                <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                </div>
                <?php } ?>
    			<!--  <p class="text-center">Trang đăng ký cho <b>chủ phòng</b>, Nếu bạn là người tìm phòng <a class="auth-linkjs-action-track_event" href="/cus-dang-ky">vui lòng đăng ký tại đây</a></p> -->
                 <div class="container">
                    <div class="sign-up auth-container " id="client-sign-up">
                        <div class="sign-up-header-container pdR20">
                            <p class="sign-up-header auth-header text-center">Đăng ký </p>
                              <p class="text-center">Nếu bạn đã có tài khoản, <a class="auth-linkjs-action-track_event" href="/dang-nhap-chu-phong">vui lòng đăng nhập tại đây</a></p>
                        </div>
                        <div class="sign-up-container">
                            <div class="sign-up-social">
                                <p class="mgB20">Đăng kí với tài khoản mạng xã hội:</p>
                                <a class="auth-facebook-btn auth-clear-hover auth-clear-visitedjs-action-track_event" href="/dang-ky-fb-chu-phong"><div class="auth-facebook-icon">
                                        <i class="fa fa-facebook fa-fw"></i>
                                    </div>
                                    <span>Facebook</span>
                                </a>
                                <a class="auth-google-btn auth-clear-hover auth-clear-visitedjs-action-track_event" href="/dang-ky-google-chu-phong" >
                                    <div class="auth-google-icon">
                                          <i class="fa fa-google fa-fw"></i>
                                    </div>
                                    <span>Google</span>
                                </a>
                                <p>Chúng tôi không đăng tải bất kỳ thông tin nào lên mạng xã hội Facebook và Google+ của người dùng</p>
                            </div>
                            <div class="sign-up-middle-block">
                                <div class="sign-up-vertical-top-line"></div>
                                <p class="sign-up-middle-text">hoặc</p>
                                <div class="sign-up-vertical-bottom-line"></div>
                            </div>
                            <form id="form_register" accept-charset="utf-8" style="width: 304px;" autocomplete="off">
                                <div class="form-row">
                                     <input type="text" placeholder="Số điện thoại" class="auth-input mgT0" name="phone" id="phone" value="" required oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');">
                                    <div id="check_phone" style="color: red"></div>
                                </div>
                                <div class="form-row">
                                     <input type="text" placeholder="Email" class="auth-input " name="email" id="email" value="" required>
                                </div>
                                <div class="auth-password form-row">
                                    <input type="password" placeholder="Mật khẩu" class="auth-input auth-password-input" name="password" id="password" required>
                                </div>
                                <div class="form-row">
                                    <input type="text" placeholder="Tên" class="auth-input" name="firstname" id="firstname" value="" required>
                                </div>
                         

                                <input type="hidden" id="i_key" name="i_key">
                                <div class="form-row">
                                    <div class="g-recaptcha" data-sitekey="6LfgN2EUAAAAABaWW9V_kzQLRliZnWxg5hp1H__j"></div>
                                    <div class="error-capcha" style="display: none">
                                        <p style="color: red">vui lòng check capcha </p>
                                    </div>
                                </div>
                                    <button class="auth-btn" id="btn-login-ow" type="submit">Đăng ký</button>
                            </form>
                        </div>
                    </div>
                </div>
    		</div>
    	</div>
	</div>
</div>
<?php echo $footer ; ?> 
<script type="text/javascript">
    $(document).ready(function() {
          $("#form_register").validate({
            rules: {
                firstname: "required",
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
                firstname: "Vui lòng nhập tên",
                phone: {
                    required: "Vui lòng nhập số điện thoại",
                    minlength: "số điện thoại không xác thực",
                    maxlength: "số điện thoại không xác thực",
                },
                email:{
                    required:"Vui lòng nhập email",
                    email:"Email không chính xác",
                },
                password:{
                    required:"Vui lòng nhập mật khẩu",
                    minlength:"Mật khẩu it nhất 5 ký tự",
                },
            },
            submitHandler: function(form) {
                $('#form_register').submit(function(event){
                    event.preventDefault();
                    var data_form = $('#form_register').serialize();
                    $.ajax({
                        url:"/dang-ky-form-chu-phong",
                        type:"POST",
                        data: data_form,
                        success: function(re){
                            if(re == 'exist'){
                                $('#check_phone').empty();
                                $('#check_phone').append( "Số điện thoại đã tồn tại" );
                                $('#check_phone').delay(3000).fadeOut();
                            }
                            if(re == 'capcha'){
                                $('.error-capcha').css('display','block')
                            }else{
                                window.location.href = "/tim-kiem-phong-tro";
                            }
                        }
                    }); 
                });
            }
        });
        
        $("#phone").focusout(function(){
            var phone_number = $(this).val();
            $.ajax({
                url:"/kiem-tra-sdt-chu-phong",
                type:"POST",
                data:{
                    phone : phone_number,
                },
                success: function(data){
                    if(data == 'exist'){
                        $('#check_phone').empty();
                        $('#check_phone').append( "Số điện thoại đã tồn tại" );
                        $('#check_phone').delay(3000).fadeOut();
                        $('#btn-login-ow').prop('disabled', true);
                        $('#btn-login-ow').css('background', 'grey');
                    }else{
                        $('#btn-login-ow').prop('disabled', false);
                        $('#btn-login-ow').css('background', '');
                    }
                }
            })
        });
      
    });
</script>