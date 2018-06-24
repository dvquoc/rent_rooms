<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		$this->load->model('page/register');
		if(isset($_SESSION['id_source']))
		{
	        $data['user'] = $this->model_page_register->get_user($_SESSION['id_source']);
		}
		$data['title']= "Trang header";
		$data['menu_map']= $this->url->link_seo('tim-kiem-theo-ban-do','SSL');
		$data['list']= $this->url->link_seo('tim-kiem-theo-list','SSL');
        $data['classPage'] = '';
		if(isset($this->request->get['route']))
            $data['classPage'] = str_replace('/','-', $this->request->get['route']);
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/header.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/header.tpl', $data);
		} else {
			return $this->load->view('default/template/common/header.tpl', $data);
		}

	}
}