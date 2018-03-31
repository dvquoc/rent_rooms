<?php
class ControllerPartUsefree extends Controller {
    public function index() {
        /* Nếu có nghiêp vụ thì làm tại đây*/
        $data=array();
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/use_free.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/part/use_free.tpl', $data);
        } else {
            return $this->load->view('default/template/part/use_free.tpl', $data);
        }
    }
}