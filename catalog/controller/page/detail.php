<?php
class ControllerPageDetail extends Controller {
    public function index() {
        
         $this->load->model('page/detail');
         $this->load->model('find/list');

        // $data_search = array(
        //     'status'=>1
        // );
        $data['rooms'] = $this->model_page_detail->get_list();
        $data['detail'] = $this->model_page_detail->get_room('5afd77fbe1382306d1286232');
       
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/detail.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/detail.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/detail.tpl', $data));
        }
    }
}