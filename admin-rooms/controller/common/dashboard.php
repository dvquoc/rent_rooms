<?php
class ControllerCommonDashboard extends Controller {
	public function index() {
		$this->document->setTitle('Trang Dashboard');
		$data['heading_title'] = 'Trang Dashboard';
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => "Dashboard",
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		// Check install directory exists
		if (is_dir(dirname(DIR_APPLICATION) . '/install')) {
			$data['error_install'] = $this->language->get('error_install');
		} else {
			$data['error_install'] = '';
		}

		$data['token'] = $this->session->data['token'];
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('common/dashboard.tpl', $data));
	}
}