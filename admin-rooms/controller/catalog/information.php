<?php
class ControllerCatalogInformation extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/information');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/information');

		$this->getList();

	}

	public function add() {
		$this->load->language('catalog/information');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/information');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			if(empty($this->request->post['information_images']))
				$this->request->post['information_images']=array();

			$this->model_catalog_information->addInformation($this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['filter_category_id'])) {
				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
			}

			$url .= '&object_type=' . $this->objects->object_type;

			$this->response->redirect($this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/information');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/information');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			if(empty($this->request->post['information_images']))
				$this->request->post['information_images']=array();
            $this->model_catalog_information->editInformation($this->request->get['information_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['filter_category_id'])) {
				$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
			}

			$url .= '&object_type=' . $this->objects->object_type;

			$this->response->redirect($this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/information');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/information');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$url .= '&object_type=' . $this->objects->object_type;

			foreach ($this->request->post['selected'] as $information_id) {
				$this->model_catalog_information->deleteInformation($information_id);
			}

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['filter_name'])) {
			$filter_name = $this->request->get['filter_name'];
		} else {
			$filter_name = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'id.title';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category_id'])) {
			$url .= '&filter_category_id=' . urlencode(html_entity_decode($this->request->get['filter_category_id'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_information_id'])) {
			$url .= '&filter_information_id=' . urlencode(html_entity_decode($this->request->get['filter_information_id'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}


		$url .= '&object_type='.$this->objects->object_type;


		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		$data['add'] = $this->url->link('catalog/information/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('catalog/information/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['action_fitler'] = str_replace('&amp;','&',$this->url->link('catalog/information', 'token=' . $this->session->data['token'] . "&object_type=".$this->objects->object_type, 'SSL'));

		$data['informations'] = array();

		$filter_data = array(
				'filter_information_type'  =>  $this->objects->object_type,
				'filter_name'  => $filter_name,
				'sort'  => $sort,
				'order' => $order,
				'start' => ($page - 1) * $this->config->get('config_limit_admin'),
				'limit' => $this->config->get('config_limit_admin')
		);

		$default_object_project=$this->objects->dataObject();

		if(isset($default_object_project[$this->objects->object_type]) && isset($default_object_project[$this->objects->object_type]['have_category']) && $default_object_project[$this->objects->object_type]['have_category']) {

			if (isset($this->request->get['filter_category_id'])) {
				$filter_category_id = $this->request->get['filter_category_id'];
			} else {
				$filter_category_id = 0;
			}
			$data['filter_category_id'] = $filter_category_id;

			$filter_data['filter_category_id']=$filter_category_id;

			$this->load->model('catalog/category');
			$data['categories'] = array();
			$filter_data_category = array(
					'filter_category_type'  => $this->objects->object_type,
					'start' => 0,
					'limit' => 100
			);
			$results = $this->model_catalog_category->getCategories($filter_data_category);
			foreach ($results as $result) {
				$data['categories'][] = array(
						'category_id' => $result['category_id'],
						'name'        => $result['name'],
				);
			}
		}

		$information_total = $this->model_catalog_information->getTotalInformations($filter_data);

		$results = $this->model_catalog_information->getInformations($filter_data);

        $this->load->model('tool/image');
        $image_default=$this->model_tool_image->resize('no_image.png', 70, 60);

		foreach ($results as $result) {
            // Main image
            if(is_file(DIR_IMAGE . $result['image'])) {
                $data['image'] = $this->model_tool_image->resize($result['image'], 70, 60);
            } else {
                $data['image'] = $image_default;
            }
			$data['informations'][] = array(
					'information_id' => $result['information_id'],
					'image'          => $data['image'],
					'title'          => $result['title'],
					'sort_order'     => $result['sort_order'],
					'edit'           => $this->url->link('catalog/information/edit', 'token=' . $this->session->data['token'] . '&information_id=' . $result['information_id'] . $url, 'SSL')
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_title'] = $this->language->get('column_title');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . urlencode(html_entity_decode($this->request->get['filter_name'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_category_id'])) {
			$url .= '&filter_category_id=' . urlencode(html_entity_decode($this->request->get['filter_category_id'], ENT_QUOTES, 'UTF-8'));
		}

		$url .= '&object_type='.$this->objects->object_type;

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_title'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . '&sort=id.title' . $url, 'SSL');
		$data['sort_sort_order'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . '&sort=i.sort_order' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $information_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($information_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($information_total - $this->config->get('config_limit_admin'))) ? $information_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $information_total, ceil($information_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;
		$data['filter_name'] = $filter_name;
		$data['token'] = $this->session->data['token'];

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/information_list.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_form'] = !isset($this->request->get['information_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');

		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
		$data['entry_keyword'] = $this->language->get('entry_keyword');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_bottom'] = $this->language->get('entry_bottom');
		$data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_layout'] = $this->language->get('entry_layout');

		$data['help_keyword'] = $this->language->get('help_keyword');
		$data['help_bottom'] = $this->language->get('help_bottom');

		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');

		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');
		$data['tab_design'] = $this->language->get('tab_design');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['title'])) {
			$data['error_title'] = $this->error['title'];
		} else {
			$data['error_title'] = array();
		}

		if (isset($this->error['description'])) {
			$data['error_description'] = $this->error['description'];
		} else {
			$data['error_description'] = array();
		}

		if (isset($this->error['meta_title'])) {
			$data['error_meta_title'] = $this->error['meta_title'];
		} else {
			$data['error_meta_title'] = array();
		}

		if (isset($this->error['keyword'])) {
			$data['error_keyword'] = $this->error['keyword'];
		} else {
			$data['error_keyword'] = '';
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['filter_category_id'])) {
			$url .= '&filter_category_id=' . $this->request->get['filter_category_id'];
		}

		$url .= '&object_type=' . $this->objects->object_type;

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_home'),
				'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
				'text' => $this->language->get('heading_title'),
				'href' => $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);

		if (!isset($this->request->get['information_id'])) {
			$data['action'] = $this->url->link('catalog/information/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('catalog/information/edit', 'token=' . $this->session->data['token'] . '&information_id=' . $this->request->get['information_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('catalog/information', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['information_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$information_info = $this->model_catalog_information->getInformation($this->request->get['information_id']);
			$information_meta = $this->model_catalog_information->getInformationMeta($this->request->get['information_id']);
		}

		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['information_description'])) {
			$data['information_description'] = $this->request->post['information_description'];
		} elseif (isset($this->request->get['information_id'])) {
			$data['information_description'] = $this->model_catalog_information->getInformationDescriptions($this->request->get['information_id']);
		} else {
			$data['information_description'] = array();
		}

        if (isset($this->request->post['keyword'])) {
            $data['keyword'] = $this->request->post['keyword'];
        } elseif (!empty($information_info)) {
            $data['keyword'] = $information_info['keyword'];
        } else {
            $data['keyword'] = '';
        }

		if (isset($this->request->post['information_type'])) {
			$data['information_type'] = $this->request->post['information_type'];
		} elseif (!empty($information_info)) {
			$data['information_type'] = $information_info['information_type'];
		} else {
			$data['information_type'] = $this->objects->object_type;
		}

		$this->load->language('catalog/'.$this->objects->object_type);
		$default_object_project=$this->objects->dataObject();
		if(isset($default_object_project[$this->objects->object_type])) {
            $data['meta_contents']=array();
			if (isset($default_object_project[$this->objects->object_type]['meta_array'])) {
				foreach ($default_object_project[$this->objects->object_type]['meta_array'] as $key_group => $group_meta) {
					foreach ($group_meta as $meta_id => $value_meta) {
						if($value_meta['type']=='radio')
							$data['meta_contents'][$key_group][$meta_id]['data_option']=$value_meta['data_option'];
						if($value_meta['type']=='autocomplete') {
                            $data['meta_contents'][$key_group][$meta_id]['type_object_relative'] = $value_meta['type_object_relative'];
                        }

                        $data['meta_contents'][$key_group][$meta_id]['name'] = "_" . $meta_id;
                        $data['meta_contents'][$key_group][$meta_id]['label'] = $this->language->get('text_' . $meta_id);

                        if (isset($this->request->post["_" . $this->objects->object_type . "_" . $meta_id])) {
                            $data_meta = $this->request->post["_" . $this->objects->object_type . "_" . $meta_id];
                        } elseif (isset($this->request->get['information_id'])) {
                            $data_meta = (isset($information_meta["_" . $meta_id])) ? $information_meta["_" . $meta_id] : '';
                        } else {
                            $data_meta = $value_meta['data_default'];
                        }

                        if($value_meta['type']=='autocomplete' && $data_meta !=$value_meta['data_default']) {
                            $data_meta = unserialize($data_meta);
                            $data_meta = $this->model_catalog_information->getInformationByListId($data_meta);
                        }
                        $data['meta_contents'][$key_group][$meta_id]['value'] = $data_meta;
                        $data['meta_contents'][$key_group][$meta_id]['required'] = $value_meta['required'];
                        $data['meta_contents'][$key_group][$meta_id]['type'] = $value_meta['type'];
                        $data['meta_contents'][$key_group][$meta_id]['token'] = $this->session->data['token'];

					}
					if(isset($data['meta_contents'][$key_group])) {
                        $data_meta = $data['meta_contents'][$key_group];
                        $data['meta_contents'][$key_group] = $this->load->view('catalog/information_meta.tpl', $data_meta);
                    }
				}
			}

			// Categories
			if (isset($default_object_project[$this->objects->object_type]['have_category']) && $default_object_project[$this->objects->object_type]['have_category']) {
				$this->load->model('catalog/category');
				$data['categories'] = array();
				$filter_data = array(
						'filter_category_type'  => $this->objects->object_type,
						'start' => 0,
						'limit' => 100
				);
				$results = $this->model_catalog_category->getCategories($filter_data);
				foreach ($results as $result) {
					$data['categories'][] = array(
							'category_id' => $result['category_id'],
							'name'        => $result['name'],
					);
				}

				if (isset($this->request->post['category_id'])) {
					$data['category_id'] = $this->request->post['category_id'];
				} elseif (!empty($information_info)) {
					$data['category_id'] = $information_info['category_id'];
				} else {
					$data['category_id'] = 0;
				}
			}

			// Tages
			if (isset($default_object_project[$this->objects->object_type]['have_tag']) && $default_object_project[$this->objects->object_type]['have_tag']) {
				$data['prefix_tag']=$this->config->get('tag')['prefix_alias'];
				$this->load->public_model('tag/tag');
				if (isset($this->request->post['information_tag'])) {
					$tages = $this->request->post['information_tag'];
				} elseif (!empty($information_info)) {
					$tages = unserialize($information_info['information_tags']);
				} else {
					$tages = array();
				}
				$data['information_tags'] = array();

				if(!empty($tages)){
					foreach ($tages as $tag) {
						$tag_id=str_replace($data['prefix_tag'],'',$tag);
						$tag_info = $this->model_tag_tag->getTag($tag_id);
						if ($tag_info) {
							$data['information_tags'][] = array(
									'tag_id' => $data['prefix_tag'].$tag_info['tag_id'],
									'name' => $tag_info['name']
							);
						}
					}
				}
				$data['tag_autocomplete']=str_replace('&amp;','&',$this->url->link('catalog/tag/autocomplete','token='.$this->session->data['token'].'&filter_name=\'+encodeURIComponent(request)+\'&object_type='.$this->objects->object_type,'SSL'));
			}
		}// End check exit oject

		// Main image
		if (isset($this->request->post['image'])) {
			$data['image'] = $this->request->post['image'];
		} elseif (!empty($information_info) && is_file(DIR_IMAGE . $information_info['image'])) {
			$data['image'] = $information_info['image'];
		} else {
			$data['image'] = 'no_image.png';
		}

		$this->load->model('tool/image');
		$data['thumb'] = $this->model_tool_image->resize($data['image'], 100, 100);

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		// Images list thumb
		if (isset($this->request->post['information_images'])) {
			$information_images = $this->request->post['information_images'];
		} elseif (isset($information_info['information_images'])) {
			$information_images = unserialize($information_info['information_images']);
		} else {
			$information_images = array();
		}


		$data['information_images'] = array();
		foreach ($information_images as $information_image) {
			if (is_file(DIR_IMAGE . $information_image)) {
				$image = $information_image;
			} else {
				$image = 'no_image.png';
			}

			$data['information_images'][] = array(
					'image'      => $image,
					'thumb'      => $this->model_tool_image->resize($image, 100, 100),
			);
		}

		if (isset($this->request->post['feature'])) {
			$data['feature'] = $this->request->post['feature'];
		} elseif (isset($information_info['feature'])) {
			$data['feature'] = $information_info['feature'];
		} else {
			$data['feature'] = 0;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($information_info)) {
			$data['status'] = $information_info['status'];
		} else {
			$data['status'] = true;
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($information_info)) {
			$data['sort_order'] = $information_info['sort_order'];
		} else {
			$data['sort_order'] = '';
		}

		if (isset($this->request->post['information_layout'])) {
			$data['information_layout'] = $this->request->post['information_layout'];
		} elseif (isset($this->request->get['information_id'])) {
			$data['information_layout'] = $this->model_catalog_information->getInformationLayouts($this->request->get['information_id']);
		} else {
			$data['information_layout'] = array();
		}

		$this->load->model('design/layout');

		$data['layouts'] = $this->model_design_layout->getLayouts();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/information_form.tpl', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/information')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		foreach ($this->request->post['information_description'] as $language_id => $value) {
			if ((utf8_strlen($value['title']) < 3) || (utf8_strlen($value['title']) > 64)) {
				$this->error['title'][$language_id] = $this->language->get('error_title');
			}

			if (utf8_strlen($value['description']) < 3) {
				$this->error['description'][$language_id] = $this->language->get('error_description');
			}

			if ((utf8_strlen($value['meta_title']) < 3) || (utf8_strlen($value['meta_title']) > 255)) {
				$this->error['meta_title'][$language_id] = $this->language->get('error_meta_title');
			}
		}

		if ($this->error && !isset($this->error['warning'])) {
			$this->error['warning'] = $this->language->get('error_warning');
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/information')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		foreach ($this->request->post['selected'] as $information_id) {
			if ($this->config->get('config_account_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_account');
			}

			if ($this->config->get('config_checkout_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_checkout');
			}

			if ($this->config->get('config_affiliate_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_affiliate');
			}

			if ($this->config->get('config_return_id') == $information_id) {
				$this->error['warning'] = $this->language->get('error_return');
			}
		}

		return !$this->error;
	}

    public function autocomplete() {
        $json = array();

        if (isset($this->request->get['filter_name'])) {
            $type_information = $this->objects->object_type;
            if (isset($this->request->get['object_type']))
                $type_information = $this->request->get['object_type'];
            $this->load->model('catalog/information');
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'filter_information_type' => $type_information,
                'sort'        => 'name',
                'order'       => 'ASC',
                'start'       => 0,
                'limit'       => 10
            );
            $results = $this->model_catalog_information->getInformations($filter_data);
            foreach ($results as $result) {
                $json[] = array(
                    'id' => $result['information_id'],
                    'name'        => strip_tags(html_entity_decode($result['title'], ENT_QUOTES, 'UTF-8'))
                );
            }
        }

        $sort_order = array();

        foreach ($json as $key => $value) {
            $sort_order[$key] = $value['name'];
        }

        array_multisort($sort_order, SORT_ASC, $json);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($json));
    }
}