<?php
class ControllerPageSearch extends controller
{
    public function index()
    {
        if (isset($this->request->get['tag_id'])) {
            $this->load->model('tool/image');
            $this->load->public_model('tag/tag');

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
            $filter_data = array(
                'tag_id'              => $this->request->get['tag_id'],
                'start'               => ($page - 1) * $limit,
                'limit'               => $limit
            );
            $product_total = $this->model_tag_tag->getTotal($filter_data);
            $list_product_id = $this->model_tag_tag->getTagProducts($filter_data);
            foreach ($list_product_id as $item) {
                $this->load->model('catalog/product');
                $result=$this->model_catalog_product->getProduct($item['product_id']);
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('config_image_product_width'), $this->config->get('config_image_product_height'));
                }

                if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $price = false;
                }

                if ((float)$result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
                } else {
                    $special = false;
                }

                $data['products'][] = array(
                    'product_id'  => $result['product_id'],
                    'thumb'       => $image,
                    'name'        => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                    'price'       => $price,
                    'special'     => $special,
                    'href'        => $this->url->link('page/details', 'product_id=' . $result['product_id'])
                );
            }

            $url = '';

            if (isset($this->request->get['tag_id'])) {
                $url .= '&tag_id=' . urlencode(html_entity_decode($this->request->get['tag_id'], ENT_QUOTES, 'UTF-8'));
            }

            if (isset($this->request->get['sort'])) {
                $url .= '&sort=' . $this->request->get['sort'];
            }

            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            $data['limits'] = array();
            $limits = array_unique(array($this->config->get('config_product_limit'), 25, 50, 75, 100));
            sort($limits);
            foreach($limits as $value) {
                $data['limits'][] = array(
                    'text'  => $value,
                    'value' => $value,
                    'href'  => $this->url->link('page/search', $url . '&limit=' . $value)
                );
            }

            $url = '';
            if (isset($this->request->get['tag_id'])) {
                $url .= '&tag_id=' . urlencode(html_entity_decode($this->request->get['tag_id'], ENT_QUOTES, 'UTF-8'));
            }
            if (isset($this->request->get['order'])) {
                $url .= '&order=' . $this->request->get['order'];
            }
            if (isset($this->request->get['limit'])) {
                $url .= '&limit=' . $this->request->get['limit'];
            }

            $pagination = new Pagination();
            $pagination->total = $product_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link('page/search', $url . '&page={page}');

            $data['pagination'] = $pagination->render();

            $data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));
        }

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $data['theme_menu'] = $this->load->controller('part/theme_menu');
        if(!empty($data['products'])) {
            $data['layout_product'] = 4;
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/list_product.tpl')) {
                $data['list_product'] = $this->load->view($this->config->get('config_template') . '/template/part/list_product.tpl', $data);
            } else {
                $data['list_product'] = $this->load->view($this->config->get('config_template') . '/template/part/list_product.tpl', $data);
            }
        }
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/tag.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/tag.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/tag.tpl', $data));
        }
    }
    public function seachTag()
    {
        $this->load->language('product/search');

        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $this->load->model('tool/image');

        if (isset($this->request->get['search'])) {
            $search = $this->request->get['search'];
        } else {
            $search = '';
        }
    }
    public function autocomplete(){
        $json = array();
        $this->load->public_model('tag/tag');
        $category=0;
        if (isset($this->request->get['filter_name'])) {
            if(isset($this->request->get['filter_cateogry_id']))
                $category=$this->request->get['filter_cateogry_id'];
            $filter_data = array(
                'filter_name' => $this->request->get['filter_name'],
                'filter_cateogry_id' => $category,
                'sort'        => 'name',
                'order'       => 'ASC',
                'start'       => 0,
                'limit'       => 5
            );
            $results = $this->model_tag_tag->getTages($filter_data);
        }else{
            $results = $this->model_tag_tag->getTagByCategory($this->request->get['filter_cateogry_id']);
        }


        foreach ($results as $result) {
            $json[] = array(
                'tag_id' => $result['tag_id'],
                'name'   => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
                'href'   => $this->url->link('page/category', 'path='.$category.'&tag_id='.$result['tag_id'].'&search=1','SSL')
            );
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