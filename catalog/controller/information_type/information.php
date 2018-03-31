<?php
class ControllerInformationTypeInformation extends Controller {
	public function index() {
		$this->load->language('information/information');
		$this->load->language('common/information_type');
		$this->load->model('catalog/information');
        $this->load->model('tool/image');

        $request_type=$this->object_current['alias_url']['type']['request_id'];
        $router_type=$this->object_current['alias_url']['type']['router_page'];

        $request_information=$this->object_current['alias_url']['information']['request_id'];
        $router_information=$this->object_current['alias_url']['information']['router_page'];

        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_'.$this->objects->object_type),
            'href' => $this->url->link($router_type,$request_type.'='.$this->objects->object_type,'SSL')
        );


        $data['informations'] = array();
        $filter_data=array(
            'filter_category_id'=>0,
            'filter_information_type'=>$this->objects->object_type,
            'start'	=>0,
            'limit'	=>10,
        );
        $results=$this->model_catalog_information->getInformations($filter_data);
        foreach ($results as $result) {
            if ($result['image']) {
                $image = $this->model_tool_image->resize($result['image'],220, 100,'a');
            } else {
                $image = $this->model_tool_image->resize('placeholder.png', 220, 100,'a');
            }
            $data['informations'][] = array(
                'information_id'  => $result['information_id'],
                'thumb'       => $image,
                'name'        => $result['title'],
                'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 250) . '...',
                'href'        => $this->url->link($router_information,$request_type.'='.$this->objects->object_type.'&'.$request_information.'='. $result['information_id']),
            );
        }
		if ($data['informations']) {
            //@TODO: Get form config. Now is difine;
            $data['name'] = $this->object_current['meta']['title'];
            $this->document->setTitle($this->object_current['meta']['title']);
            $this->document->setDescription($this->object_current['meta']['description']);
            $this->document->setKeywords($this->object_current['meta']['keyword']);


            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/content/list_content.tpl')) {
                $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/part/content/list_content.tpl',$data );
            } else {
                $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/part/content/list_content.tpl', $data);
            }
            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/category_'.$this->_object['alias_name'].'/category.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/category_'.$this->_object['alias_name'].'/category.tpl', $data));
            } else {
                if (file_exists(DIR_TEMPLATE . 'default/template/information_type/type_'.$this->_object['alias_name'].'.tpl')) {
                    $this->response->setOutput($this->load->view('default/template/information_type/type_' . $this->_object['alias_name'] . '.tpl', $data));
                }else {
                    $this->response->setOutput($this->load->view('default/template/information_type/type_information.tpl', $data));
                }
            }
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/error/not_found.tpl')) {
				$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/error/not_found.tpl', $data));
			} else {
				$this->response->setOutput($this->load->view('default/template/error/not_found.tpl', $data));
			}
		}
	}

	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
}