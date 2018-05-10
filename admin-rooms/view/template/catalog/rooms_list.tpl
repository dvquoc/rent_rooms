
<?php echo $header; ?>
<style type="text/css">
    #filter-rooms .item{
        margin-bottom: 10px;
        padding:0 3px;
    }
    .icon-dropdown{
        font-size: 25px;
        background-color: #d2d2d2;
        color: #040404;
        width: 25px;
        height: 25px;
        text-align: center;
        margin-right: -4px;
        outline: 1px solid #bdbdbd;
    }
</style>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 pull-right text-right"><a href="<?php echo $add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> Tạo mới</a>
                    <button type="button" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-room').submit() : false;"><i class="fa fa-trash-o"></i> Xóa</button>
                </div>
                <div id="filter-rooms" class="filter col-md-10" style="position: relative; padding-right: 0px;">
                    <div id="filter-rooms-contain" style="cursor: pointer; background-color: #fff; outline: 1px solid #e2e2e2;  line-height: 25px; padding:5px 10px" class="dropdown-toggle view-filter-search" type="button" data-toggle="dropdown">
                        <b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class="fa fa-search"></span> Tìm kiếm:</b>
                    </div>
                    <div class="dropdown-menu row" style="background-color: #fbfbfb; padding: 10px 6px 1px 6px;width: calc(100% - 13px); margin-right: 14px; left: 14px;top: 95%;display: none; border-radius: 0px; -webkit-box-shadow:rgba(0, 0, 0, 0.78) 10px 10px 43px -30px;box-shadow: rgba(0, 0, 0, 0.78) 10px 10px 43px -30px; border:1px solid #e2e2e2;">
                        <div id="item_search_city" class="col-md-2 item">
                            <label class="text hidden">Thành Phố</label>
                            <select name="city" class="form-control">
                                <?php foreach($citys as $item){  ?>
                                    <?php if($data_filter['city'] == $item['city_id']) { ?>
                                            <option selected="selected" value="<?php echo $item['city_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } else { ?>
                                            <option value="<?php echo $item['city_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                        <div id="item_search_district" class="col-md-2 item">
                            <label class="text hidden">Quận/Huyện</label>
                            <select name="district" class="form-control">
                                <?php foreach($districts as $item){  ?>
                                    <?php if($data_filter['district'] == $item['district_id']) { ?>
                                        <option selected value="<?php echo $item['district_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } else { ?>
                                        <option value="<?php echo $item['district_id']; ?>"><?php echo $item['name']; ?></option>
                                    <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                        <div id="item_search_special_face" class="col-md-2 item">
                            <label class="text hidden">Đường/Khu vực</label>
                            <input name="special_face" value="<?php echo $text_special; ?>" placeholder="Nhập đường/khu vực đặc biệt" id="input-special-face" class="form-control"/>
                        </div>
                        <div id="item_search_special" class="col-md-2 item" type="input">
                            <label class="text hidden">Đường/Khu vực</label>
                            <input name="special" placeholder="Giá trị khu vực" id="input-special" value="<?php echo $data_filter['special']; ?>"  class="form-control"/>
                        </div>
                        <div id="item_search_type" class="col-md-2 item" type="input">
                            <label class="text hidden">Loai khu vực</label>
                            <input name="type" id="input-type" placeholder="Loai khu vực" value="<?php echo $data_filter['type']; ?>"  class="form-control"/>
                        </div>
                        <div id="item_search_ads" class="col-md-2 item">
                            <label class="text hidden">Loại tin</label>
                            <select name="ads" class="form-control">
                                <option value="1">Tin quảng cáo</option>
                                <option value="0">Tin bình thường</option>
                            </select>
                        </div>
                        <div id="item_search_ads_position" class="col-md-2 item">
                            <label class="text hidden">Vị trí quảng cáo</label>
                            <select name="ads_position" class="form-control">
                                <option value="1">Home</option>
                                <option value="0">search</option>
                            </select>
                        </div>
                        <div id="item_search_status" class="col-md-2 item">
                            <label class="text hidden">Trạng thái</label>
                            <select name="status" class="form-control">
                                <?php if($data_filter["status"] == 1) {  ?>
                                    <option selected = "selected" value="1">Đang chạy</option>
                                    <option  value="0">Đang tắt</option>
                                <?php }else{ ?>
                                    <option  value="1">Đang chạy</option>
                                    <option selected = "selected"  value="0">Đang tắt</option>
                                <?php } ?>
                            </select>
                        </div>
                        <div id="item_search_close_door" class="col-md-2 item">
                            <label class="text hidden">Giờ Giấc</label>
                            <select name="close_door" class="form-control">
                                <option value="0">Tự do</option>
                                <option value="1">Ràng buột</option>
                            </select>
                        </div>
                        <div id="item_search_price" class="col-md-2 item" type="input">
                            <label class="text hidden">Giá thuê</label>
                            <input type="text" name="price" value="" placeholder="Lọc theo giá" id="input-price" class="form-control" />
                        </div>
                        <div id="item_search_acreage" class="col-md-2 item" type="input">
                            <label class="text hidden">Diện tích</label>
                            <input type="text" name="acreage" value="" placeholder="Diện tích" id="input-acreage" class="form-control" />
                        </div>
                        <div id="item_search_name" class="col-md-2 item" type="input">
                            <label class="text hidden">Tên</label>
                            <input type="text" name="name" value="" placeholder="Tên..." id="input-name" class="form-control" />
                        </div>
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
                                <td style="width: 1px;" class="text-center"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
                                <td class="text-left"><?php if ($filter_data['sort'] == 'name') { ?>
                                    <a href="<?php echo $filter_data['sort']; ?>" class="<?php echo strtolower($filter_data['sort']); ?>">Tên</a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_title; ?>">Tên hiển thị</a>
                                    <?php } ?>
                                </td>
                                <td class="text-right" width="150px">Giá thuê </td>
                                <td class="text-right" width="150px">Diện tích</td>
                                <td style="width: 150px;" class="text-center">Tin quảng cáo</td>
                                <td style="width: 150px;" class="text-center">Ngày chạy</td>
                                <td style="width: 150px;" class="text-center">Ngày kết thúc</td>
                                <td class="text-right">Hành động</td>
                            </tr>
                            </thead>
                            <tbody>
                            <?php if ($rooms) { ?>
                            <?php foreach ($rooms as $room) { ?>
                            <tr>
                                <td class="text-center"><?php if (in_array($room['room_id'], $selected)) { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $room['room_id']; ?>" checked="checked" />
                                    <?php } else { ?>
                                    <input type="checkbox" name="selected[]" value="<?php echo $room['room_id']; ?>" />
                                    <?php } ?></td>
                                <td class="text-left"><?php echo $room['name']; ?></td>
                                <td class="text-right"><?php echo $room['text_price']; ?></td>
                                <td class="text-right"><?php echo $room['text_acreage']; ?></td>
                                <td class="text-left"><span class="feature"> <?php echo $room['ads'] ? 'Tin quảng cáo': 'Tin bình thường'; ?></span></td>
                                <td class="text-left"><?php echo $room['from_date']; ?></td>
                                <td class="text-left"><?php echo $room['to_date']; ?></td>
                                <td class="text-right"><a href="<?php echo $room['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_edit; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
                            </tr>
                            <?php } ?>
                            <?php } else { ?>
                            <tr>
                                <td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
                            </tr>
                            <?php } ?>
                            </tbody>
                        </table>
                    </div>
                </form>
                <div class="row">
                    <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
                    <div class="col-sm-6 text-right"><?php echo $results; ?></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
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
                    if($("#item_search_"+key).attr("type")!='input')
                        textValue= $("#item_search_"+key+" select  option[value='"+item+"']").text();

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
            eval('params.'+ $(this).attr("name").replace('-','_') + "= '" + $(this).find('option:selected').val() +"'");
            updateFilter(params);
            if($(this).attr('name') == 'city'){
                $.ajax({
                    url: 'index.php?route=catalog/rooms/getDistricts&token=<?php echo $token; ?>&city_id='+$(this).val(),
                    dataType: 'json',
                    success: function(json) {
                        $('select[name=\'district\']').html('');
                        $.map(json, function(item) {
                            $('select[name=\'district\']').append('<option value="'+item.id+'">'+item.name+'</option>');
                        });
                    }
                });
            }
            if($(this).attr('name') == 'district'){
                district_id = $(this).val();
            }
        });

        $(".dropdown-menu input").keyup(function () {
            eval('params.'+ $(this).attr("name").replace('-','_') + "= '"+ $(this).val()+ "'");
            updateFilter(params);
        });

        $('input[name=\'special_face\']').autocomplete({
            'source': function(request, response) {
                $.ajax({
                    url: 'index.php?route=catalog/rooms/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request)+'&district_id='+district_id,
                    dataType: 'json',
                    success: function(json) {
                        response($.map(json, function(item) {
                            if(item['type']=='street')
                                return {
                                    label: 'Gần đường: '+item['name'],
                                    value: item['id'],
                                    type: item['type']
                                };
                            else
                                return {
                                    label: 'Gần: '+item['name'],
                                    value: item['id'],
                                    type: item['type']
                                };
                        }));
                    }
                });
            },
            'select': function(item) {
                $('input[name=\'special-face\']').val(item.label);
                $('input[name=\'special\']').val(item.value);
                $('input[name=\'type\']').val(item.type);
                params.special = item.value;
                params.type = item.type;
                updateFilter(params);
            }
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
</style>
<?php echo $footer; ?>