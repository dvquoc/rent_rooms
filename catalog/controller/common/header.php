<?php
class ControllerCommonHeader extends Controller {
    private $data  = [];
	public function index() {
        $this->data['title'] = $this->document->getTitle();
        $this->data['base'] = "url page";
        $this->data['description'] = $this->document->getDescription();
        $this->data['keywords'] = $this->document->getKeywords();
        $this->data['links'] = $this->document->getLinks();
        $this->data['styles'] = $this->document->getStyles();
        $this->data['scripts'] = $this->document->getScripts();

        $this->data['menu_map']= $this->url->link_seo('tim-kiem-theo-ban-do','SSL');
        $this->data['list']= $this->url->link_seo('tim-kiem-theo-list','SSL');

        $this->load->public_model('location/location_admin');
        $this->data['citys'] = $this->model_location_location_admin->getAllCity();
        $this->data['districts'] = $this->model_location_location_admin->getDistrictByCity($this->data['citys'][0]->city_id);
        $this->data['classPage'] = '';
		if(isset($this->request->get['route']))
            $this->data['classPage'] = str_replace('/','-', $this->request->get['route']);
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $this->data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $this->data);
		}
	}
    public function get_client_ip() {
        $ipaddress = '';
        if (isset($_SERVER['HTTP_CLIENT_IP']))
            $ipaddress = $_SERVER['HTTP_CLIENT_IP'];
        else if(isset($_SERVER['HTTP_X_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_X_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_X_FORWARDED'];
        else if(isset($_SERVER['HTTP_FORWARDED_FOR']))
            $ipaddress = $_SERVER['HTTP_FORWARDED_FOR'];
        else if(isset($_SERVER['HTTP_FORWARDED']))
            $ipaddress = $_SERVER['HTTP_FORWARDED'];
        else if(isset($_SERVER['REMOTE_ADDR']))
            $ipaddress = $_SERVER['REMOTE_ADDR'];
        else
            $ipaddress = 'UNKNOWN';
        return $ipaddress;
    }
}