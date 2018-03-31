<?php
class ControllercatalogTag extends Controller {
    private $error = array();

    public function index() {
        $this->load->language('catalog/tag');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->public_model('tag/tag');

        $this->getList();
    }

    public function add() {
        $this->load->language('catalog/tag');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->public_model('tag/tag');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

            if(!isset($this->request->post['tag_feature']))
                $this->request->post['tag_feature']=0;


            $this->model_tag_tag->addTag($this->request->post);

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

            $url .= '&object_type=' . $this->objects->object_type;

            $this->response->redirect($this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function edit() {
        $this->load->language('catalog/tag');

        $this->document->setTitle($this->language->get('heading_title'));
        $this->load->public_model('tag/tag');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {

            if(!isset($this->request->post['tag_feature']))
                $this->request->post['tag_feature']=0;

            $this->model_tag_tag->editTag($this->request->get['tag_id'], $this->request->post);

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

            $url .= '&object_type=' . $this->objects->object_type;

            $this->response->redirect($this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getForm();
    }

    public function delete() {
        $this->load->language('catalog/tag');

        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->public_model('tag/tag');

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


            foreach ($this->request->post['selected'] as $tag_id) {
                $this->model_tag_tag->deleteTag($tag_id);
            }

            $this->session->data['success'] = $this->language->get('text_success');

            $this->response->redirect($this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->getList();
    }

    protected function getList() {
        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'name';
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

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );

        $data['add'] = $this->url->link('catalog/tag/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        $data['delete'] = $this->url->link('catalog/tag/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');

        $data['tages'] = array();

        $filter_data = array(
            'filter_tag_type'  => $this->objects->object_type,
            'sort'  => $sort,
            'order' => $order,
            'start' => ($page - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $tag_total = $this->model_tag_tag->getTotal($filter_data);

        $results = $this->model_tag_tag->getTages($filter_data);

        foreach ($results as $result) {
            $data['tages'][] = array(
                'tag_id' => $result['tag_id'],
                'name'            => $result['name'],
                'edit'            => $this->url->link('catalog/tag/edit', 'token=' . $this->session->data['token'] . '&tag_id=' . $result['tag_id'] . $url, 'SSL')
            );
        }

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_list'] = $this->language->get('text_list');
        $data['text_no_results'] = $this->language->get('text_no_results');
        $data['text_confirm'] = $this->language->get('text_confirm');

        $data['column_name'] = $this->language->get('column_name');
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

        if (isset($this->request->get['page'])) {
            $url .= '&page=' . $this->request->get['page'];
        }

        $url .= '&object_type=' . $this->objects->object_type;

        $data['sort_name'] = $this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . '&sort=name' . $url, 'SSL');

        $url = '';

        if (isset($this->request->get['sort'])) {
            $url .= '&sort=' . $this->request->get['sort'];
        }

        if (isset($this->request->get['order'])) {
            $url .= '&order=' . $this->request->get['order'];
        }

        $url .= '&object_type=' . $this->objects->object_type;

        $pagination = new Pagination();
        $pagination->total = $tag_total;
        $pagination->page = $page;
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf($this->language->get('text_pagination'), ($tag_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($tag_total - $this->config->get('config_limit_admin'))) ? $tag_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $tag_total, ceil($tag_total / $this->config->get('config_limit_admin')));

        $data['sort'] = $sort;
        $data['order'] = $order;

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('catalog/tag_list.tpl', $data));
    }

    protected function getForm() {
        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_form'] = !isset($this->request->get['tag_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');

        $data['entry_name'] = $this->language->get('entry_name');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');

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
            $data['error_name'] = array();
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

        $url .= '&object_type=' . $this->objects->object_type;

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url, 'SSL')
        );

        if (!isset($this->request->get['tag_id'])) {
            $data['action'] = $this->url->link('catalog/tag/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
        } else {
            $data['action'] = $this->url->link('catalog/tag/edit', 'token=' . $this->session->data['token'] . '&tag_id=' . $this->request->get['tag_id'] . $url, 'SSL');
        }

        $data['cancel'] = $this->url->link('catalog/tag', 'token=' . $this->session->data['token'] . $url, 'SSL');

        if (isset($this->request->get['tag_id'])) {
            $tag_info = $this->model_tag_tag->getTag($this->request->get['tag_id']);
            $tag_info_des=$this->model_tag_tag->getTagDescriptions($this->request->get['tag_id']);
        }

        $this->load->model('localisation/language');

        $data['languages'] = $this->model_localisation_language->getLanguages();



        if (isset($this->request->post['tag_category'])) {
            $data['tag_category'] = $this->request->post['tag_category'];
        } elseif (isset($this->request->get['tag_id'])) {
            $data['tag_category'] = $tag_info['category_tag_id'];
        } else {
            $data['tag_category'] = 0;
        }

        if (isset($this->request->post['tag_type'])) {
            $data['tag_type'] = $this->request->post['tag_type'];
        } elseif (isset($this->request->get['tag_id'])) {
            $data['tag_type'] = $tag_info['tag_type'];
        } else {
            $data['tag_type'] = $this->objects->object_type;
        }

        if (isset($this->request->post['tag_feature'])) {
            $data['tag_feature'] = $this->request->post['tag_feature'];
        } elseif (isset($this->request->get['tag_id'])) {
            $data['tag_feature'] = $tag_info['tag_feature'];
        } else {
            $data['tag_feature'] = 0;
        }


        if (isset($this->request->post['tag'])) {
            $data['tag'] = $this->request->post['tag'];
        } elseif (isset($tag_info)) {
            $data['tag'] =$tag_info_des;
        } else {
            $data['tag'] = array();
        }
        $this->load->model('catalog/category');
        $filter_category=array(
            'filter_category_type'=>$this->objects->object_type
        );
        $categories = $this->model_catalog_category->getCategories($filter_category);
        $data['categories'] = array();
        foreach ($categories as $category) {
                $data['categories'][] = array(
                    'category_id' => $category['category_id'],
                    'name' => $category['name']
                );
        }
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('catalog/tag_form.tpl', $data));
    }

    protected function validateForm() {
        if (!$this->user->hasPermission('modify', 'catalog/tag')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        foreach ($this->request->post['tag'] as $language_id => $value) {
            if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 32)) {
                $this->error['name'][$language_id] = $this->language->get('error_name');
            }
        }
        return !$this->error;
    }

    protected function validateDelete() {
        if (!$this->user->hasPermission('modify', 'catalog/tag')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        $this->load->model('setting/store');
        $this->load->public_model('tag/tag');

        foreach ($this->request->post['selected'] as $tag_id) {
            $product_total = $this->model_tag_tag->getTotalProductsByTagId($tag_id);

            if ($product_total) {
                $this->error['warning'] = sprintf($this->language->get('error_product'), $product_total);
            }
        }

        return !$this->error;
    }

    public function autocomplete() {
        $json = array();
        if (isset($this->request->get['filter_name'])) {
            $this->load->public_model('tag/tag');
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'filter_tag_type' => $this->objects->object_type,
                'sort'        => 'name',
                'order'       => 'ASC',
                'start'       => 0,
                'limit'       => 10
            );

            $results = $this->model_tag_tag->getTages($filter_data);

            foreach ($results as $result) {
                $json[] = array(
                    'tag_id' => $result['tag_id'],
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
}