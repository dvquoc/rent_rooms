<?php
class ControllerLocationSpecial extends Controller
{
    private $error = array();
 
    public function __construct($registry)
    {
        parent::__construct($registry);
    }
    public function index(){
        $data['error_warning'] = '';
        $this->load->public_model('location/location_admin');

        if (isset($this->session->data['error'])){
            $data['error_warning'] = $this->session->data['error'];
            unset($this->session->data['error']);

        }

        $data['success'] = '';
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        $this->load->model('location/special');

        $data['list_area'] = array();

        $data_filter = [
            'city_id'     => isset($this->request->get['city_id']) ? $this->request->get['city_id'] : '1',
            'district_id' => isset($this->request->get['district_id']) ? $this->request->get['district_id'] : '1',
        ];

        $data_query = [
            'sort'  => 'name',
            'order' => 'ASC',
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        ];

        $data_query = array_merge($data_query, $data_filter);
        $url = http_build_query(array_diff_key($this->request->get, ['route' => '', 'id_area' => '']));
   
        $result = $this->model_location_special->get_list($data_filter);

        foreach ($result as $value) {
        
            $city = $this->model_location_location_admin->getCityById($value['city_id']);
            $district = $this->model_location_location_admin->getDistrictById($value['district_id']);
            $id = (string)$value['_id'];
            $data['list_area'][] = array(
                'id_area'  => $id,
                'name'     =>$value['name'],
                'district' =>$district[0]['name'],
                'city'     =>$city[0]['name'],
                'view'     =>$value['view'],
                'area'     =>!empty($value['area'])?count($value['area']):'',
                'lat'      =>$value['lat'],
                'lng'      =>$value['lng'],
                'address'  =>$value['adrress'],
                'edit'     =>$this->url->link('location/special/page_edit', '&id_area=' . $id .'&token=' . $this->session->data['token']."&". $url, 'SSL')
            );

        }

        $data['citys']     = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data_filter['city_id'].'');
        
