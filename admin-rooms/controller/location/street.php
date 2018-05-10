<?php
class ControllerLocationStreet extends Controller
{
    private $error = array();

    public function __construct($registry)
    {
        parent::__construct($registry);
    }

    public function index()
    {
        $page = $this->request->get['page'] ? $this->request->get['page'] : 1;
        $this->load->public_model('location/location_admin');

        $data['user'] = array();
        $data['user']['district'] = 1;
        $data['user']['city'] = 1;

        $data['city']= $this->request->get['city'] ? $this->request->get['city']: $data['user']['city'];
        $data['district']= $this->request->get['district'] ? $this->request->get['district']: $data['user']['district'];
        $data['location'] = $this->request->get['location'] ? $this->request->get['location']: 0;

        $data['citys'] = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data['city']);

        $data_filter = array(
            'district'=> $data['district'],
            'city'=> $data['city'],
            'location' => $data['location'],
            'start' => ($page - 1) * 12,
            'limit' => 100
        );

        $url = http_build_query($data_filter);
        $data["add"] = $this->url->link('location/street/add', $url, 'SSL');
        $data['action_fitler'] = str_replace('&amp;','&',$this->url->link('location/street', 'token=' . $this->session->data['token'], 'SSL'));

        $total_street = $this->model_location_location_admin->getStreetTotalByDistrict($data_filter);
        $results = $this->model_location_location_admin->getStreetByDistrict($data_filter);

        $data['list'] = array();
        foreach ($results as $item){
            $url_edit =$url.'&street_id='.$item['street_id'];
            $data['list'][] = array(
                'street_id' => $item['street_id'],
                'name'      => $item['name'],
                'location'  => $item['location'],
                'edit'      => $this->url->link('location/street/edit','token=' . $this->session->data['token']."&".$url_edit, 'SSL')
            );
        }

        $data['data_filter'] =  array(
            'city'=> $data['city'],
            'district'=> $data['district'],
            'location' =>$data['location']
        );

        $data['paginations'] = $this->load->controller('part/pagination', array('total'=>$total_street,'url' => $url));
        $data['token'] = $this->session->data['token'];
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('location/street_list.tpl', $data));
    }

    public function edit(){
        $this->load->public_model('location/location_admin');
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->model_location_location_admin->editStreet($this->request->get['room_id'], $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            $url = http_build_query(array_diff_key($this->request->get, ['route'=>'','room_id'=>'']));
            $this->response->redirect($this->url->link('catalog/rooms',$url, 'SSL'));
        }
        $this->getForm();
    }

    protected function getForm() {
        $address = array();
        if (isset($this->request->get['street_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $street_info = $this->model_location_location_admin->getStreetById($this->request->get['street_id']);
            $address['street'] = $street_info['name'];
        }

        $data['city_id']= $this->request->get['city'] ? $this->request->get['city']: 1;
        $data['district_id']= $this->request->get['district'] ? $this->request->get['district']: 1;

        $district_info = $this->model_location_location_admin->getOneById('district',$data['district_id']);
        $city_info = $this->model_location_location_admin->getOneById('city',$data['city_id']);

        $address['district'] = $district_info['name'];
        $address['city'] = $city_info['name'];

        $data['address'] = implode(', ',$address);
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');
        $this->response->setOutput($this->load->view('location/street_form.tpl', $data));
    }

    protected function validateForm() {

        if (!$this->user->hasPermission('modify', 'catalog/rooms')) {
            $this->error['warning'] = "Không có quyền chỉnh sửa";
        }

        if(empty($this->request->post['name']))
            $this->error['error_name'] = "Tiêu đề không được để trống";

        if(empty($this->request->post['address']))
            $this->error['address'] = "Địa chỉ không được để trống";

        if(empty($this->request->post['lat']))
            $this->error['lat'] = "Kinh độ không được để trống";

        if(empty($this->request->post['lng']))
            $this->error['lng'] = "Vĩ độ không được để trống";

        return !$this->error;
    }
}