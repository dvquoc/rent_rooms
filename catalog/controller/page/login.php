<?php 
class ControllerPageLogin extends Controller {
    public function index() {
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('page/login', $data));
    }
}