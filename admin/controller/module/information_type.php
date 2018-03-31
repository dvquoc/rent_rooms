<?php
class ControllerModuleInformationType extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('module/information_type');
		$this->load->language('common/object');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('extension/module');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			if (!isset($this->request->get['module_id'])) {
				$this->model_extension_module->addModule('information_type', $this->request->post);
			} else {
				$this->model_extension_module->editModule($this->request->get['module_id'], $this->request->post);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_edit'] = $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_limit'] = $this->language->get('entry_limit');
		$data['entry_type'] = $this->language->get('entry_type');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['entry_linit'] = $this->language->get('entry_linit');
		$data['entry_show_type'] = $this->language->get('entry_show_type');
		$data['entry_status'] = $this->language->get('entry_status');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = '';
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL')
		);

		if (!isset($this->request->get['module_id'])) {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/information_type', 'token=' . $this->session->data['token'], 'SSL')
			);
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('module/information_type', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL')
			);
		}

		if (!isset($this->request->get['module_id'])) {
			$data['action'] = $this->url->link('module/information_type', 'token=' . $this->session->data['token'], 'SSL');
		} else {
			$data['action'] = $this->url->link('module/information_type', 'token=' . $this->session->data['token'] . '&module_id=' . $this->request->get['module_id'], 'SSL');
		}

		$data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->get['module_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$module_info = $this->model_extension_module->getModule($this->request->get['module_id']);
		}

        if (isset($this->request->post['name'])) {
            $data['name'] = $this->request->post['name'];
        } elseif (!empty($module_info)) {
            $data['name'] = $module_info['name'];
        } else {
            $data['name'] = '';
        }

        if (isset($this->request->post['description'])) {
            $data['description'] = $this->request->post['description'];
        } elseif (!empty($module_info)) {
            $data['description'] = $module_info['description'];
        } else {
            $data['description'] = '';
        }

        if (isset($this->request->post['slider'])) {
            $data['slider'] = $this->request->post['slider'];
        } elseif (!empty($module_info)) {
            $data['slider'] = $module_info['slider'];
        } else {
            $data['slider'] = 0;
        }

        if (isset($this->request->post['limit_des'])) {
            $data['limit_des'] = $this->request->post['limit_des'];
        } elseif (!empty($module_info)) {
            $data['limit_des'] = $module_info['limit_des'];
        } else {
            $data['limit_des'] = $this->config->get("config_product_description_length");
        }


        if (isset($this->request->post['limit'])) {
            $data['limit'] = $this->request->post['limit'];
        } elseif (!empty($module_info)) {
            $data['limit'] = $module_info['limit'];
        } else {
            $data['limit'] = 8;
        }

        if (isset($this->request->post['show_type'])) {
            $data['limit'] = $this->request->post['show_type'];
        } elseif (!empty($module_info)) {
            $data['show_type'] = $module_info['show_type'];
        } else {
            $data['show_type'] = 'list';
        }

		if (isset($this->request->post['type'])) {
			$data['type'] = $this->request->post['type'];
		} elseif (!empty($module_info)) {
			$data['type'] = $module_info['type'];
		} else {
			$data['type'] = '-1';
		}

        $data['types']=array();
		if(!empty($this->objects->dataObject())){
		    foreach ($this->objects->dataObject() as $item){
                $data['types'][] = array(
                    'id' => $item['alias_name'],
                    'name' => $this->language->get('text_'.$item['alias_name'].'_group')
                );
            }
        }


		if (isset($this->request->post['category'])) {
			$data['category'] = $this->request->post['category'];
		} elseif (!empty($module_info)) {
			$data['category'] = $module_info['category'];
		} else {
			$data['category'] = '-1';
		}

        $data['categories'] =array();
		if($data['type']!=-1){
		    $this->load->model('catalog/category');
            $data_filter = array(
                'filter_name' =>'',
                'filter_category_type' =>$data['type'],
            );
            $data['categories'] = $this->model_catalog_category->getCategories($data_filter);
        }



		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($module_info)) {
			$data['status'] = $module_info['status'];
		} else {
			$data['status'] = 1;
		}

        if (isset($this->request->post['show_category_link'])) {
            $data['show_category_link'] = $this->request->post['show_category_link'];
        } elseif (!empty($module_info) && isset($module_info['show_category_link'])) {
            $data['show_category_link'] = $module_info['show_category_link'];
        } else {
            $data['show_category_link'] = 0;
        }

        if (isset($this->request->post['prefix_module'])) {
            $data['prefix_module'] = $this->request->post['prefix_module'];
        } elseif (!empty($module_info)) {
            $data['prefix_module'] = $module_info['prefix_module'];
        } else {
            $data['prefix_module'] = 'information_type_' . time();
        }

        if (isset($this->request->post['information_list'])) {
            $data['information_list'] = $this->request->post['information_list'];
        } elseif (!empty($module_info) && isset($module_info['information_list'])) {
            $data['information_list'] = $module_info['information_list'];
        } else {
            $data['information_list'] = false;
        }
        if($data['information_list']){
            $this->load->model('catalog/information');
            $data['information_list'] = $this->model_catalog_information->getInformationByListId($data['information_list']);
        }

        $data['information_autocomplete']=str_replace('&amp;','&',$this->url->link('catalog/information/autocomplete','token='.$this->session->data['token'],'SSL'));

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('module/information_type.tpl', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/information_type')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }
		return !$this->error;
	}
}