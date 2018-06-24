<?php echo $header ;

?>
 <link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">

<div id="wrapper" class="simple-page_wrapper">
	<div id="container" class="page_container simple-page_container" style="padding-bottom: 60px;">
    	<div id="qc3-body">
    		<div class="container">
    			<script type="text/javascript" src="//www.googleadservices.com/pagead/conversion_async.js" charset="utf-8"></script>
                 <div class="container">
        
                    <div class="sign-up auth-container " id="client-sign-up">
                        <div class="sign-up-header-container pdR20">
                            <p class="sign-up-header auth-header text-center">Đăng ký </p>
                              <p class="text-center">Nếu bạn đã có tài khoản, <a class="auth-linkjs-action-track_event" href="/sign-in" data-track_event-category="Link" data-track_event-action="Sign in here" data-track_event-label="Registration page">vui lòng đăng nhập tại đây</a></p>
                        </div>
                        <div class="not-verified-email" style="display: none;">
                            <p class="not-verified-email-message"></p>
                            <a href="https://cp.qc.coccoc.com/dang-ky-tai-khoan" class="auth-btn auth-clear-visited">QUAY LẠI TRANG ĐĂNG KÍ</a>
                        </div>
                        <div class="sign-up-container">
                            <div class="sign-up-social">
                                <p class="mgB20">Đăng kí với tài khoản mạng xã hội:</p>
                                <a class="auth-facebook-btn auth-clear-hover auth-clear-visitedjs-action-track_event" href="/dang-ky-fb" data-track_event-category="Button" data-track_event-action="Register FB" data-track_event-label="Registration page"><div class="auth-facebook-icon">
                                        <i class="fa fa-facebook fa-fw"></i>
                                    </div>
                                    <span>Facebook</span>
                                </a>
                                <a class="auth-google-btn auth-clear-hover auth-clear-visitedjs-action-track_event" href="/dang-ky-google" data-track_event-category="Button" data-track_event-action="Register Google" data-track_event-label="Registration page">
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
                            <form class="" style="width: 304px;" autocomplete="off">
                                <div class="form-row">
                                     <input type="text" placeholder="Số điện thoại" class="auth-input" name="phone" id="phone" value="">
                                    <div class="form-hint"><p class="form-hint-hint">Bộ phận chăm sóc khách hàng của chúng tôi sẵn sàng trợ giúp bạn theo số điện thoại này</p>
                                    </div>
                                </div>
                                <div class="form-row">
                                     <input type="text" placeholder="Email" class="auth-input mgT0" name="email" id="email" value="">
                                    <div class="form-hint">
                                        <p class="form-hint-hint">
                                            Nhập địa chỉ email hợp lệ. Chúng tôi sẽ gửi thư kích hoạt vào địa chỉ email này sau khi bạn hoàn thành đăng ký                    </p>
                                    </div>
                                </div>
                                <div class="auth-password form-row">
                                    <input type="password" placeholder="Mật khẩu" class="auth-input auth-password-input" name="password" id="password">
                                    <div class="form-hint"><p class="form-hint-hint">Mật khẩu phải có ít nhất 6 ký tự, bao gồm cả số và chữ</p></div>
                                </div>
                                <div class="form-row">
                                    <input type="text" placeholder="Tên" class="auth-input" name="firstname" id="firstname" value="">
                                    <div class="form-hint">
                                        <p class="form-hint-hint">
                                            Vui lòng điền đầy đủ họ tên theo CMT/Hộ chiếu                        . Những thông tin này sẽ được sử dụng để nhận diện khách hàng (khi cần thiết)                        .
                                        </p>
                                    </div>
                                </div>
                                
                                <div class="sign-up-terms inline-block auth-none-user-select form-row">
                                    <input checked="" name="agreement" class="styled-checkbox" id="agreement" type="checkbox">
                                    <label for="agreement">
                                        <img class="styled-checked-icon" src="/themes/qc3/img/icons/checked_icon.svg">
                                        <span class="styled-checkbox-label">
                                            Tôi đồng ý với <a class="auth-link" href="/pages/terms-of-use" target="_blank">điều kiện và điều khoản</a><br> của Cốc Cốc Quảng Cáo</span>
                                    </label>
                                </div>

                                <input type="hidden" id="i_key" name="i_key">
                                <div class="form-row">
                                    <input type="text" id="captcha" name="captcha" class="hide">
                                    <div class="g-recaptcha" data-sitekey="6Lf3aD8UAAAAAO8wyZH1XbRiEOrTQayoW00PjHj7"><div style="width: 304px; height: 78px;"><div><iframe src="https://www.google.com/recaptcha/api2/anchor?ar=1&amp;k=6Lf3aD8UAAAAAO8wyZH1XbRiEOrTQayoW00PjHj7&amp;co=aHR0cHM6Ly9jcC5xYy5jb2Njb2MuY29tOjQ0Mw..&amp;hl=vi&amp;v=v1528855115741&amp;size=normal&amp;cb=bc8tiolbesrh" width="304" height="78" role="presentation" frameborder="0" scrolling="no" sandbox="allow-forms allow-popups allow-same-origin allow-scripts allow-top-navigation allow-modals allow-popups-to-escape-sandbox"></iframe></div><textarea id="g-recaptcha-response" name="g-recaptcha-response" class="g-recaptcha-response" style="width: 250px; height: 40px; border: 1px solid #c1c1c1; margin: 10px 25px; padding: 0px; resize: none;  display: none; "></textarea></div></div>
                                </div>
                                    <button class="auth-btn js-action-track_event" data-track_event-category="Button" data-track_event-action="Register" data-track_event-label="Registration page" type="submit">Đăng ký</button>
                            </form>
                        </div>
                        <div class="sign-up-success" style="display: none;">
                            <p class="sign-up-success-message"></p>
                            <a href="https://cp.qc.coccoc.com/dang-ky-tai-khoan" class="auth-btn auth-clear-visited js-action-track_event" data-track_event-category="Link" data-track_event-action="BACK TO SIGN UP PAGE" data-track_event-label="Registration page">QUAY LẠI TRANG ĐĂNG KÍ</a>
                        </div>
                    </div>
                </div>
    		</div>
    	</div>
	</div>
</div>