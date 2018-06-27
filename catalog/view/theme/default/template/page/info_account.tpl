<?php echo $header ;

?>
<link href="/public/assets/js/bootstrap/css/qc3-bootstrap.min.css" rel="stylesheet">
<style type="text/css">
fieldset {
    border: thin solid #ccc; 
    border-radius: 4px;
    padding: 20px;
    padding-left: 40px;
    background: #fbfbfb;
}
legend {
   color: #678;
}
.form-control {
    width: 95%;
}
label small {
    color: #678 !important;
}
span.req {
    color:maroon;
    font-size: 112%;
}
</style>
<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <form action="" method="post" id="fileForm" role="form">
            <fieldset><legend class="text-center">Thông tin tài khoản <span class="req"><small> Bắt buộc *</small></span></legend>

            <div class="form-group">
            <label for="phonenumber"><span class="req">* </span> Số điện thoại: </label>
                    <input required type="text" name="phonenumber" id="phone" class="form-control phone" maxlength="11" /> 
            </div>

            <div class="form-group">
                <label for="email"><span class="req">* </span> Email: </label> 
                    <input class="form-control" required type="text" name="email" id = "email"  />   
                        <div class="status" id="status"></div>
            </div>
            
            <div class="form-group">
                <label for="password"><span class="req">* </span> Mật khẩu: </label>
                    <input required name="password" type="password" class="form-control inputpass" minlength="5" maxlength="16"  id="pass1" /> </p>
            </div>

            <div class="form-group">
                <label for="username"><span class="req"></span> Ngày sinh: </label> 
                    <input class="form-control" type="text" name="username" id = "txt" />  
                        <div id="errLast"></div>
            </div>

             <div class="form-group">     
                <label for="firstname"><span class="req"></span> Họ tên: </label>
                    <input class="form-control" type="text" name="firstname" id = "txt"/> 
                        <div id="errFirst"></div>    
            </div>

            <div class="form-group">
                <label for="lastname"><span class="req"></span> Giới tính: </label> 
                    <input class="form-control" type="text" name="lastname" id = "txt"/>  
                        <div id="errLast"></div>
            </div>

            <div class="form-group">     
                <label for="firstname"><span class="req"></span> Địa chỉ: </label>
                    <input class="form-control" type="text" name="firstname" id = "txt"  /> 
                        <div id="errFirst"></div>    
            </div>

            <div class="form-group">     
                <label for="firstname"><span class="req"></span> Hình: </label>
                    <input class="form-control" type="text" name="firstname" id = "txt"  /> 
                        <div id="errFirst"></div>    
            </div>
        
            <div class="form-group">
                <input class="btn btn-success" type="submit" name="submit_reg" value="Cập nhật">
            </div>
            </fieldset>
            </form><!-- ends register form -->
        </div><!-- ends col-6 -->
        <div class="col-md-3"></div>
    </div>
</div>
