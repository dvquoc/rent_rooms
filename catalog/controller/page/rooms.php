<?php
 require_once( "vendor/recaptchalib.php" );
class ControllerPageRooms extends Controller
{
    private $error = array();

    public function __construct($registry)
    {
        parent::__construct($registry);
    }

    public function index()
    {
        $this->document->setTitle("Quản lý phòng");
        //$this->load->public_model('catalog/rooms');
       // $this->getList();
        $this->getForm();
    }

    public function add()
    {  
        $this->request->post['id_owner'] = $_SESSION['id_user']['id_owner'];
        $this->load->model('page/rooms');

        $secret = "6LfgN2EUAAAAAHIlpYTJjHz7zIvFMtR7WaAB_c_m";
        $response = null;

        $reCaptcha = new ReCaptcha($secret);
        // if submitted check response

        if ($_POST["g-recaptcha-response"]) {
            $response = $reCaptcha->verifyResponse(
                $_SERVER["REMOTE_ADDR"],
                $_POST["g-recaptcha-response"]
            );
        }
        if($response != null && $response->success) {
            if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
                if(isset($this->request->files)){
                   $this->request->post['img'] =  $this->uploadImg($this->request->files['files']);
                }
                $this->model_page_rooms->addRooms($this->request->post);

                $this->session->data['success'] = "Thêm thành công";

                $this->response->redirect('/quan-ly-phong-tro');
            }
        }else{
            $_SESSION['error_warning'] = 'check capcha';
        }
       
