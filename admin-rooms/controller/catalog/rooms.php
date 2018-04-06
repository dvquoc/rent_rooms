<?php
class ControllerCatalogRooms extends Controller {
	private $error = array();
	public function index() {
		$this->document->setTitle("Quản lý phòng");
		$this->load->public_model('catalog/rooms');
		$this->getList();
	}

	public function add() {
		$this->document->setTitle("Thêm phòng trọ");

		$this->load->public_model('catalog/rooms');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

			if(empty($this->request->post['rooms_images']))
				$this->request->post['rooms_images']=array();

			$this->model_catalog_rooms->addRooms($this->request->post);
			$this->session->data['success'] = "Thêm thành công";

            $url = http_build_query(array_diff_key($this->request->get, ['route'=>'']));

			$this->response->redirect($this->url->link('catalog/rooms', $url, 'SSL'));
		}

		$this->getForm();
	}

    public function edit() {
        $this->load->language('catalog/room');
        $this->document->setTitle("Chỉnh sửa phòng trọ");

        $this->load->public_model('catalog/rooms');
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            $this->request->post['images'] = serialize($this->request->post['images']);
            if(empty($this->request->post['images']))
                $this->request->post['images']=array();

            $this->model_catalog_rooms->editRooms($this->request->get['room_id'], $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $url = http_build_query(array_diff_key($this->request->get, ['route'=>'','room_id'=>'']));
            $this->response->redirect($this->url->link('catalog/rooms',$url, 'SSL'));
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
        $page = 1;
        if (isset($this->request->get['page']))
            $page = $this->request->get['page'];
        $filter_data = array(
            'sort'  => 'name',
            'order' => 'ASC',
            'status' => 1,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

		if (isset($this->request->get['city'])) {
            $filter_data['city'] = $this->request->get['city'];
		} else {
            $filter_data['city'] = null;
		}
        if (isset($this->request->get['district'])) {
            $filter_data['district'] = $this->request->get['district'];
        } else {
            $filter_data['district'] = null;
        }

		if (isset($this->request->get['sort']))
            $filter_data['sort'] = $this->request->get['sort'];
		if (isset($this->request->get['order']))
            $filter_data['sort'] = $this->request->get['order'];

		$url = http_build_query($filter_data);
        $url .= '&page=' . $page;

		$data['add'] = $this->url->link('catalog/rooms/add', 'token=' . $this->session->data['token']."&" . $url, 'SSL');
		$data['delete'] = $this->url->link('catalog/rooms/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['action_fitler'] = str_replace('&amp;','&',$this->url->link('catalog/rooms', 'token=' . $this->session->data['token'], 'SSL'));

		$data['rooms'] = array();
		$rooms_total = $this->model_catalog_rooms->getTotalRooms($filter_data);
		$results = $this->model_catalog_rooms->find($filter_data);

        $this->load->model('tool/image');
        $image_default=$this->model_tool_image->resize('no_image.png', 70, 60);
		foreach ($results as $result) {
            // Main image
            if(is_file(DIR_IMAGE . $result['image'])) {
                $data['image'] = $this->model_tool_image->resize($result['image'], 70, 60);
            } else {
                $data['image'] = $image_default;
            }
			$data['rooms'][] = array(
					'room_id' => $result['room_id'],
					'image'          => $data['image'],
					'name'          => $result['name'],
					'edit'           => $this->url->link('catalog/rooms/edit', 'token=' . $this->session->data['token'] . '&room_id=' . $result['room_id']."&" . $url, 'SSL')
			);
		}

        $data['error_warning'] = '';
		if (isset($this->error['warning']))
			$data['error_warning'] = $this->error['warning'];

        $data['success'] = '';
		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}
        $data['selected'] = array();
		if (isset($this->request->post['selected']))
			$data['selected'] = (array)$this->request->post['selected'];

		$data['sort_title'] = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'] . '&sort=id.title' . $url, 'SSL');
		$data['sort_sort_order'] = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'] . '&sort=i.sort_order' . $url, 'SSL');

		$pagination = new Pagination();
		$pagination->total = $rooms_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		$data['pagination'] = $pagination->render();
		$data['results'] = sprintf($this->language->get('text_pagination'), ($rooms_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($rooms_total - $this->config->get('config_limit_admin'))) ? $rooms_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $rooms_total, ceil($rooms_total / $this->config->get('config_limit_admin')));

		$data['filter_data'] = $filter_data;
		$data['token'] = $this->session->data['token'];
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('catalog/rooms_list.tpl', $data));
	}

    protected function getForm() {
        $data['text_form'] = !isset($this->request->get['room_id']) ? "Thêm phòng trọ" : "Chỉnh sửa phòng trọ";

        $data['error_warning'] = '';
        if (isset($this->error['warning']))
            $data['error_warning'] = $this->error['warning'];

        $data['error_name'] = array();
        if (isset($this->error['error_name']))
            $data['error_name'] = $this->error['error_name'];

        $url = http_build_query(array_diff_key($this->request->get, ['route'=>'']));

        if (!isset($this->request->get['room_id'])) {
            $data['action'] = $this->url->link('catalog/rooms/add', $url, 'SSL');
        } else {
            $data['action'] = $this->url->link('catalog/rooms/edit', $url, 'SSL');
        }

        $data['cancel'] = $this->url->link('catalog/rooms', $url, 'SSL');

        if (isset($this->request->get['room_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $array_fomat_txt = ['price', 'price_electricity','price_water', 'price_deposit'];
            $room_info = $this->model_catalog_rooms->getRoom($this->request->get['room_id']);
            foreach ($room_info as  $col => $vaule){
                $data[$col] = $vaule;
                if (isset($this->request->post[$col]))
                    $data[$col] = $this->request->post[$col];
                if(in_array($col, $array_fomat_txt))
                    $data['txt_'.$col] = format_currency($vaule);
            }
        }
        $data['token'] = $this->session->data['token'];

        $this->load->model('tool/image');
        $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

        // Images list thumb
        $room_images = unserialize($room_info['images']);
        if (isset($this->request->post['images']))
            $room_images = $this->request->post['images'];

        $data['room_images'] = array();
        foreach ($room_images as $room_image) {
            $image = 'no_image.png';
            if (is_file(DIR_IMAGE . $room_image))
                $image = $room_image;
            $data['room_images'][] = array(
                'image'      => $image,
                'thumb'      => $this->model_tool_image->resize($image, 100, 100),
            );
        }
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('catalog/rooms_form.tpl', $data));
    }

	protected function validateForm() {

		if (!$this->user->hasPermission('modify', 'catalog/rooms')) {
			$this->error['warning'] = "Không có quyền chỉnh sửa";
		}

		if(empty($this->request->post['name']))
            $this->error['error_name'] = "Tiêu đề không được để trống";

        if(empty($this->request->post['address']))
            $this->error['address'] = "Địa chỉ không được để trống";

        if(empty($this->request->post['lat']))
            $this->error['lat'] = "Kinh độ không được để trống";

        if(empty($this->request->post['lng']))
            $this->error['lng'] = "Vĩ độ không được để trống";

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