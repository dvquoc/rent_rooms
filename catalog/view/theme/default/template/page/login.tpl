<link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">
<div id="wrapper" class="simple-page_wrapper">
    <div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">

        <div id="qc3-body">
            <div class="container">
                <div class="login auth-container" id="client-login" style="">
                    <div class="modal-message" style="display: none;"></div>
                    <p class="auth-header">Đăng nhập</p>
                             
                    
                    <form action="/user/login" method="post" accept-charset="utf-8">
                        <div class="form-errors clearfix" style="display: none;"></div>
                        <div><input type="text" placeholder="Nhập email" class="auth-input" name="email"></div>
                        <div><input type="password" placeholder="Nhập mật khẩu" class="auth-input" name="password"></div>
                        <div class="mgT7">
                            <div class="inline-block auth-none-user-select">
                                <input name="remember" checked="" class="styled-checkbox" id="styled-checkbox-sign-in" type="checkbox" value="value1">
                                <label for="styled-checkbox-sign-in">
                                    <img class="styled-checked-icon" src="/themes/qc3/img/icons/checked_icon.svg">
                                    <span class="styled-checkbox-label">Ghi nhớ tài khoản của tôi</span>
                                </label>
                            </div>
                            <a class="auth-right auth-link login-forgot-password js-action-track_event" data-track_event-category="Link" data-track_event-action="Forgot password" data-track_event-label="Login page">Quên mật khẩu?</a>
                        </div>
                        <button class="auth-btn js-action-track_event" type="submit" data-track_event-category="Button" data-track_event-action="Login" data-track_event-label="Login page">Đăng nhập</button>
                        <div class="login-social">
                            <div class="login-separate-line">
                                <div class="login-line "></div>
                                <span>hoặc đăng nhập với</span>
                                <div class="login-line"></div>
                            </div>
                            <div class="login-social-buttons">
                                <a class="auth-facebook-btn auth-clear-hover auth-clear-visited js-action-track_event" href="/oauth/facebook" data-track_event-category="Button" data-track_event-action="Login FB" data-track_event-label="Login page" >
                                    <div class="auth-facebook-icon">
                                        <img src="/themes/qc3/img/icons/facebook_icon.svg">
                                    </div>
                                    <span>Facebook</span>
                                </a>
                                <a class="auth-google-btn auth-clear-hover auth-clear-visited js-action-track_event" href="/oauth/google" data-track_event-category="Button" data-track_event-action="Login Google" data-track_event-label="Login page">
                                    <div class="auth-google-icon">
                                         <i class="fa fa-google fa-fw"></i>
                                    </div>
                                    <span>Google</span>
                                </a>
                            </div>
                        </div>
                        <div>
                            <span>Chưa có tài khoản Quảng Cáo? </span>
                            <a id="#link-register" class="auth-link js-action-track_event" href="https://cp.qc.coccoc.com/dang-ky-tai-khoan" data-track_event-category="Link" data-track_event-action="Sign up now" data-track_event-label="Login page">Đăng ký ngay </a>
                        </div>
                    </form>
                    <div class="not-verified-email" style="display: none;">
                        <p class="not-verified-email-message"></p>
                        <button class="auth-btn" data-track_event-category="Button" data-track_event-action="BACK TO LOGIN PAGE" data-track_event-label="Login page">QUAY LẠI TRANG ĐĂNG NHẬP</button>
                    </div>
                </div>
                <div class="password-recovery auth-container" style="display: none" id="password-recovery">
                    <p class="auth-header">Khôi Phục Mật Khẩu</p>
                    <p class="password-recovery-success-message"></p>
                    <a class="auth-btn auth-clear-visited js-action-track_event" style="display: none" href="/sign-in" data-track_event-category="Link" data-track_event-action="BACK TO LOGIN PAGE" data-track_event-label="Password Recovery">QUAY LẠI TRANG ĐĂNG NHẬP</a>
                    <form>
                        <div class="form-row">
                            <input type="text" placeholder="Nhập email" class="auth-input" name="email" id="email">
                            <button class="auth-btn js-action-track_event" data-track_event-category="Button" data-track_event-action="Send recover link" data-track_event-label="Password Recovery" type="submit">Gửi đường link khôi phục</button>
                            <p>Chúng tôi sẽ gửi hướng dẫn truy cập vào tài khoản tới địa chỉ email của bạn                .</p>
                        </div>
                    </form>
                </div> 
                <div id="overlay" class="hide">
                    <div id="modal-sign-in" class="popup">
                        <div class="modal-form-header clearfix"><a class="close-popup" href="#">×</a>Đăng nhập</div>
                        <span class="arrow-down"></span>
                        <div class="modal-message"></div>
                        <form action="https://cp.qc.coccoc.com/user/login" method="post" name="frmSignIn" accept-charset="utf-8">

                            <div class="signin-by-social">
                                <div>
                                    <a class="btn-facebook btn-md" href="/oauth/facebook"><span>Facebook</span></a>
                                    <a class="btn-google btn-md" href="/oauth/google"><span>Google</span></a>
                                </div>
                            </div>

                            <div class="signin-by-email">
                                <label class="or-by-email">Hoặc đăng nhập bằng email của bạn</label>

                                <div class="form-errors clearfix"></div>
                                <div class="form-row">
                                    <label for="email">Email</label>
                                    <input type="text" id="email" name="email" class="input-email-only">        
                                </div>
                                <div class="form-row">
                                    <label for="password">Mật khẩu</label>
                                    <input type="password" id="password" name="password" value="">      
                                </div>
                                <div class="form-row mgB5 align-right">
                                    <div class="remember">
                                        <div class="check-button-wrapper  active" data-input="check-remember">
                                            <input type="checkbox" id="remember" name="remember" value="1" class="checkbox-button" style="margin-top:0" checked="checked">
                                        </div>
                                        <label class="inline" for="remember">Ghi nhớ tài khoản của tôi</label>
                                    </div>
                                    <input type="submit" name="btnSubmit" value="Đăng nhập" class="btn-process-form btn-green-border">                      
                                    <div class="form-side-links">
                                        <a id="link-register" class="underline" href="https://cp.qc.coccoc.com/dang-ky-tai-khoan">Đăng ký</a> | <a href="#modal-recovery" class="show-popup underline">Quên mật khẩu?</a>
                                    </div>
                                </div>
                            </div>
                        </form>
                            </div>        
                    <div id="modal-recovery" class="popup">
                        <div class="modal-form-header clearfix"><a class="close-popup" href="#">×</a>@PUB Password recovery</div>
                        <span class="arrow-down"></span>
                        <div class="modal-message clearfix"></div>
                        <form action="/user/recover" method="post" name="frmUserRecover" accept-charset="utf-8" autocomplete="off">
                            <div class="form-errors clearfix"></div>
                                    <div class="form-row">
                                <label for="email">Email</label>
                                <input type="text" id="email" name="email">     </div>
                            <div class="form-row align-right">
                                 <input type="submit" name="btnSubmit" value="Gửi đường link khôi phục">    
                            </div>
                        </form>
                    </div>            
                </div>
            </div>
        </div>
    </div>
</div>

