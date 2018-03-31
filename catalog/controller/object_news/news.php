<?php

class ControllerObjectNewsNews extends Controller
{
    public function index()
    {
        $this->load->language('common/information_type');
        $this->load->model('catalog/category');
        $this->load->model('catalog/information');
        $this->load->model('tool/image');

        $this->document->addStyle("/public/assets/pages/projects/projects.css");

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'i.sort_order';
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
        if (isset($this->request->get['limit'])) {
            $limit = $this->request->get['limit'];
        } else {
            $limit = $this->config->get('config_product_limit');
        }

        $data['categories'] = $this->getCategories();

        $request_category = $this->object_current['alias_url']['category']['request_id'];
        $router_category = $this->object_current['alias_url']['category']['router_page'];

        $request_type = $this->object_current['alias_url']['type']['request_id'];
        $router_type = $this->object_current['alias_url']['type']['router_page'];

        $request_information = $this->object_current['alias_url']['information']['request_id'];
        $router_information = $this->object_current['alias_url']['information']['router_page'];

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_' . $this->objects->object_type),
            'href' => $this->url->link($router_type, $request_type . '=' . $this->objects->object_type)
        );

        if (isset($this->request->get[$request_category])) {
            $parts = explode('_', (string)$this->request->get[$request_category]);
            $category_id = (int)array_pop($parts);
        } else {
            $category_id = 0;
        }
        $category_info = $this->model_catalog_category->getCategory($category_id);
        // Vào một danh mục cụ thể
        if ($category_info) {
            $data['category_id'] = $category_info['category_id'];
            $data['name'] = $category_info['name'];
            $this->document->setTitle($category_info['name']);
            $this->document->setDescription($category_info['meta_description']);
            $this->document->setKeywords($category_info['meta_keyword']);

            $data['breadcrumbs'][] = array(
                'text' => $category_info['name'],
                'href' => $this->url->link($router_category, $request_type . '=' . $this->objects->object_type . '&' . $request_category . "=" . $category_info['category_id'])
            );

            $data['infomations'] = array();
            $filter_data = array(
                'filter_information_type' => $this->objects->object_type,
                'filter_category_id' => $category_info['category_id'],
                'sort' => $sort,
                'order' => $order,
                'start' => ($page - 1) * $limit,
                'limit' => $limit
            );
            $information_total = $this->model_catalog_information->getTotalInformations($filter_data);
            $results = $this->model_catalog_information->getInformations($filter_data);
            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], 220, 116, 'a');
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', 220, 116, 'a');
                }
                $data['informations'][] = array(
                    'product_id' => $result['information_id'],
                    'thumb' => $image,
                    'name' => $result['title'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
                    'href' => $this->url->link($router_information, $request_type . '=' . $this->objects->object_type . '&' . $request_category . '=' . $category_info['category_id'] . '&' . $request_information . '=' . $result['information_id']),
                );
            }

            $pagination = new Pagination();
            $pagination->total = $information_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link($request_type, $request_type . '=' . $this->objects->object_type . '&' . $request_category . '=' . $category_info['category_id'] . '&page={page}');
            $data['pagination'] = $pagination->render();
            $data['results'] = sprintf($this->language->get('text_pagination'), ($information_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($information_total - $limit)) ? $information_total : ((($page - 1) * $limit) + $limit), $information_total, ceil($information_total / $limit));

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/content/list_content.tpl')) {
                $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/part/content/list_content.tpl', $data);
            } else {
                $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/part/content/list_content.tpl', $data);
            }
            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $router_category . '.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/' . $router_category . '.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/' . $router_category . '.tpl', $data));
            }
        } // Tất cả danh mục
        elseif (!$category_info && !isset($this->request->get[$request_category])) {
            $data['name'] = $this->object_current['meta']['title'];
            $this->document->setTitle($this->object_current['meta']['title']);
            $this->document->setDescription($this->object_current['meta']['description']);
            $this->document->setKeywords($this->object_current['meta']['keyword']);

            $data['infomations'] = array();
            $filter_data = array(
                'filter_information_type' => $this->objects->object_type,
                'sort' => $sort,
                'order' => $order,
                'start' => ($page - 1) * $limit,
                'limit' => $limit
            );

            $information_total = $this->model_catalog_information->getTotalInformations($filter_data);
            $results = $this->model_catalog_information->getInformations($filter_data);
            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], 220, 116, 'a');
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', 220, 116, 'a');
                }
                $url_category = '';
                if (!empty($result['category_id']))
                    $url_category = '&' . $request_category . '=' . $result['category_id'];
                $data['informations'][] = array(
                    'information_id' => $result['information_id'],
                    'thumb' => $image,
                    'name' => $result['title'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 300) . '...',
                    'href' => $this->url->link($router_information, $request_type . '=' . $this->objects->object_type . $url_category . '&' . $request_information . '=' . $result['information_id']),
                );
            }

            $pagination = new Pagination();
            $pagination->total = $information_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link($request_type, $request_type . '=' . $this->objects->object_type . '&page={page}');
            $data['pagination'] = $pagination->render();
            $data['results'] = sprintf($this->language->get('text_pagination'), ($information_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($information_total - $limit)) ? $information_total : ((($page - 1) * $limit) + $limit), $information_total, ceil($information_total / $limit));

            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/content/list_content.tpl')) {
                $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/part/content/list_content.tpl', $data);
            } else {
                $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/part/content/list_content.tpl', $data);
            }
            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');

            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/' . $router_category . '.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/' . $router_category . '.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/' . $router_category . '.tpl', $data));
            }
        } else {
            $url = '';

            if (isset($this->request->get['path_content'])) {
                $url .= '&path_content=' . $this->request->get['path_content'];
            }

            if (isset($this->request->get['filter'])) {
                $url .= '&filter=' . $this->request->get['filter'];
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

            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_error'),
                'href' => $this->url->link('product/category', $url)
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

    private function getCategories()
    {
        $request_category = $this->object_current['alias_url']['category']['request_id'];
        $router_category = $this->object_current['alias_url']['category']['router_page'];

        $request_type = $this->object_current['alias_url']['type']['request_id'];
        $router_type = $this->object_current['alias_url']['type']['router_page'];

        $request_information = $this->object_current['alias_url']['information']['request_id'];
        $router_information = $this->object_current['alias_url']['information']['router_page'];

        $this->load->model('catalog/category');
        $data_filter = array(
            'filter_category_type' => $this->objects->object_type
        );

        $data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0, $data_filter);

        foreach ($categories as $category) {
            $data['categories'][] = array(
                'category_id' => $category['category_id'],
                'name' => $category['name'],
                'des' => html_entity_decode($category['description'], ENT_QUOTES, 'UTF-8'),
                'image' => $this->model_tool_image->resize($category['image'], 100, 120, 'a'),
                'href' => $this->url->link($router_type, $request_type . '=' . $this->objects->object_type . '&' . $request_category . "=" . $category['category_id'])
            );
        }

        return $data['categories'];
    }
}