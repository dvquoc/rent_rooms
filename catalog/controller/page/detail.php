<?php
class ControllerPageDetail extends Controller {

    public function index($args) {
        if(!isset($args['id'])){
            $this->load->controller('error/not_found');
        }
         $this->load->model('page/detail');
         $this->load->model('find/list');

        // $data_search = array(
        //     'status'=>1
        // );
        $data['rooms'] = $this->model_page_detail->get_list();
        $detail = $this->model_page_detail->get_room($args['id']);
        $data['detail'] = [];
        if($detail){
            $data['detail'] =[
                'name'     =>$detail['name'],
                'images'   =>json_decode($detail['images'],true),
                'address'  =>$detail['address'],
                'location' =>$detail['location']['coordinates'],
                'ads'      =>$detail['ads'],
                'price'    =>$detail['price'],
                'price_electricity'   =>($detail['price_electricity']/1000).' ngàn/Kg',
                'price_water'   =>($detail['price_water']/1000).' ngàn/Khối',
                'price_deposit'   =>($detail['price_deposit']/1000000),
                'acreage'  =>$detail['acreage'],
                'amount_people'  =>$detail['amount_people'],
                'close_door'  =>$detail['close_door'],
                'highlight'  =>$detail['highlight'],
                'regulation_room'  =>$detail['regulation_room']
            ];
        }else{
            $this->load->controller('error/not_found');
        }
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/detail.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/detail.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/detail.tpl', $data));
        }
    }
}