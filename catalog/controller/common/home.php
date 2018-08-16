<?php
class ControllerCommonHome extends Controller {
    public function index() {
        $data['header'] = $this->load->controller('common/header_home');

        $this->load->public_model('location/location_admin');
        $data['citys'] = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data['citys'][0]->city_id);

        $this->load->model('location/special');
        $data['specials'] = $this->model_location_special->getSpecialByDistrict(24);

        $this->response->setOutput($this->load->view('common/home', $data));
    }
}