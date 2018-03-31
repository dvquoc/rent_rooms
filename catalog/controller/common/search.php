<?php
class ControllerCommonSearch extends Controller {
	public function index() {
		$this->load->language('common/search');

		$data['text_search'] = $this->language->get('text_search');

		if (isset($this->request->get['search'])) {
			$data['search'] = $this->request->get['search'];
		} else {
			$data['search'] = '';
		}

		if (isset($this->request->get['path'])) {
			$data['category_id'] = $this->request->get['path'];
		} else {
			$data['category_id'] = 0;
		}

		$this->load->public_model('tag/tag');
		$tag_features=$this->model_tag_tag->getTagFeatures($data['category_id']);
		$data['tag_features']=array();
		if(!empty($tag_features)){
			foreach($tag_features as $item) {
				$data['tag_features'][] = array(
						'tag_id' => $item['tag_id'],
						'name' => $item['name'],
						'href' => $this->url->link('page/search', '&tag_id=' . $item['tag_id'],'SSL')
				);
			}
		}

		$data['link_search'] = $this->url->link('page/search','','SSL');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/common/search.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/common/search.tpl', $data);
		} else {
			return $this->load->view('default/template/common/search.tpl', $data);
		}
	}
}