<?php 
class ControllerLocationCity extends Controller
{
	public function __construct($registry)
    {
        parent::__construct($registry);

    }
    public function index(){
    	$this->load->public_model('location/location_admin');
    	$citys    = $this->model_location_location_admin->getAllCity();
    	foreach ($citys  as $key => $value) {
        	$data['citys'][] = array(
				'name'             => $value['name'],
				'city_id'          =>$value['city_id'],
				'code'             =>$value['code'],
				'lat'              =>$value['lat'],
				'lng'              =>$value['lng'],
				'districts'        => $this->model_location_location_admin->getDistrictByCity($value['city_id']),
				'location'         =>$value['location'],
				'description'      =>$value['description'],
				'meta_title'       =>$value['meta_title'],
				'meta_description' =>$value['meta_description'],
				'meta_keyword'     =>$value['meta_keyword']
        	);
    	}
    	$data['header']      = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer']      = $this->load->controller('common/footer');
        $data['token']       = $this->session->data['token'];
    	$this->response->setOutput($this->load->view('location/city.tpl', $data));
    }
    public function getCity(){
    	$id_city = $this->request->post['id'];
    	$this->load->public_model('location/location_admin');
    	$city = $this->model_location_location_admin->getCityById($id_city);
    	$this->response->setOutput(json_encode($city));
    }
    public function getDistrict(){
    	$id_district = $this->request->post['id'];
    	$this->load->public_model('location/location_admin');
    	$district = $this->model_location_location_admin->getDistrictById($id_district);
    	$this->response->setOutput(json_encode($district));
    }
    public function edit(){
    	$this->load->model('location/city');
    	$lc = explode(",",$this->request->post['location']);
    	$point = array(
            'type' =>'Point',
            'coordinates'=>[(double) $lc[0],(double) $lc[1]]
        );
        $polygon = array(
            'type' =>'Polygon',
            'coordinates'=>json_decode(htmlspecialchars_decode($this->request->post['area'])),
        );

        $data = array(
        	'name' => $this->request->post['name'],
        	'code'=>$this->request->post['code'],
        	'location'=>$point,
        	'polygon' =>$polygon,
        	'description' => $this->request->post['description'],
        	'meta_title'=>$this->request->post['meta_title'],
        	'meta_description'=>$this->request->post['meta_description'],
        	'meta_keyword'=>$this->request->post['meta_keyword']
        );
        if(isset($this->request->post['city']))
        	$this->model_location_city->updateCity($this->request->post['city_id'],$data);
        else
        	$this->model_location_city->updateDistrict($this->request->post['district_id'],$data);
        $this->index();
    }
}