<?php
class ControllerPageDetail extends Controller {

    public function index($args) {
        if(!isset($args['id'])){
            $this->load->controller('error/not_found');
        }
         $this->load->model('page/detail');
         $this->load->model('page/owner/register');

        $filter_relative = array( 
            'status'=>1,
        );
        $detail = $this->model_page_detail->get_room($args['id']);

        if(!empty($detail['master_id']))
            $master = $this->model_page_detail->get_user_by_id($detail['master_id']);
        else
            $master['phone'] = 034534543535;
        if($detail){
            $data['detail'] = [];
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
                'regulation_room'  =>$detail['regulation_room'],
                'phone_master'=>$master['phone'],
            ];
            $data['has_point']= true;
            $data['point']= [
                'lat'=>(double) $detail['location']['coordinates'][1],
                'lng'=>(double) $detail['location']['coordinates'][0]
            ];
            $filter_relative['city_id'] = $detail['city_id'];
            $filter_relative['district_id'] = $detail['district_id'];
            $filter_relative['point'] = [$detail['location']['coordinates'][0],$detail['location']['coordinates'][1]];

            /* Get position near detail */
            $this->load->model('location/special');
            $data['specials'] = $this->model_location_special->get_list(['point'=>[$data['point']['lng'],$data['point']['lat']]]);

            /* get relative rooms */
            $this->load->model('find/list');
            $data['rooms'] = $this->model_page_detail->getRelative($filter_relative);
            $data['list_content'] = $this->load->view('default/template/part/content/list_content.tpl', $data);
        }else{
            $this->load->controller('error/not_found');
        }
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->response->setOutput($this->load->view('page/detail', $data));
    }
}