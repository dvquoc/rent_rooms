<?php
class ControllerCommonFooter extends Controller {
	public function index() {

        $this->load->public_model('location/location_admin');
        $data['citys'] = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data['citys'][0]->city_id);
		return $this->load->view('common/footer', $data);
	}
}