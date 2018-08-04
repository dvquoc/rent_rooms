<?php
class ControllerCommonMenu extends Controller {
	public function index() {
		$this->load->language('common/menu');

        $data['text_dashboard'] = $this->language->get('text_dashboard');

        $data['text_rooms'] = $this->language->get('text_rooms');



		$data['text_setting'] = $this->language->get('text_setting');
		$data['text_system'] = $this->language->get('text_system');
        $data['text_banner'] = $this->language->get('text_banner');


		$data['text_user_group'] = $this->language->get('text_user_group');
		$data['text_users'] = $this->language->get('text_users');
        $data['text_user'] = $this->language->get('text_user');


        $data['home'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL');
        $data['rooms'] = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'], 'SSL');

        $data['district'] = $this->url->link('location/city', 'token=' . $this->session->data['token'], 'SSL');
        $data['street'] = $this->url->link('location/street', 'token=' . $this->session->data['token'], 'SSL');
        $data['special'] = $this->url->link('location/special', 'token=' . $this->session->data['token'], 'SSL');

		$data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
		$data['setting'] = $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL');
		$data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
		$data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');

		return $this->load->view('common/menu.tpl', $data);
	}
}