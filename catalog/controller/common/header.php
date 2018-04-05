<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		$data['title']= "Trang header";

		$data['menu_map']= $this->url->link('tim-kiem-theo-ban-do','','SSL');
		$data['test']= $this->url->link('test/30','','SSL'); 

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}

	}
}