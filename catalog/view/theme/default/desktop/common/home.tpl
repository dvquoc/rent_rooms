<?php echo $header;?>
<div class="text-center">
        <div class="inner">
            <div id="logo" class="text-left">
                <h1><span style="color: #00BA51">Conphong.</span><span style="color: #FF9800">com</span></h1>
                <i>Gõ là có, tìm được ngay</i>
            </div>
            <div id="search-home">
            <ul class="clearfix">
                <li class="location-home" data-toggle="modal" data-target="#get-location-user">
                    <b class="city-location-show">Hồ Chí Minh </b>
                    <span class="district-location-show">Thủ Đức</span>
                    <svg class="down-location-user" aria-hidden="true" data-prefix="fal" data-icon="angle-down" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 512">
                        <path fill="currentColor" d="M119.5 326.9L3.5 209.1c-4.7-4.7-4.7-12.3 0-17l7.1-7.1c4.7-4.7 12.3-4.7 17 0L128 287.3l100.4-102.2c4.7-4.7 12.3-4.7 17 0l7.1 7.1c4.7 4.7 4.7 12.3 0 17L136.5 327c-4.7 4.6-12.3 4.6-17-.1z"></path>
                    </svg>
                </li>
                <li class="keyword before-background">
                    <input id="search-map-input" type="text" name="search-map-input" class="item-search form-control" placeholder="Nhập trường học, khu công nghiệp, công ty...">
                </li>
                <li class="price dropup">
                    <input id="price-input" type="text" class="form-control" placeholder="Giá" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <ul class="dropdown-menu list-val-search" data-to="price-input"  aria-labelledby="dropdownMenu2">
                        <li><a data-item-val ="0-1" href="javascript:;">< 1 triệu</a></li>
                        <li><a data-item-val ="1-1.5" href="javascript:;">1 triệu - 1.5 triệu</a></li>
                        <li><a data-item-val ="1.5-2" href="javascript:;">1.5 triệu - 2 triệu</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a data-item-val ="2-2.5" href="javascript:;">2 triệu - 2.5 triệu</a></li>
                        <li><a data-item-val ="2.5-3" href="javascript:;">2.5 triệu - 3 triệu</a></li>
                        <li><a data-item-val ="3.5-4" href="javascript:;">3.5 triệu - 4 triệu</a></li>
                        <li><a data-item-val ="4-4.5" href="javascript:;">4.5 triệu - 5 triệu</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a data-price-val ="5-20" href="javascript:;"> > 5 triệu</a></li>
                    </ul>
                </li>
                <li class="area dropup">
                    <input id="area-input" type="text" class="form-control" placeholder="Diện tích" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <ul class="dropdown-menu list-val-search" data-to="area-input" aria-labelledby="dropdownMenu2">
                        <li><a data-item-val ="0-10" href="javascript:;">< 10 m2</a></li>
                        <li><a data-item-val ="10-15" href="javascript:;">10 m2 - 15 m2</a></li>
                        <li><a data-item-val ="15-20" href="javascript:;">15 m2 - 20 m2</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a data-item-val ="20-25" href="javascript:;">20 m2 - 25 m2</a></li>
                        <li><a data-item-val ="25-30" href="javascript:;">25 m2 - 30 m2</a></li>
                        <li role="separator" class="divider"></li>
                        <li><a data-item-val ="1" href="javascript:;"> Nhà nguyên căn</a></li>
                    </ul>
                </li>
                <li class="btn-search">
                    <button class="before-background">Tìm kiếm</button>
                </li>
            </ul>
            <?php if(!empty($specials)){ ?>
            <div id="sugget-special">
                <div class="inner-sugget">
                    <ul class="clearfix">
                        <?php foreach($specials as $special){ ?>
                        <li>
                            <a href="/tim-kiem/phong-tro-gan-slug-slug/<?php echo $special['location']['coordinates'][1] ?>,<?php echo $special['location']['coordinates'][0] ?>" class="arena">
                                <?php echo $special['name'] ?>
                            </a>
                        </li>
                        <?php } ?>
                    </ul>
                </div>
            </div>
            <?php } ?>
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

