<?php
class ControllerErrorNotFound extends Controller {
	public function index() {
		$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

		$this->document->setTitle("404 Not Found");

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => 'Về trang chủ',
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['route'])) {
			$url_data = $this->request->get;

			unset($url_data['_route_']);

			$route = $url_data['route'];

			unset($url_data['route']);

			$url = '';

			if ($url_data) {
				$url = '&' . urldecode(http_build_query($url_data, '', '&'));
			}

			$data['breadcrumbs'][] = array(
				'text' => "Lỗi 404",
				'href' => $this->url->link($route, $url, $this->request->server['HTTPS'])
			);
		}

		$data['heading_title'] = "Lỗi 404";

		$data['text_error'] = 'Trang bạn không tìm thấy';

		$data['button_continue'] ='Tiếp tục';

		$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

		$data['continue'] = $this->url->link('common/home');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		$this->response->setOutput($this->load->view('error/not_found', $data));
	}
}