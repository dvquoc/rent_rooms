<?php echo $header?>
<style type="text/css">
	.login {
     display: inline-block;
    position: fixed;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    width: 800px;
    height: 300px;
    margin: auto;
    background-color: #f3f3f3;">
}
</style>
<div class="container login">
    <div class="row">
        <div class="col-md-6">
            <h1 class="text-center login-title">Login</h1>
            <div class="account-wall">
                <form class="form-signin">
                <input type="text" class="form-login" placeholder="Username" required autofocus><br>
                <input type="password" class="form-login" placeholder="Password" required><br>
                <label class="checkbox pull-left">
                    <input type="checkbox" value="remember-me">
                    Remember me
                </label><br>
                <button class="btn-login" type="submit">
                    Sign in</button>
                </form>
            </div>
        </div>
        <div class="col-md-6">
         	<p>If you don't have account click the button below to create your account</p>
         	<button>CREATE ACCOUNT</button>
         	<P>OR</P>
         	<button>SIGN IN WITH FACEBOOK</button>
         	<button>SIGN IN WITH GOOGLE</button>
        </div>
    </div>
    <div class="row">
    	<div class="col-md-12">
    		<p>so you can't get into your account? Did you <a href="">forget password</a></p>
    	</div>
    </div>
</div>