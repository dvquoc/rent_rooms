<?php echo $header;?>
<div class="text-center">
        <div class="inner-left" style="padding: 40px 0">
            <div id="logo" class="text-center">
                <h1>Piapy</h1>
                <span>conphong.com</span>
            </div>
            <div class="location-home">
                <div style="display: inline-block; cursor: pointer" data-toggle="modal" data-target="#get-location-user">
                    <i class="fa fa-street-view"></i>
                    <b class="city-location-show">Hồ Chí Minh </b> /
                    <span class="district-location-show">Thủ Đức</span>
                </div>
            </div>
            <ul id="search-home">
                <li>
                    <i class="fa fa-map-marker"></i>
                    <input id="search-map-input" type="text" class="item-search form-control" placeholder="Nhập trường học, khu công nghiệp, công ty..." style="width: 440px;" >
                </li>
                <li>
                    <i class="fa fa-dollar"></i>
                    <input id="price-input" type="text" class="item-search form-control" placeholder="Giá" style="width:80px;" >
                </li>
                <li>
                    <i class="fa fa-building"></i>
                    <input id="area-input" type="text" class="item-search form-control" placeholder="Diện tích" style="width:80px;" >
                </li>
                <li>
                    <button id="btn-s-h" style="background-color: #f47f28; border-color: #f47f28"><i class="fa fa-search"></i> Tìm kiếm</button>
                </li>
            </ul>
            <div id="sugget-special">
                <div class="inner-sugget">
                    <ul>
                        <li><a href="javascript;;">Trường Cao Đẳng Công Nghệ Thủ Đức</a> </li>
                        <li><a href="javascript;;">Trường Cao Đẳng Công Thương</a> </li>
                        <li><a href="javascript;;">Khu Công Nghệ Cao</a> </li>
                        <li><a href="javascript;;">Khu Chế Xuất Linh Trung</a> </li>
                        <li><a href="javascript;;">Trường Đại Học Nông Lâm</a> </li>
                    </ul>
                </div>
            </div>
            <div id="other-service">
                <h2 class="title-other-service">Các dịch vụ khác</h2>
                <p>Trải nghiệm với các dịch vụ tuyệt với của chúng tôi</p>
                <div class="row btn-sevice-home">
                    <a href="javascript:;" class="btn-home-sevice pull-left">
                        <i class="fa fa-globe"></i>
                        Thiết ke web
                    </a>
                    <a href="javascript:;" class="btn-home-sevice pull-left">
                        <i class="fa fa-truck"></i>
                        Labala
                    </a>
                    <a href="javascript:;" class="btn-home-sevice pull-left">
                        <i class="fa fa-building"></i>
                        Dụng cụ phòng trọ
                    </a>
                </div>
            </div>
            <p class="text-center">copyright @ conphong.com</p>
        </div>
</div>

<div class="modal fade" id="get-location-user">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="width: 500px">
            <button type="button" class="close" id="close-location-user" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <div class="modal-body" style="padding-bottom: 0px;">
                <div class="header-location-user">
                    <p style="margin: 0px; margin-left: 160px; padding:20px 10px; line-height: 30px;">Hãy cho chúng tôi biết bạn đang ở đâu, Việc này giúp bạn có được sự hỗ trợ tốt nhất</p>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <select name="city-location" id="city-location" class="form-control" style="border-radius: 3px; padding: 5px; border: 0px solid #e0e0e0; background-color:#f1f1f1; margin-bottom: 20px">
                            <?php foreach($citys as $item){ ?>
                            <option data-slug="<?php echo $item['slug_city'] ?>" value="<?php echo $item->city_id ?>"><?php echo $item->name ?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <select name="district-location" id="district-location" class="form-control" style="border-radius: 3px; padding: 5px; border: 0px solid #e0e0e0; background-color:#f1f1f1; margin-bottom: 20px">
                            <?php foreach($districts as $item){ ?>
                            <option data-slug="<?php echo $item['slug_district'] ?>" value="<?php echo $item->district_id ?>"><?php echo $item->name ?></option>
                            <?php } ?>
                        </select>
                    </div>
                </div>
                <div id="not-memory">
                    <label class="container-checkbox">
                        <span class="text-checkbox">Tôi không muốn thấy tin nhắn này lần tiếp theo</span>
                        <input type="checkbox" checked="checked">
                        <span class="checkmark"></span>
                    </label>
                </div>
            </div>
            <div class="modal-footer" style="border-top: 0px;">
                <div class="row">
                    <div class="col-md-6">
                        <button type="button" style="width: 100%" class="btn btn-danger" data-dismiss="modal">Bỏ qua</button>
                    </div>
                    <div class="col-md-6">
                        <button type="button" style="width: 100%" id="set-location-user" class="btn btn-primary">Hoàn thành</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

