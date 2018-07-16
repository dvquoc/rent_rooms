<footer>
    <p class="text-center">Copyright @ Conphong.com</p>
</footer>
<div class="modal fade" id="get-location-user">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <button type="button" class="close" id="close-location-user" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <div class="modal-body" style="padding-bottom: 0px;">
                <div class="header-location-user">
                    <p style="margin: 0px; margin-left: 160px; padding:20px 10px; line-height: 30px;">Hãy cho chúng tôi biết bạn đang ở đâu, Việc này giúp bạn có được sự hỗ trợ tốt nhất</p>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <select name="city-location" id="city-location" class="form-control" style="border-radius: 3px; padding: 5px; border: 0px solid #e0e0e0; background-color:#f1f1f1; margin-bottom: 20px">
                            <?php foreach($citys as $item){ ?>
                            <option value="<?php echo $item->city_id ?>"><?php echo $item->name ?></option>
                            <?php } ?>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <select name="district-location" id="district-location" class="form-control" style="border-radius: 3px; padding: 5px; border: 0px solid #e0e0e0; background-color:#f1f1f1; margin-bottom: 20px">
                            <?php foreach($districts as $item){ ?>
                            <option value="<?php echo $item->district_id ?>"><?php echo $item->name ?></option>
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
</body>
</html>