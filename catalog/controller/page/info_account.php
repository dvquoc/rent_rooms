<?php
class ControllerPageInfoAccount extends Controller {
	public function index() {
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/info_account.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/info_account.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/info_account.tpl', $data));
        }
    }
}