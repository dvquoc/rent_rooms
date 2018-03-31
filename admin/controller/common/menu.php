<?php
class ControllerCommonMenu extends Controller {
	public function index() {
		$this->load->language('common/menu');
		$this->load->language('common/object');
		$data['text_backup'] = $this->language->get('text_backup');
		$data['text_banner'] = $this->language->get('text_banner');
		$data['text_catalog'] = $this->language->get('text_catalog');
		$data['text_category'] = $this->language->get('text_category');

		$data['text_contact'] = $this->language->get('text_contact');


		$data['text_design'] = $this->language->get('text_design');

		$data['text_error_log'] = $this->language->get('text_error_log');
		$data['text_extension'] = $this->language->get('text_extension');
		$data['text_feed'] = $this->language->get('text_feed');
		$data['text_fraud'] = $this->language->get('text_fraud');

		$data['text_dashboard'] = $this->language->get('text_dashboard');
		$data['text_help'] = $this->language->get('text_help');
		$data['text_installer'] = $this->language->get('text_installer');
		$data['text_language'] = $this->language->get('text_language');
		$data['text_layout'] = $this->language->get('text_layout');
		$data['text_localisation'] = $this->language->get('text_localisation');
		$data['text_location'] = $this->language->get('text_location');
		$data['text_marketing'] = $this->language->get('text_marketing');
		$data['text_modification'] = $this->language->get('text_modification');
		$data['text_module'] = $this->language->get('text_module');
		$data['text_payment'] = $this->language->get('text_payment');


		$data['text_review'] = $this->language->get('text_review');

		$data['text_setting'] = $this->language->get('text_setting');

		$data['text_system'] = $this->language->get('text_system');

		$data['text_tools'] = $this->language->get('text_tools');
		$data['text_upload'] = $this->language->get('text_upload');

		$data['text_user'] = $this->language->get('text_user');
		$data['text_user_group'] = $this->language->get('text_user_group');
		$data['text_users'] = $this->language->get('text_users');

        $data['home'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL');
		$data['backup'] = $this->url->link('tool/backup', 'token=' . $this->session->data['token'], 'SSL');
		$data['banner'] = $this->url->link('design/banner', 'token=' . $this->session->data['token'], 'SSL');
		$data['category'] = $this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL');

		$data['contact'] = $this->url->link('marketing/contact', 'token=' . $this->session->data['token'], 'SSL');

		$data['feed'] = $this->url->link('extension/feed', 'token=' . $this->session->data['token'], 'SSL');

		$data['fraud'] = $this->url->link('extension/fraud', 'token=' . $this->session->data['token'], 'SSL');

		$data['installer'] = $this->url->link('extension/installer', 'token=' . $this->session->data['token'], 'SSL');
		$data['language'] = $this->url->link('localisation/language', 'token=' . $this->session->data['token'], 'SSL');
		$data['layout'] = $this->url->link('design/layout', 'token=' . $this->session->data['token'], 'SSL');
		$data['location'] = $this->url->link('localisation/location', 'token=' . $this->session->data['token'], 'SSL');
		$data['modification'] = $this->url->link('extension/modification', 'token=' . $this->session->data['token'], 'SSL');


		$data['module'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$data['review'] = $this->url->link('catalog/review', 'token=' . $this->session->data['token'], 'SSL');
		$data['return'] = $this->url->link('sale/return', 'token=' . $this->session->data['token'], 'SSL');
		$data['return_action'] = $this->url->link('localisation/return_action', 'token=' . $this->session->data['token'], 'SSL');
		$data['return_reason'] = $this->url->link('localisation/return_reason', 'token=' . $this->session->data['token'], 'SSL');
		$data['return_status'] = $this->url->link('localisation/return_status', 'token=' . $this->session->data['token'], 'SSL');
		$data['shipping'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
		$data['setting'] = $this->url->link('setting/setting', 'token=' . $this->session->data['token'], 'SSL');
		$data['total'] = $this->url->link('extension/total', 'token=' . $this->session->data['token'], 'SSL');
		$data['upload'] = $this->url->link('tool/upload', 'token=' . $this->session->data['token'], 'SSL');
		$data['user'] = $this->url->link('user/user', 'token=' . $this->session->data['token'], 'SSL');
		$data['user_group'] = $this->url->link('user/user_permission', 'token=' . $this->session->data['token'], 'SSL');

		// Get menu langue cho default object;

		foreach($this->objects->dataObject() as $key=>$object){
			$alias_name=$key;

			if (!empty($object['alias_name']))
				$alias_name = $object['alias_name'];

			if($alias_name!="default") {
				$data['objects'][$key]['item_menu_name_group'] = $this->language->get('text_' . $alias_name . '_group');
				$data['objects'][$key]['item_menu'][] = array(
						$this->url->link('catalog/information/add', 'token=' . $this->session->data['token'] . '&object_type=' . $alias_name, 'SSL'),
						$this->language->get('text_' . $alias_name . "_new")
				);
				$data['objects'][$key]['item_menu'][] = array(
						$this->url->link('catalog/information', 'token=' . $this->session->data['token'] . '&object_type=' . $alias_name, 'SSL'),
						$this->language->get('text_' . $alias_name . "_list")
				);
				if (isset($object['have_category']) && $object['have_category'])
					$data['objects'][$key]['item_menu'][] = array(
							$this->url->link('catalog/category', 'token=' . $this->session->data['token'] . '&object_type=' . $alias_name, 'SSL'),
							$this->language->get('text_' . $alias_name . '_category')
					);
				if (isset($object['have_tag']) && $object['have_tag'])
					$data['objects'][$key]['item_menu'][] = array(
							$this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . '&object_type=' . $alias_name, 'SSL'),
							$this->language->get('text_' . $alias_name . '_tag')
					);
				if (!empty($object['page_setting']))
					$data['objects'][$key]['item_menu'][] = array(
							$this->url->link('setting_object/' . $alias_name, 'token=' . $this->session->data['token'] . '&object_type=' . $alias_name, 'SSL'),
							$this->language->get('text_' . $alias_name . '_setting')
					);
			}else{ // Dành cho quản lý mẫu
				$data['objects'][$key]['item_menu_name_group'] = $this->language->get('text_' . $alias_name . '_group');
				$data['objects'][$key]['item_menu'][] = array(
						$this->url->link('catalog/product/add', 'token=' . $this->session->data['token'], 'SSL'),
						$this->language->get('text_' . $alias_name . "_new")
				);
				$data['objects'][$key]['item_menu'][] = array(
						$this->url->link('catalog/product', 'token=' . $this->session->data['token'], 'SSL'),
						$this->language->get('text_' . $alias_name . "_list")
				);
				if (isset($object['have_category']) && $object['have_category'])
					$data['objects'][$key]['item_menu'][] = array(
							$this->url->link('catalog/category', 'token=' . $this->session->data['token'], 'SSL'),
							$this->language->get('text_' . $alias_name . '_category')
					);
				if (isset($object['have_tag']) && $object['have_tag'])
					$data['objects'][$key]['item_menu'][] = array(
							$this->url->link('catalog/tag', 'token=' . $this->session->data['token'], 'SSL'),
							$this->language->get('text_' . $alias_name . '_tag')
					);
				if (!empty($object['page_setting']))
					$data['objects'][$key]['item_menu'][] = array(
							$this->url->link('setting_oject/' . $alias_name, 'token=' . $this->session->data['token'] . '&object_type=' . $alias_name, 'SSL'),
							$this->language->get('text_' . $alias_name . '_setting')
					);
			}

		}
		return $this->load->view('common/menu.tpl', $data);
	}
}