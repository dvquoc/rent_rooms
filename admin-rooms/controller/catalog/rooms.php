<?php
class ControllerCatalogRooms extends Controller {
	private $error = array();

	public function __construct($registry)
    {
        parent::__construct($registry);
        if(isset($registry->get('request')->get['city']) && isset($registry->get('request')->get['district'])) {
            $registry->set('prefix_rooms', $registry->get('request')->get['city'].'_'.$registry->get('request')->get['district'].'_');
        }else{ // Get by user;
            $registry->set('prefix_rooms', '1_1_');
        }
    }

    public function index() {
		$this->document->setTitle("Quản lý phòng");
		$this->load->public_model('catalog/rooms');
		$this->getList();
	}

	public function add() {

		$this->document->setTitle("Thêm phòng trọ");

		$this->load->public_model('catalog/rooms');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
            var_dump($this->prefix_rooms); die();
            $this->request->post['images'] = serialize($this->request->post['images']);
            if(empty($this->request->post['images']))
                $this->request->post['images']=array();

            if(empty($this->request->post['date_create']))
                $this->request->post['date_create']='NOW()';

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
        $data['error_warning'] = '';
        if (isset($this->error['warning']))
            $data['error_warning'] = $this->error['warning'];

        $data['success'] = '';
        if (isset($this->session->data['success'])) {
            $data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }

        if (isset($this->request->get['page']))
            $page = $this->request->get['page'];
        else
            $page = $this->request->get['page'] = 1;

        $data_filter = array (
            'city'  => isset($this->request->get['city']) ? $this->request->get['city']: 1,
            'district' => isset($this->request->get['district']) ? $this->request->get['district']: 1,
            'type' => isset($this->request->get['type']) ? $this->request->get['type']: null,
            'special' => isset($this->request->get['special']) ? $this->request->get['special']: null,
            'ads' => isset($this->request->get['ads']) ? $this->request->get['ads']: -1,
            'ads_position' =>isset($this->request->get['ads_position']) ? $this->request->get['ads_position']: -1,
            'status' =>isset($this->request->get['status']) ? $this->request->get['status']: 1,
            'close_door' =>isset($this->request->get['close_door']) ? $this->request->get['close_door']: -1,
            'price' =>isset($this->request->get['price']) ? $this->request->get['price']: -1,
            'acreage' =>isset($this->request->get['acreage']) ? $this->request->get['acreage']: -1,
            'name' =>isset($this->request->get['name']) ? $this->request->get['name']: -1,
        );


        $data_query = array(
            'sort'  => 'name',
            'order' => 'ASC',
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $data_query = array_merge($data_query, $data_filter);

        $data_url = array_merge($data_query, $this->request->get);

		$url = http_build_query(array_diff_key($data_url, ['route'=>'','room_id'=>'']));


		$data['add'] = $this->url->link('catalog/rooms/add', $url, 'SSL');
		$data['delete'] = $this->url->link('catalog/rooms/delete', $url, 'SSL');
		$data['action_fitler'] = str_replace('&amp;','&',$this->url->link('catalog/rooms', 'token=' . $this->session->data['token'], 'SSL'));

        $data['sort_title'] = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'] . '&sort=id.title' . $url, 'SSL');
        $data['sort_sort_order'] = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'] . '&sort=i.sort_order' . $url, 'SSL');

        if(!empty($data_filter['special']) && !empty($data_filter['type'])){
            $this->load->public_model('location/location_admin');
            if($data_filter['type'] == 'street')
                $special = $this->model_location_location_admin->getStreetById($data_filter['special']);
            else
                $special = $this->model_location_location_admin->getSpecialById($data_filter['special']);
            $data_query['special'] = $special['location'];
            $data['text_special'] = $special['name'];
        }


		$data['rooms'] = array();
		$rooms_total = $this->model_catalog_rooms->getTotalRooms($data_query);
		$results = $this->model_catalog_rooms->find($data_query);
		foreach ($results as $result) {
			$data['rooms'][] = array(
					'room_id' => $result['room_id'],
					'name'          => $result['name'],
					'ads'          => $result['ads'],
					'from_date'          => $result['from_date'],
					'to_date'          => $result['to_date'],
					'text_price'          => format_currency($result['price']),
					'text_acreage'          => format_currency($result['acreage']),
					'edit'           => $this->url->link('catalog/rooms/edit','&room_id=' . $result['room_id']."&" . $url, 'SSL')
			);
		}

        $data['selected'] = array();
		if (isset($this->request->post['selected']))
			$data['selected'] = (array)$this->request->post['selected'];


        $this->load->public_model('location/location_admin');

        $data['citys'] = $this->model_location_location_admin->getAllCity();
        $data['districts'] = array();
        if(!empty($data_filter['city']))
            $data['districts'] =$this->model_location_location_admin->getDistrictByCity($data_filter['city']);

        $data['streets'] = array();
        if(!empty($data_filter['district']))
        $data['streets'] =$this->model_location_location_admin->getDistrictByCity($data_filter['district']);

        $data['data_filter'] = $data_filter;

		$pagination = new Pagination();
		$pagination->total = $rooms_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/rooms', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');
		$data['pagination'] = $pagination->render();
		$data['results'] = sprintf($this->language->get('text_pagination'), ($rooms_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($rooms_total - $this->config->get('config_limit_admin'))) ? $rooms_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $rooms_total, ceil($rooms_total / $this->config->get('config_limit_admin')));


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

        $url = http_build_query(array_diff_key($this->request->get, ['route'=>'','room_id'=>'']));
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

        $data['city'] = !empty($this->request->get['city'])? $this->request->get['city'] : 1;
        $data['district'] = !empty($this->request->get['district'])? $this->request->get['district'] : 1;

        $this->load->public_model('location/location_admin');
        $data['citys'] = $this->model_location_location_admin->getAllCity();
        $data['districts'] =$this->model_location_location_admin->getDistrictByCity($data['city']);

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
            $filter_data = array(
                'district' => $this->request->get['district_id'],
                'name' => $this->request->get['filter_name'],
                'start'       => 0,
                'limit'       => 20
            );
            $this->load->public_model('location/location_admin');
            $street = $this->model_location_location_admin->getStreetByDistrict($filter_data);
            $special = $this->model_location_location_admin->getSpecialByDistrict($filter_data);
            $results = array_merge($street,$special);
            foreach ($results as $result) {
                if($result['street_id'])
                    $json[] = array(
                        'id' => $result['street_id'],
                        'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                        'type' => 'street'
                    );
                else
                    $json[] = array(
                        'id' => $result['special_id'],
                        'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                        'type' => 'special'
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

    public function getDistricts(){
        $json = array();
        if (isset($this->request->get['city_id'])) {
            $this->load->public_model('location/location_admin');
            $results = $this->model_location_location_admin->getDistrictByCity($this->request->get['city_id']);
            foreach ($results as $result) {
                $json[] = array(
                    'id' => $result['district_id'],
                    'name'        => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
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

    public function getLocation(){
            $json = array();
            if (isset($this->request->get['district_id'])) {
                $this->load->public_model('location/location_admin');
                $json = $this->model_location_location_admin->getLocationDistrict($this->request->get['district_id']);
            }
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($json));
        }
}