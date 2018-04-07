
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
                    <div class="dropdown-menu row" style="padding: 10px 6px 1px 6px;width: calc(100% - 28px); margin-right: 14px; left: 14px;top: 95%;display: none; border-radius: 0px; -webkit-box-shadow:rgba(0, 0, 0, 0.78) 10px 10px 43px -30px;box-shadow: rgba(0, 0, 0, 0.78) 10px 10px 43px -30px; border:1px solid #e2e2e2;">
                        <div class="col-md-2 item">
                            <select name="city" class="form-control">
                                <option value="ho-chi-minh">Hồ Chí Minh</option>
                                <option value="da-nang">Đà Nẵng</option>
                                <option value="ha-noi">Hà Nội</option>
                                <option value="binh-duong">Bình Dương</option>
                                <option value="Đồng Nai">Đồng Nai</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <select name="district" class="form-control">
                                <option value="thu-duc">Quận Thủ Đức</option>
                                <option value="binh-thanh">Quận Bình Thạnh</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <select name="special" class="form-control">
                                <option value="-1">-- Khu vực đặt biệt --</option>
                                <option value="Gầm-sư-phạm-kỷ-thuật">Gầm sư phạm kỷ thuật</option>
                                <option value="cong-nghe-cao">Khu công nghệ cao</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <select name="ads" class="form-control">
                                <option value="1">Tin quảng cáo</option>
                                <option value="0">Tin bình thường</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <select name="ads_position" class="form-control">
                                <option value="1">-- Vị trí quảng cáo --</option>
                                <option value="1">Home</option>
                                <option value="0">search</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <select name="status" class="form-control">
                                <option value="-1">-- Tình trạng --</option>
                                <option value="1">Đang chạy</option>
                                <option value="0">Đang tắt</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <select name="close_door" class="form-control">
                                <option value="-1">-- Giờ Giấc --</option>
                                <option value="0">Tự do</option>
                                <option value="1">Ràng buột</option>
                            </select>
                        </div>
                        <div class="col-md-2 item">
                            <input type="text" name="price" value="" placeholder="Lọc theo giá" id="input-price" class="form-control" />
                        </div>
                        <div class="col-md-2 item">
                            <input type="text" name="acreage" value="" placeholder="Diện tích" id="input-acreage" class="form-control" />
                        </div>
                        <div class="col-md-2 item">
                            <input type="text" name="name" value="" placeholder="Tên..." id="input-name" class="form-control" />
                        </div>
                        <div class="col-md-2 item text-right pull-right">
                            <button type="button" id="cancel-filter" class="btn btn-danger pull-right"><i class="fa fa-times"></i> Hủy</button>
                            <button type="button" id="button-filter" class="btn btn-primary pull-right"><i class="fa fa-search"></i> Áp dụng</button>
                        </div>
                    </div>
                    <script type="text/javascript">
                        var params_old = {
                            city: ['230','Thành phố','Hồ Chí Minh'],
                            district: ['1242','Quận/Huyện','Thủ đức'],
                            special: ['123','Khu vực','Gần sư phạm kỷ thuật'],
                            ads: ['1','Loại tin','Tin quảng cáo'],
                            ads_position: ['','Vị trí ads','Trang search'],
                            status: ['','Tình trạng','Đang chạy'],
                            close_door: ['','Giờ giấc','20h'],
                            price: ['','Giá thuê','1.5'],
                            acreage: ['','Diện tích','20'],
                            name: ['','Tên','Tên tin đăng']
                        };
                        var params = {
                            city: params_old.city,
                            district: params_old.district,
                            special: params_old.special,
                            ads: params_old.ads,
                            ads_position: ['','Vị trí ads','Trang search'],
                            status: ['','Tình trạng','Đang chạy'],
                            close_door: ['','Giờ giấc','20h'],
                            price: ['','Giá thuê','1.5'],
                            acreage: ['','Diện tích','20'],
                            name: ['','Tên','Tên tin đăng']
                        };

                        var updateFilter = function (data) {
                            if(!$.isEmptyObject(data))
                                $('#filter-rooms-contain').html("<b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class=\"fa fa-search\"></span> Tìm kiếm:</b><i class=\"icon-dropdown fa fa-angle-down pull-right\"></i>");
                            else
                                $('#filter-rooms-contain').html("<b style='display: inline;margin-right: 10px; color: #0e2d3e;'><span class=\"fa fa-search\"></span> Tìm kiếm:</b><i>Nhập chuột vào để tìm kiếm....</i><i class=\"icon-dropdown fa fa-angle-down pull-right\"></i>");
                            $.each(data,function (key,item) {
                                if(item[0].trim().length!=0)
                                    $('#filter-rooms-contain').append('<div style=" display: inline-block;margin: 0px 1px; padding: 0px 7px;background-color: #1e91cf; color: #fff; border-radius: 30px; "><b>'+item[1]+' : </b>'+item[2]+'</div>');
                            });
                            params = data;
                        }
                        updateFilter(params_old);
                        $("#filter-rooms-contain").click(function () {
                            $(this).next('.dropdown-menu').toggle();
                        });
                        $("#cancel-filter").click(function () {
                            updateFilter(params_old);
                            $("#filter-rooms-contain").next('.dropdown-menu').hide();
                        });
                        $("#button-filter").click(function () {
                            $("#filter-rooms-contain").next('.dropdown-menu').hide();
                        });
                        $(".dropdown-menu select").change(function () {
                            eval('params.'+ $(this).attr('name') + "[0] = '"+ $(this).val()+"'");
                            eval('params.'+ $(this).attr('name') + "[2] = '"+ $(this).find('option:selected').text()+"'");
                            updateFilter(params);
                        });
                        $(".dropdown-menu input").keyup(function () {
                            eval('params.'+ $(this).attr('name') + "[0] = '"+ $(this).val()+"'");
                            eval('params.'+ $(this).attr('name') + "[2] = '"+ $(this).val()+"'");
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
            if(item[0].trim().length!=0) {
                parts.push(encodeURIComponent(key) + '=' + encodeURIComponent(item[0]));
                flag = true;
            }
        });
        if(flag)
            url += parts.join('&');

        //location = url;
    });
    //--></script>
<?php echo $footer; ?>