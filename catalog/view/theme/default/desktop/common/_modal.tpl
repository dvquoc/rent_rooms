<div class="modal fade" id="edit-module" tabindex="-1" role="dialog" aria-labelledby="edit-module" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h3 class="modal-title" id="myModalLabel">Title module</h3>
            </div>
            <div class="modal-body">
                {{ flashSession.output() }}
            </div>
            <div class="modal-footer">
                <button type="button" id="save-module" class="btn btn-feature">Cập nhật</button>
            </div>
        </div>
    </div>
</div>

<div id="warning" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
                <h3>Bạn có muốn xóa ?</h3>
                <p>Dữ liệu trong bố cục sẽ bị mất</p>
                <div class="text-right">
                    <button type="button" class="btn btn-danger confirm" data-dismiss="modal">Xóa</button>
                    <button type="button" class="btn btn-primary cancel" data-dismiss="modal"><i class="material-icons">keyboard_arrow_left</i> Quay lại</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="error-modal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
                <h3>Đã có lỗi sảy ra</h3>
                <p class="message">Dữ liệu trong bố cục sẽ bị mất</p>
                <div class="text-right">
                    <button type="button" class="btn btn-primary cancel" data-dismiss="modal"> Đóng</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="success-modal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
                <h3>Thành công</h3>
                <p class="message">Thao tác thành công</p>
                <div class="text-right">
                    <button type="button" class="btn btn-primary cancel" data-dismiss="modal"> Đóng</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="register_quickly" style="width: 100%" class="modal fade" tabindex="-1">
    <div class="modal-dialog modal-lg" style="width: 100%; margin: 0px;">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title text-center">Đăng ký tài khoản & Tạo một website dùng thử</h2>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span> Đóng
                </button>
            </div>
            <div class="modal-body" style="padding: 0px">
                <div class="content-edit">
                    <iframe src="javascript:;"  style="width:100%; border:0px; min-height: 550px" id="modalFrame"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>