        $data['data_filter'] = $data_filter;
        $total_special       = count($result);
        $data['paginations'] = $this->load->controller('part/pagination', array('total'=>$total_special,'url' => $url));
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        $data['token']       = $this->session->data['token'];
        $data["add"]         = $this->url->link('location/special/page_add_new', 'token=' . $this->session->data['token']."&".$url , 'SSL');
        $data['action_fitler'] = str_replace('&amp;', '&', $this->url->link('location/special', 'token=' . $this->session->data['token'], 'SSL'));
        $this->response->setOutput($this->load->view('location/special_list.tpl', $data));
    }
    public function page_add_new(){
        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        $data["save"]        = $this->url->link('location/special/save_special', 'token=' . $this->session->data['token']."&".$url , 'SSL');
        
        
        $this->load->public_model('location/location_admin');
        $data['token']     = $this->session->data['token'];
        $data['citys']     = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity('1');

        $this->response->setOutput($this->load->view('location/special_form.tpl', $data));  
       
    }
    public function save_special(){
        $this->load->model('location/special');
        if(!empty($_POST['circle'])){
            $str_area = explode('),(',trim($_POST['circle'],'()'));
            foreach ($str_area as $value) {
                $temp = explode(', ',$value);
                $coordinates =[];
                foreach ($temp as  $value1) {
                    $coordinates[] = floatval($value1);
                }
               $float_area[] = $coordinates;
            } 
        }else{
           $float_area =''; 
        }
    
        $data = [
            'name'        => $_POST['name'],
            'district_id' =>$_POST['district'],
            'city_id'     =>$_POST['city'],
            'view'        => intval($_POST['view']),
            'area'        =>$float_area,
            'lat'         =>floatval($_POST['lat']),
            'lng'         =>floatval($_POST['lng']),
            'adrress'     =>$_POST['address'],
        ];
        if(!empty($_POST['id'])){
            $result = $this->model_location_special->update($_POST['id'],$data);
            $this->session->data['success'] = $this->language->get('text_success');
        }
        else{
            $id_insert = $this->model_location_special->add($data);
            $this->session->data['success'] = $this->language->get('text_success');
        }

       $this->response->redirect($this->url->link('location/special', 'token=' . $this->session->data['token']."&".$url , 'SSL'));
       
    }

    public function page_edit(){
        $this->load->model('location/special');

        $this->load->public_model('location/location_admin');
        $data['token']     = $this->session->data['token'];
        

        $data['special']     = $this->model_location_special->get_special($this->request->get['id_area']);
        $data['city']     = $this->model_location_location_admin->getCityById($data['special']['city_id']);
        $data['district'] = $this->model_location_location_admin->getDistrictById($data['special']['district_id']);

        $data['citys']     = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data['special']['city_id']);

        $data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        $data["save"]        = $this->url->link('location/special/save_special', 'token=' . $this->session->data['token']."&".$url , 'SSL');
        $this->response->setOutput($this->load->view('location/special_form.tpl', $data)); 

    }


    public function delete(){
        $this->load->model('location/special');
        if(count($_POST) != 0){
            $ids    = $_POST['selected'];
            $result = $this->model_location_special->delete_list($ids);
            if($result)
                echo 'success';
        }else{
                $this->session->data['error']= $this->language->get('select item');
        }
       exit();
    }

    public function get_location(){
        $this->load->model('location/special');

        $this->load->public_model('location/location_admin');
        $city        = $this->model_location_location_admin->get_city_by_name($_POST['city']);
        $id_district = '';
        if(isset($_POST['district'])){
            $district    = $this->model_location_location_admin->get_district_by_name($_POST['district'],$city[0]['city_id']);
            $id_district = $district[0]['district_id'];
        }

        $id_city = $city[0]['city_id'];
        echo json_encode(array('district_id' => $id_district,'city_id' => $id_city));
       exit();
    }
 
    // public function index()
    // {

    //     $page = $this->request->get['page'] ? $this->request->get['page'] : 1;
    //     $this->load->public_model('location/location_admin');
        

    //     $data['user'] = array();
    //     $data['user']['district'] = 1;
    //     $data['user']['city'] = 1;

    //     $data['city']= $this->request->get['city'] ? $this->request->get['city']: $data['user']['city'];
    //     $data['district']= $this->request->get['district'] ? $this->request->get['district']: $data['user']['district'];
    //     $data['location'] = $this->request->get['location'] ? $this->request->get['location']: 0;

    //     $data['citys'] = $this->model_location_location_admin->getAllCity();
    //     $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data['city']);
        
    //     $data_filter = array(
    //         'district'=> $data['district'],
    //         'city'=> $data['city'],
    //         'location' => $data['location'],
    //         'start' => ($page - 1) * 12,
    //         'limit' => 100
    //     );

    //     $url = http_build_query($data_filter);

    //     $data["add"] = $this->url->link('location/special/edit', 'token=' . $this->session->data['token']."&".$url , 'SSL');
    //     $data['action_fitler'] = str_replace('&amp;','&',$this->url->link('location/special', 'token=' . $this->session->data['token'], 'SSL'));
        
    //     $total_special = $this->model_location_location_admin->getSpecialTotalByDistrict($data_filter);
    //     $results = $this->model_location_location_admin->getSpecialByDistrict($data_filter);
        
    //     $data['list'] = array();
    //     foreach ($results as $item){
    //         $url_edit =$url.'&special_id='.$item['special_id'];
    //         $data['list'][] = array(
    //             'special_id' => $item['special_id'],
    //             'name'      => $item['name'],
    //             'location'  => $item['location'],
    //             'edit'      => $this->url->link('location/special/edit','token=' . $this->session->data['token']."&".$url_edit, 'SSL')
    //         );
    //     }

    //     $data['data_filter'] =  array(
    //         'city'=> $data['city'],
    //         'district'=> $data['district'],
    //         'location' =>$data['location']
    //     );
        
    //     $data['paginations'] = $this->load->controller('part/pagination', array('total'=>$total_special,'url' => $url));
    //     $data['token'] = $this->session->data['token'];
    //     $data['header'] = $this->load->controller('common/header');
    //     $data['column_left'] = $this->load->controller('common/column_left');
    //     $data['footer'] = $this->load->controller('common/footer');
    //     $this->response->setOutput($this->load->view('location/special_list.tpl', $data));
    // }

    // public function edit(){
    //     $this->load->public_model('location/location_admin');
    //     if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
    //         if(!empty($this->request->get['room_id'])) {
    //             $this->model_location_location_admin->editSpecial($this->request->get['room_id'], $this->request->post);
    //             $this->session->data['success'] = $this->language->get('text_success');
    //         }else{
    //             $this->model_location_location_admin->addSpecial($this->request->get['room_id'], $this->request->post);
    //             $this->session->data['success'] = $this->language->get('text_success');
    //         }
    //         $url = http_build_query(array_diff_key($this->request->get, ['route' => '', 'room_id' => '']));
    //         $this->response->redirect($this->url->link('catalog/rooms', $url, 'SSL'));
    //     }
    //     $this->getForm();
    // }

    // protected function getForm() {
    //     $address = array();
    //     if (isset($this->request->get['special_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
    //         $special_info = $this->model_location_location_admin->getSpecialById($this->request->get['special_id']);
    //         $address['special'] = $special_info['name'];
    //     }

    //     $data['city_id']= $this->request->get['city'] ? $this->request->get['city']: 1;
    //     $data['district_id']= $this->request->get['district'] ? $this->request->get['district']: 1;

    //     $district_info = $this->model_location_location_admin->getOneById('district',$data['district_id']);
    //     $city_info = $this->model_location_location_admin->getOneById('city',$data['city_id']);

    //     $address['district'] = $district_info['name'];
    //     $address['city'] = $city_info['name'];

    //     $data['address'] = implode(', ',$address);
    //     $data['header'] = $this->load->controller('common/header');
    //     $data['column_left'] = $this->load->controller('common/column_left');
    //     $data['footer'] = $this->load->controller('common/footer');
    //     $this->response->setOutput($this->load->view('location/special_form.tpl', $data));
    // }

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