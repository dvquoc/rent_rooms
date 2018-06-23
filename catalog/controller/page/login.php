<?php
class ControllerPageLogin extends Controller {
    public function index() {
        // $this->load->model('page/detail');
        // $data_search = array(
        //     'status'=>1
        // );
         $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/login.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/login.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/login.tpl', $data));
        }
    }
}