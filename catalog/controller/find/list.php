<?php
class ControllerFindList extends Controller {
    public function index() {
        
         $this->load->model('find/list');
        // $data_search = array(
        //     'status'=>1
        // );

        $data['rooms'] = $this->model_find_list->get_list();
        
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/find/list.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/find/list.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/find/list.tpl', $data));
        }
    }
}