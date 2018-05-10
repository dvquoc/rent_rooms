
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
                    <div id="filter-rooms-contain" style="cursor: pointer; background-color: #fff; outline: 1px solid #e2e2e2;  line-height: 25px; padding:5px 10px" class="dropdown-toggle" type="button" data-toggle="dropdown"><b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class="fa fa-search"></span> Tìm kiếm:</b></div>
                    <div class="dropdown-menu row" style="padding: 10px 6px 1px 6px;width: calc(100% - 13px); margin-right: 14px; left: 14px;top: 95%;display: none; border-radius: 0px; -webkit-box-shadow:rgba(0, 0, 0, 0.78) 10px 10px 43px -30px;box-shadow: rgba(0, 0, 0, 0.78) 10px 10px 43px -30px; border:1px solid #e2e2e2;">
                        <div id="item_search_city" class="col-md-2 item">
                            <label class="text hidden">Thành Phố</label>
                            <select name="city" class="form-control">
                                <?php foreach($citys as $item){  ?>
                                        <option value="<?php echo $item['city_id']; ?>"><?php echo $item['name']; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <div id="item_search_district" class="col-md-2 item">
                            <label class="text hidden">Quận/Huyện</label>
                            <select name="district" class="form-control">
                                <?php foreach($districts as $item){  ?>
                                <option value="<?php echo $item['district_id']; ?>"><?php echo $item['name']; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                        <div id="item_search_special" class="col-md-2 item">
                            <label class="text hidden">Đường/Khu vực</label>
                            <select name="special" class="form-control">
                                <option value="Gầm-sư-phạm-kỷ-thuật">Gầm sư phạm kỷ thuật</option>
                                <option value="cong-nghe-cao">Khu công nghệ cao</option>
                            </select>
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
                                <option value="1">Đang chạy</option>
                                <option value="0">Đang tắt</option>
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
                    <script type="text/javascript">
                        var params_old = <?php echo $data_fitler ?>;
                        var params = params_old;

                        var updateFilter = function (data) {
                            if(!$.isEmptyObject(data))
                                $('#filter-rooms-contain').html("<b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class=\"fa fa-search\"></span> Tìm kiếm:</b><i class=\"icon-dropdown fa fa-angle-down pull-right\"></i>");
                            else
                                $('#filter-rooms-contain').html("<b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class=\"fa fa-search\"></span> Tìm kiếm:</b><i>Nhập chuột vào để tìm kiếm....</i><i class=\"icon-dropdown fa fa-angle-down pull-right\"></i>");
                            $.each(data,function (key,item) {
                                if(item.length!=0 && item!=-1) {
                                    var textValue = item;
                                    if($("#item_search_"+key).attr("type")!='input')
                                        textValue= $("#item_search_"+key+" select  option[value='"+item+"']").text();

                                    $('#filter-rooms-contain').append('<div style=" display: inline-block;margin: 0px 1px; padding: 0px 7px;background-color: #1e91cf; color: #fff; border-radius: 30px; "><b>' + $("#item_search_" + key + " .text").text() + ' : </b>' + textValue + '</div>');
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
                        });
                        $(".dropdown-menu input").keyup(function () {
                            eval('params.'+ $(this).attr("name") + "= '"+ $(this).val()+ "'");
                            updateFilter(params);
                        });
                    </script>
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
                                <td style="width: 100px;" class="text-center"><?php echo "Hình ảnh"; ?></td>
                                <td class="text-left"><?php if ($filter_data['sort'] == 'name') { ?>
                                    <a href="<?php echo $filter_data['sort']; ?>" class="<?php echo strtolower($filter_data['sort']); ?>">Tên</a>
                                    <?php } else { ?>
                                    <a href="<?php echo $sort_title; ?>">Tên</a>
                                    <?php } ?></td>
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
                                <td class="text-left"><img src="<?php echo $room['image']; ?>" style="border: 1px solid #ccc;border-radius: 3px;padding: 3px;"></td>
                                <td class="text-left"><?php echo $room['name']; ?></td>
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
<script type="text/javascript"><!--
    $('#button-filter').on('click', function() {
        var url = '<?php echo $action_fitler ; ?>&';
        var parts = [];
        var flag = false;
        $.each(params,function (key , item) {
            if(item.length!=0 && item!=-1) {
                parts.push(encodeURIComponent(key) + '=' + encodeURIComponent(item));
                flag = true;
            }
        });
        if(flag)
            url += parts.join('&');
        console.log(url);
        location = url;
    });
    //--></script>
<?php echo $footer; ?>