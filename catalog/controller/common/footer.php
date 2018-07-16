<?php
class ControllerCommonFooter extends Controller {
	public function index() {

        $this->load->public_model('location/location_admin');
        $data['citys'] = $this->model_location_location_admin->getAllCity();
        $data['districts'] = $this->model_location_location_admin->getDistrictByCity($data['citys'][0]->city_id);

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/footer.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/footer.tpl', $data);
		} else {
			return $this->load->view('default/template/common/footer.tpl', $data);
		}
	}
}