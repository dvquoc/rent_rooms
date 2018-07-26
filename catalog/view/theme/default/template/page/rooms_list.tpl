
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
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2 pull-right text-right"><a href="<?php echo $add; ?>" class="btn btn-primary"><i class="fa fa-plus"></i> Tạo mới</a>
                    <button type="button" class="btn btn-danger" onclick="delete_item()"><i class="fa fa-trash-o"></i> Xóa</button>
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
                                <td class="text-center"> 
                                    <input type="checkbox" name="selected" value="<?php echo $room['room_id']; ?>" />
                                </td>
                                <td class="text-left">
                                    <div style="color: #333; font-weight: bold"> <?php echo $room['name']; ?></div>
                                    <div style="font-size: 12px; "><span>Địa chỉ:</span> <i><?php echo $room['address']; ?></i></div>
                                </td>
                                <td class="text-right"><?php echo $room['text_price']; ?></td>
                                <td class="text-right"><?php echo $room['text_acreage']; ?></td>
                                <td class="text-left"><span class="feature"> <?php echo $room['ads'] ? 'Tin quảng cáo': 'Tin bình thường'; ?></span></td>
                                <td class="text-left"><?php echo date('d/m/YY',$room['from_date']); ?></td>
                                <td class="text-left"><?php echo date('d/m/YY',$room['to_date']); ?></td>
                                <td class="text-right"><a href="/them-phong-tro/<?php echo $room['room_id'] ?>" data-toggle="tooltip" class="btn btn-primary"><i class="fa fa-pencil"></i></a></td>
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
                    <div class="col-sm-6 text-left"><?php echo $paginations['pagination']; ?></div>
                    <div class="col-sm-6 text-right"><?php echo $paginations['results']; ?></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var selected =[];
    var noneselected = [];
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
     $("input[name=selected]").change(function () {
        var id_room = $(this).val();
        if($(this).is(':checked')){
            var index = $.inArray(id_room,selected);
            if(index === -1){
                selected.push(id_room);
            }
        }else{
           var index = $.inArray(id_room,selected);
            if(index != -1){
                selected.splice(index,1);
            }
        }
     });
    function delete_item(){
        $.ajax({
            url:'/xoa-phong-tro',
            type:'POST',
            data:{
                selected:selected,
            },success:function(data){
                 slocation.reload();
            }
        })
    }
    </script>

    <script type="text/javascript">
        var params_old = <?php echo json_encode($data_filter); ?>;
        var params = params_old;
        var district_id = params_old.district_id;
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
            if($(this).attr('name') == 'district_id'){
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