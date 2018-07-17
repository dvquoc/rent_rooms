<?php
class ControllerCommonHome extends Controller {
    public function index() {
        $data['header'] = $this->load->controller('common/header_home');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/home.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/home.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/common/home.tpl', $data));
        }
    }
}