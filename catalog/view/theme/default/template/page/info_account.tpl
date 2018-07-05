<?php echo $header ;

?>
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
.birthday{
    width: 30%
}
</style>
<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <form action="/cap-nhat" method="post" id="fileForm" role="form">
            <fieldset><legend class="text-center">Thông tin tài khoản <span class="req"><small> Bắt buộc *</small></span></legend>

            <div class="form-group">
            <label for="phonenumber"><span class="req">* </span> Số điện thoại: </label>
                    <input required type="text" name="phonenumber" id="phone" class="form-control phone" maxlength="11" value="<?php echo $user['phone']?>" /> 
            </div>

            <div class="form-group">
                <label for="email"><span class="req">* </span> Email: </label> 
                    <input class="form-control" required type="text" name="email" id = "email"  value="<?php echo $user['email']?>"/>   
                        <div class="status" id="status"></div>
            </div>
            
            <div class="form-group">
                <label for="username"><span class="req"></span> Ngày sinh: </label> 

                    <select name="day" class="birthday">
                        <option value="1">1</option>
                        <?php for($i = 2; $i <= 31; $i++){ ?>
                            <option value="<?php echo $i ?>"><?php echo $i ?></option>
                        <?php }?>
                    </select>

                    <select name="month" class="birthday">
                        <option value="1">1</option>
                        <?php for($i = 2; $i <= 12; $i++){ ?>
                            <option value="<?php echo $i ?>"><?php echo $i ?></option>
                        <?php }?>
                    </select>

                    <select name="year" class="birthday">
                        <option value="1990">1990</option>
                        <?php for($i = 1945; $i <= 2010; $i++){ ?>
                            <option value="<?php echo $i ?>"><?php echo $i ?></option>
                        <?php }?>
                        
                    </select>
                    <div id="errLast"></div>
            </div>

             <div class="form-group">     
                <label for="firstname"><span class="req"></span> Họ tên: </label>
                    <input class="form-control" type="text" name="firstname" id = "txt" value="<?php echo $user['name']?>"/> 
                        <div id="errFirst"></div>    
            </div>

            <div class="form-group">
                <label for="gender"><span class="req"></span> Giới tính: </label> 
                    <input class="form-control" type="text" name="gender" id = "txt" value="<?php echo $user['gender']?>"/>  
                        <div id="errLast"></div>
            </div>

            <div class="form-group">     
                <label for="address"><span class="req"></span> Địa chỉ: </label>
                    <input class="form-control" type="text" name="address" id = "txt"  value="<?php echo $user['address']?>"/> 
                    <div id="errFirst"></div>    
            </div>

            <div class="form-group">     
                <label for="firstname"><span class="req"></span> Hình: </label>
                    <input class="form-control" type="file" name="file" id= "file"  /> 
                    <img id="review_avatar" src="<?php echo $user['image']?>" alt="your image" />
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
<script type="text/javascript">
     function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('#review_avatar').attr('src', e.target.result);
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
    
    $("#file").change(function(){
        readURL(this);
    });
</script>