<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		$data['title']= "Trang header";

		$data['menu_map']= $this->url->link_seo('tim-kiem-theo-ban-do','SSL');
		$data['list']= $this->url->link_seo('tim-kiem-theo-list','SSL');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}

	}
}