
<?php echo $header; ?>
<style type="text/css">

</style>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 pull-right text-right"><a href="<?php echo $add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> Tạo mới</a>
                    <button type="button" class="btn btn-danger" onclick="delete_item()"> <i class="fa fa-trash-o"></i> Xóa</button>
                </div>
                <div id="filter-rooms" class="filter col-md-10" style="position: relative; padding-right: 0px;">
                    <div id="filter-rooms-contain" style="cursor: pointer; background-color: #fff; outline: 1px solid #e2e2e2;  line-height: 25px; padding:5px 10px" class="dropdown-toggle view-filter-search" type="button" data-toggle="dropdown">
                        <b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class="fa fa-search"></span> Tìm kiếm:</b>
                    </div>
                    <div class="dropdown-menu row" style="background-color: #fbfbfb; padding: 10px 6px 1px 6px;width: calc(100% - 13px); margin-right: 14px; left: 14px;top: 95%;display: none; border-radius: 0px; -webkit-box-shadow:rgba(0, 0, 0, 0.78) 10px 10px 43px -30px;box-shadow: rgba(0, 0, 0, 0.78) 10px 10px 43px -30px; border:1px solid #e2e2e2;">
                           <div id="item_search_name" class="col-md-2 item">
                            <label class="text hidden">Tên khu vực</label>
                            <input type="text" name="name" class="form-control" value="<?php echo ($data_filter['name'] == -1)?'':$data_filter['name']?>">
                            
                        </div>
                        <div id="item_search_city_id" class="col-md-2 item">
                            <label class="text hidden">Thành Phố</label>
                            <select name="city_id" class="form-control">
                                <?php foreach($citys as $item){  ?>
                                    <?php if($data_filter['city_id'] == $item['city_id']) { ?>
                                            <option selected="selected" value="<?php echo $item['city_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } else { ?>
                                            <option value="<?php echo $item['city_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                        <div id="item_search_district_id" class="col-md-2 item">
                            <label class="text hidden">Quận/Huyện</label>
                            <select name="district_id" class="form-control">
                                <?php foreach($districts as $item){  ?>
                                    <?php if($data_filter['district_id'] == $item['district_id']) { ?>
                                        <option selected value="<?php echo $item['district_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $item['district_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                       <!--  <div id="item_search_location" class="col-md-2 item">
                            <label class="text hidden">Thiết lập khu vự tìm kiếm</label>
                            <select name="location" class="form-control">
                                <?php if($data_filter["location"] == 1) {  ?>
                                    <option selected = "selected" value="1">Đã có</option>
                                    <option  value="0">Chưa có</option>
                                <?php }else{ ?>
                                    <option  value="1">Đã có</option>
                                    <option selected = "selected"  value="0">Chưa có</option>
                                <?php } ?>
                            </select>
                        </div> -->
                        <div class="col-md-2 item text-right pull-right">
                            <button type="button" id="cancel-filter" class="btn btn-danger pull-right"><i class="fa fa-times"></i> Hủy</button>
                            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> Áp dụng</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
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
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-list"></i> Danh sách</h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-room">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <td style="width: 1px;" class="text-center"><input id="slall" type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                <td class="text-center">
                                    Tên khu vực đặt biệt
                                </td>
                                <td class="text-center" >Thông tin khu vực</td>
                                <td class="text-center" width="150px">Thông tin dữ liệu</td>
                                <td class="text-right" width="150px">Hành động</td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($list_area) { ?>
                                <?php foreach ($list_area as $item) { ?>
                                    <tr>
                                        <td>
                                             <input class="check_box" type="checkbox" name="selected" value="<?php echo $item['id_area']; ?>" />
                                        </td>
                                        <td class="text-center">
                                            <?php echo $item['name'] ?>
                                           <!--  <?php if (in_array($list['street_id'], $selected)) { ?>
                                            <input type="checkbox" name="selected[]" value="<?php echo $room['street_id']; ?>" checked="checked" />
                                            <?php } else { ?>
                                            <input type="checkbox" name="selected[]" value="<?php echo $room['street_id']; ?>" />
                                            <?php } ?> -->
                                        </td>
                                        <td class="text-left"><?php echo $item['district']?> <?php echo $item['city']?></td>
                                        <td class="text-left"><span class="feature"> <?php echo !empty($item['area']) ? 'Đã có dữ liệu': 'Chưa có dữ liệu'; ?></span></td>
                                        <td class="text-right"><a href="<?php echo $item['edit']?>" data-toggle="tooltip" title="Chỉnh sửa" class="btn btn-primary" onclick="edit('<?php echo $item['_id']?>')"><i class="fa fa-pencil"></i></a></td>
                                    </tr>
                                <?php } ?>
                            <?php } else {?>
                                <tr>
                                    <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
                                </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </form>
                <div class="row">
                    <div class="col-sm-6 text-left"><?php echo $paginations['pagination']; ?></div>
                    <div class="col-sm-6 text-right"><?php echo $paginations['results']; ?></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var selected = [];
    var nonselected = [];
    $( document ).ready(function(){
        $('.check_box').change(function() {
            if($('#slall').is(':checked')){
                $('input[name=selected]').map(function() {
                    if($(this).is(':checked')){
                        var index = $.inArray($(this).val(),nonselected);
                        if(index != -1){
                            nonselected.splice(index,1);
                        }
                    }else{
                        var index = $.inArray($(this).val(),nonselected);
                        if(index === -1){
                            nonselected.push($(this).val());
                        }
                    }
                });
            }else{
                $('input[name=selected]').map(function() {
                    if($(this).is(':checked')){
                        var index = $.inArray($(this).val(),selected);
                        if(index === -1){
                            selected.push($(this).val());
                        }
                    }else{
                        var index = $.inArray($(this).val(),selected);
                        if(index != -1){
                            selected.splice(index,1);
                        }
                    }
                });
            }
        });

    }); 
    
    function delete_item(){
        $.ajax({
            url: 'index.php?route=location/special/delete&token=<?php echo $token; ?>',
            type:'POST',
            data:{
                selected:selected
            },
            success: function(success) {
               location.reload();
            }
        });
    }
    $('#button-filter').on('click', function() {
        var url = '<?php echo $action_fitler ; ?>&';
        var parts = [];
        var flag = false;
        $.each(params,function (key , item) {
            if(item !==null && item.length!=0 && item!=-1) {
                parts.push(encodeURIComponent(key) + '=' + encodeURIComponent(item));
                flag = true;
            }
        });
        if(flag)
            url += parts.join('&');
        console.log(url);
        location = url;
    });
    </script>

    <script type="text/javascript">
        var params_old = <?php echo json_encode($data_filter); ?>;
        var params = params_old;
        var district_id = params_old.district;
        var updateFilter = function (data) {
            if(!$.isEmptyObject(data))
                $('#filter-rooms-contain').html("<b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class=\"fa fa-search\"></span> Tìm kiếm:</b><i class=\"icon-dropdown fa fa-angle-down pull-right\"></i>");
            else
                $('#filter-rooms-contain').html("<b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class=\"fa fa-search\"></span> Tìm kiếm:</b><i>Nhập chuột vào để tìm kiếm....</i><i class=\"icon-dropdown fa fa-angle-down pull-right\"></i>");

            $.each(data,function (key,item) {
                if(item !== null && item.length!=0 && item!=-1 && key != 'type') {

                    var textValue = item;
                    if($('select[name="'+key+'"]').is('select')){
                        textValue= $("#item_search_"+key+" select  option[value='"+item+"']").text();
                    }

                    if(key =='special')
                        textValue= $("#item_search_"+key+"_face input").val();

                    $('#filter-rooms-contain').append('<div class="item"><b>' + $("#item_search_" + key + " .text").text() + ' : </b>' + textValue + '</div>');
                }
            });
            params = data;
        }
        updateFilter(params_old);
        $("#filter-rooms-contain").click(function () {
            $(this).next('.dropdown-menu').toggle();
        });
        $(window).click(function () {
            $("#filter-rooms-contain").next('.dropdown-menu').hide();
        });
        $(".dropdown-menu").click(function (event) {
            event.stopPropagation();
        });
        $("#cancel-filter").click(function () {
            updateFilter(params_old);
            $("#filter-rooms-contain").next('.dropdown-menu').hide();
        });
        $("#button-filter").click(function () {
            $("#filter-rooms-contain").next('.dropdown-menu').hide();
        });
        $(".dropdown-menu select").change(function () {
            eval('params.'+ $(this).attr("name") + "= '" + $(this).find('option:selected').val() +"'");
            updateFilter(params);
            if($(this).attr('name') == 'city_id'){
                $.ajax({
                    url: 'index.php?route=catalog/rooms/getDistricts&token=<?php echo $token; ?>&city_id='+$(this).val(),
                    dataType: 'json',
                    success: function(json) {
                        $('select[name=\'district_id\']').html('');
                        $.map(json, function(item) {
                            $('select[name=\'district_id\']').append('<option value="'+item.id+'">'+item.name+'</option>');
                        });
                    }
                });
            }
        });

        $(".dropdown-menu input").keyup(function () {
            eval('params.'+ $(this).attr("name") + "= '"+ $(this).val()+ "'");
            updateFilter(params);
        });
    </script>
<style>
    .view-filter-search .item{
        display: inline-block;
        margin: 0px 3px;
        padding: 0px 7px;
        background-color: #b8def3;
        color: #000;
        border-radius: 2px;
        border: 1px solid #84c9ef;
        margin-bottom: 0px!important;
        font-size: 13px;
    }
    table .feature{
        background-color: #9ddff3;
        color: #000;
        border-radius: 4px;
        border: 1px solid #76bde4;
        padding: 2px 7px;
    }
    #filter-rooms .item {
        margin-bottom: 10px;
        padding: 0 3px;
    }
</style>
<?php echo $footer; ?>