        $this->getForm();
    }

    public function edit()
    {  
        $room_id = ltrim(strstr($_GET['_route_'],'/'),'/');
        $this->load->model('page/rooms');
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $this->request->post['images'] = serialize($this->request->post['images']);
            if (empty($this->request->post['images']))
                $this->request->post['images'] = array();
            $this->model_page_rooms->editRooms($room_id, $this->request->post);

            $this->session->data['success'] = 'cập nhật thành công';

            $this->response->redirect('/quan-ly-phong-tro');
        }
        $this->getForm();
    }

    public function delete()
    {
        $this->load->model('page/rooms');
        if(count($_POST['selected']) > 0){
            $ids    = $_POST['selected'];
            $result = $this->model_page_rooms->deleteList($ids);
            if($result)
                $_SESSION['success']= 'xóa thành công';
        }else
            $_SESSION['error'] = 'chọn phòng cần xóa';
        exit();
    }

    public function getList()
    {   
        if(isset($_SESSION['id_user']['id_owner'])){
            $this->load->model('page/rooms');
            $id_owner = $_SESSION['id_user']['id_owner'];
            $data['error_warning'] = '';
            if (isset($_SESSION['error'])){
               $data['error_warning'] = $_SESSION['error'];
               unset($_SESSION['error']);
            }

            $data['success'] = '';
            if (isset($_SESSION['success'])) {
                $data['success'] = $_SESSION['success'];
                unset($_SESSION['success']);
            }



             $data['add'] = '/them-phong-tro';

            $data['rooms'] = array();
           // $rooms_total = $this->model_catalog_rooms->getTotalRooms($data_query);
            $results = $this->model_page_rooms->getRoomByOwner($id_owner);
            foreach ($results as $result) {
               
                $data['rooms'][] = array(
                    'room_id' => $result['room_id'],
                    'name' => $result['name'],
                    'address' => $result['address'],
                    'ads' => $result['ads'],
                    'from_date' => $result['from_date'],
                    'to_date' => $result['to_date'],
                    'date_update'=>(int)(string)$result['date_update'],
                    'text_price' => format_currency($result['price']),
                    'text_acreage' => format_acreage($result['acreage']),
                    'edit' =>'',
                    'is_checked'=>$result['is_checked'],
                );
               
            }
           
             $data['header'] = $this->load->controller('common/header');
            $this->response->setOutput($this->load->view('default/template/page/rooms_list.tpl', $data));
        }else{
             $this->response->redirect('/dang-nhap-chu-phong');
        }
       
    }

    protected function getForm()
    {
        if($_SESSION['id_user']['id_owner']){
            $this->load->model('page/rooms');
            $room_id = ltrim(strstr($_GET['_route_'],'/'),'/');
            $data['text_form'] = empty( $room_id) ? "Thêm phòng trọ" : "Chỉnh sửa phòng trọ";
            
            $data['error_warning'] = '';
            if (isset($_SESSION['error_warning'])){
                $data['error_warning'] = $_SESSION['error_warning'];
                unset($_SESSION['error_warning']);
            }

            $data['error_name'] = array();
            if (isset($this->error['error_name']))
                $data['error_name'] = $this->error['error_name'];

            if (empty($room_id)) {
                $data['action'] = '/luu-phong-tro';
            } else {
                $data['action'] = '/cap-nhat-phong-tro/'.$room_id;
            }

            $data['cancel'] = '/quan-ly-phong-tro';
            if (!empty($room_id)) {
                $array_fomat_txt = ['price', 'price_electricity', 'price_water', 'price_deposit'];
                $room_info = $this->model_page_rooms->getRoom($room_id);
                foreach ($room_info as $col => $vaule) {
                    $data[$col] = $vaule;
                    if (in_array($col, $array_fomat_txt))
                        $data['txt_' . $col] = format_currency($vaule);
                }
            }else{
                $array_fomat_txt = ['price', 'price_electricity', 'price_water', 'price_deposit'];
                foreach ($this->request->post as $col => $vaule) {
                    $data[$col] = $vaule;
                    if (in_array($col, $array_fomat_txt))
                        $data['txt_' . $col] = format_currency($vaule);
                }
            }

            $this->load->model('tool/image');
            $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

             // Images list thumb
            $room_images = json_decode($room_info['images']);
            if (isset($this->request->post['images']))
            $room_images = $this->request->post['images'];


            $data['room_images'] = array();
            foreach ($room_images as $room_image) {
                 $image = 'no_image.png';
                 if (is_file(DIR_IMAGE . $room_image))
                     $image = $room_image;
                 $data['room_images'][] = array(
                     'image' => $image,
                     'thumb' => $this->model_tool_image->resize($image, 100, 100),
                 );
            }

             $data['room_images_lagre'] = $room_images;

             

             $this->load->model('page/location');
             $data['citys'] = $this->model_page_location->getAllCity();
             $data['districts'] = $this->model_page_location->getDistrictByCity($data['city_id']);
            $data['header'] = $this->load->controller('common/header');
            $this->response->setOutput($this->load->view('default/template/page/rooms_form.tpl', $data));
        }else{
             $this->response->redirect('/dang-nhap-chu-phong');
        }   
        
    }
    public function getAddress(){
        $this->load->model('page/location');
        $city        = $this->model_page_location->get_city_by_name($_POST['city']);
        $id_district = '';
        if(isset($_POST['district'])){
            $district    = $this->model_page_location->get_district_by_name($_POST['district'],$city[0]['city_id']);
            $id_district = $district[0]['district_id'];
        }

        $id_city = $city[0]['city_id'];
        echo json_encode(array('district_id' => $id_district,'city_id' => $id_city));
       exit();
    }
    protected function validateForm()
    {
        if (!$this->user->hasPermission('modify', 'page/rooms')) {
            $this->error['warning'] = "Không có quyền chỉnh sửa";
        }

        if (empty($this->request->post['name']))
            $this->error['error_name'] = "Tiêu đề không được để trống";

        if (empty($this->request->post['address']))
            $this->error['address'] = "Địa chỉ không được để trống";

        if (empty($this->request->post['lat']))
            $this->error['lat'] = "Kinh độ không được để trống";

        if (empty($this->request->post['lng']))
            $this->error['lng'] = "Vĩ độ không được để trống";
        return !$this->error;
    }

    protected function validateDelete()
    {
        if (!$this->user->hasPermission('modify', 'catalog/information')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        foreach ($this->request->post['selected'] as $information_id) {
            if ($this->config->get('config_account_id') == $information_id) {
                $this->error['warning'] = $this->language->get('error_account');
            }

            if ($this->config->get('config_checkout_id') == $information_id) {
                $this->error['warning'] = $this->language->get('error_checkout');
            }

            if ($this->config->get('config_affiliate_id') == $information_id) {
                $this->error['warning'] = $this->language->get('error_affiliate');
            }

            if ($this->config->get('config_return_id') == $information_id) {
                $this->error['warning'] = $this->language->get('error_return');
            }
        }

        return !$this->error;
    }

    public function autocomplete()
    {
        $json = array();
        if (isset($this->request->get['filter_name'])) {
            $filter_data = array(
                'district' => $this->request->get['district_id'],
                'name' => $this->request->get['filter_name'],
                'start' => 0,
                'limit' => 20
            );
            $this->load->public_model('location/location_admin');
            $street = $this->model_location_location_admin->getStreetByDistrict($filter_data);
            $special = $this->model_location_location_admin->getSpecialByDistrict($filter_data);
            $results = array_merge($street, $special);
            foreach ($results as $result) {
                if ($result['street_id'])
                    $json[] = array(
                        'id' => $result['street_id'],
                        'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                        'type' => 'street'
                    );
                else
                    $json[] = array(
                        'id' => $result['special_id'],
                        'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                        'type' => 'special'
                    );
            }
        }

        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }

    public function getDistricts()
    {

        $city_id = ltrim(strstr($_GET['_route_'],'/'),'/');
        $json = array();
        if (isset($city_id)) {
            $this->load->model('page/location');
            $results = $this->model_page_location->getDistrictByCity($city_id);
            foreach ($results as $result) {
                $json[] = array(
                    'id' => $result['district_id'],
                    'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }
        $sort_order = array();
        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }
        array_multisort($sort_order, SORT_ASC, $json);
        $this->response->setOutput(json_encode($json));
    }

    public function getLocation()
    {
        $json = array();
        if (isset($this->request->get['district_id'])) {
            $this->load->public_model('location/location_admin');
            $json = $this->model_location_location_admin->getLocationDistrict($this->request->get['district_id']);
        }
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
    public function uploadImg($images){
        $arr = [];
        foreach ($images['name'] as $key =>$value) {
            $new_name = 'file_' .time().'_'. rand(0, 10000).rand(0, 9999).rand(0, 999999) . '.' . end(explode(".", $value));
            if (move_uploaded_file($images['tmp_name'][$key], 'image/catalog/' . $new_name)) {
                $arr[] = $new_name;
            }else{
               
            }
        }
        return $arr;
    }
}