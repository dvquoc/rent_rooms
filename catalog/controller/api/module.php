<?php
class ControllerApiModule extends Controller {
	public function index() {
		// Delete old login so not to cause any issues if there is an error
		unset($this->session->data['api_id']);
		$json = array();

		$this->load->model('api/module');

		$api_info = $this->model_api_module->getModuleActive();

		if ($api_info) {

			$json['success'] = "Thành công !";
			$json['data'] = $api_info;
		} else {
			$json['error'] = "Thất bại !";
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}