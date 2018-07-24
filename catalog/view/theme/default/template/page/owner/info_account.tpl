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
            <form id="form_update" action="/cap-nhat-chu-tro" method="post" id="fileForm" role="form">
            <fieldset><legend class="text-center">Thông tin tài khoản <span class="req"><small> Bắt buộc *</small></span></legend>

            <div class="form-group">
            <label for="phonenumber"><span class="req">* </span> Số điện thoại: </label>
                    <input  type="text" name="phonenumber" id="phone" class="form-control phone" maxlength="11" value="<?php echo $user['phone']?>" /> 
                    <div id="errPhone"></div>
            </div>

            <div class="form-group">
                <label for="email"><span class="req"> </span> Email: </label> 
                    <input class="form-control" type="text" name="email" id = "email"  value="<?php echo $user['email']?>"/>   
                        <div class="status" id="status"></div>
            </div>

            <div class="form-group">     
                <label for="firstname"><span class="req"></span>Password </label>
                    <input class="form-control" type="password" name="password" id = "password"/> 
            </div>

            <div class="form-group">
                <label for="username"><span class="req"></span> Ngày sinh: </label> </br>
                    <select name="day" class="birthday">
                        <option value="<?php echo $user['birthDay']?>"><?php echo $user['birthDay']?></option>
                        <?php for($i = 2; $i <= 31; $i++){ ?>
                            <option value="<?php echo $i ?>"><?php echo $i ?></option>
                        <?php }?>
                    </select>

                    <select name="month" class="birthday">
                        <option value="<?php echo $user['birthMonth']?>"><?php echo $user['birthMonth']?></option>
                        <?php for($i = 2; $i <= 12; $i++){ ?>
                            <option value="<?php echo $i ?>"><?php echo $i ?></option>
                        <?php }?>
                    </select>

                    <select name="year" class="birthday">
                        <option value="<?php echo $user['birthYear']?>"><?php echo $user['birthYear']?></option>
                        <?php for($i = 1945; $i <= 2010; $i++){ ?>
                            <option value="<?php echo $i ?>"><?php echo $i ?></option>
                        <?php }?>
                        
                    </select>
            </div>

             <div class="form-group">     
                <label for="firstname"><span class="req"></span> Họ tên: </label>
                    <input class="form-control" type="text" name="firstname" id = "name" value="<?php echo $user['name']?>"/> 
            </div>

            <div class="form-group">
                <label for="gender"><span class="req"></span> Giới tính: </label> 
                    <input class="form-control" type="text" name="gender" id = "gender" value="<?php echo $user['gender']?>"/>  
            </div>

            <div class="form-group">     
                <label for="address"><span class="req"></span> Địa chỉ: </label>
                    <input class="form-control" type="text" name="address" id = "address"  value="<?php echo $user['address']?>"/> 
            </div>

            <div class="form-group">     
                <label for="firstname"><span class="req"></span> Hình: </label>
                    <input class="form-control" type="file" name="file" id= "file"  /> 
                    <img id="review_avatar" src="<?php echo $user['image']?>" alt="your image" />
            </div>
        
            <div class="form-group">
                <input class="btn btn-success" type="submit" name="submit_reg" value="Cập nhật">
            </div>
             <div class="form-group">
                <button class="btn btn-cancel" ><a href="/tim-kiem-phong-tro">Cancel</a></button> 
            </div>
            </fieldset>
            </form><!-- ends register form -->
        </div><!-- ends col-6 -->
        <div class="col-md-3"></div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
         $("#form_update").validate({
             rules: {
                phonenumber: {
                    required: true,
                    minlength: 9,
                    maxlength:11,
                },
            },
            messages: {
                phonenumber: {
                    required: "Vui lòng nhập số điện thoại",
                    minlength: "số điện thoại không xác thực",
                    maxlength: "số điện thoại không xác thực",
                },
            },
         });
        // $("#phone").keyup(function(){
        //     var phone_number = $(this).val();
        //     $.ajax({
        //         url:"/ow-check-phone",
        //         type:"POST",
        //         data:{
        //             phone : phone_number,
        //         },
        //         success: function(data){
        //             if(data == 'exist'){
        //                 $('#errPhone').empty();
        //                 $('#errPhone').append( "Số điện thoại đã tồn tại" );
        //                 $('#errPhone').delay(3000).fadeOut();
        //                 $('.btn-success').prop('disabled', true);
        //                 $('.btn-success').css('background', 'grey');
        //             }else{
        //                 $('.btn-success').prop('disabled', false);
        //                 $('.btn-success').css('background', '');
        //             }
        //         }
        //     })
        // });
    });
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