<?php 
class ControllerPageLogin extends Controller {
    public function index() {
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/login.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/login.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/login.tpl', $data));
        }
    }
}