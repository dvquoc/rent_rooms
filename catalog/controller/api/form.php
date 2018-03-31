<?php
class ControllerApiForm extends Controller {
	public function index() {
        $this->load->model('xform/xform');
        $this->load->language('module/xform');
		// Delete old login so not to cause any issues if there is an error
		unset($this->session->data['api_id']);
		$json = array();
        $formId = isset($this->request->post['form_id']) ? $this->request->post['form_id'] : 0;
        if(($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $validate = $this->model_xform_xform->validateForm($formId, $this->request->post['data']);
            if (isset($this->request->post['form_id']) && $validate) {
                $formdata = array();
                $formdata['formId'] = $formId;
                $formdata['userIP'] = $_SERVER['REMOTE_ADDR'];
                $formdata['userAgent'] = $_SERVER['HTTP_USER_AGENT'];
                $formdata['submitDate'] = date('Y-m-d H:i:s');
                $formdata['userId'] = 0;
                $formdata['storeId'] = 0;

                $recordId = $this->model_xform_xform->addFormRecord($formdata);
                $this->model_xform_xform->processFormData($recordId, $this->request->post['data']);

                $this->model_xform_xform->processFormEmail($recordId);

                $formInfo = $this->model_xform_xform->getForm($formId);
                $json['error'] = false;
                $json['message'] = "Thành công !";
            } else {
                $json['error'] = true;
                $json['message'] = "Các trường có dấu * là bắt buộc";
                $json['detail_error'] = $validate;
            }
        }else{
            $json['error'] = true;
            $json['message'] = "Đã có lỗi sảy ra.";
        }
        echo json_encode($json);
        die();
	}
}