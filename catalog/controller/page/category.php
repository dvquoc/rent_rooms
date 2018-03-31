<?php
class ControllerPageCategory extends Controller {
    public function index() {
        $this->document->setTitle("Vline-Com");
        $this->document->setDescription($this->config->get('config_meta_description'));
        $this->document->setKeywords($this->config->get('config_meta_keyword'));
        if (isset($this->request->get['route'])) {
            $this->document->addLink(HTTP_SERVER, 'canonical');
        }

        $this->load->model('catalog/category');

        $this->load->model('catalog/category');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        if (isset($this->request->get['filter'])) {
            $filter = $this->request->get['filter'];
        } else {
            $filter = '';
        }

        if (isset($this->request->get['sort'])) {
            $sort = $this->request->get['sort'];
        } else {
            $sort = 'p.sort_order';
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

        if (isset($this->request->get['tag_id'])) {
            $tag_id = $this->request->get['tag_id'];
        } else {
            $tag_id = 0;
        }

        if (isset($this->request->get['price_filter'])) {
            $price_filter = $this->request->get['price_filter'];
        } else {
            $price_filter = 1;
        }

        if (isset($this->request->get['search']) && isset($this->request->get['tag_id'])) {
            $this->load->public_model('tag/tag');
            $this->model_tag_tag->addView($this->request->get['tag_id']);
        }

        if (isset($this->request->get['path'])) {
            $path = '';
            $parts = explode('_', (string)$this->request->get['path']);
            $category_id = (int)array_pop($parts);
        } else {
            $category_id = 0;
        }
        $category_info = $this->model_catalog_category->getCategory($category_id);


        if ($category_info || $category_id==0) {
            //var_dump($category_info);
            if($category_id!=0) {
                $data['name'] = $category_info['name'];
                $this->document->setTitle($category_info['name']);
                $this->document->setDescription($category_info['meta_description']);
                $this->document->setKeywords($category_info['meta_keyword']);
            }else if($category_id==0 && isset($this->request->get['price_filter']) && $this->request->get['price_filter']==0){
                $data['name'] = 'Miễn phí';
                $this->document->setTitle('Tất cả mẫu website miễn phí');
                $this->document->setDescription('Website miễn phí vẫn đẹp, thiết kế chuyên nghiệp');
                $this->document->setKeywords('miễn phí');
                $category_info['category_id']=0;
            }else if($category_id==0 && isset($this->request->get['price_filter']) && $this->request->get['price_filter']==1){
                $category_info['category_id']=0;
                $data['name'] = 'Tất cả mẫu có phí';
                $this->document->setTitle('Tất cả mẫu website có phí');
                $this->document->setDescription('thiết kế chuyên nghiệp');
                $this->document->setKeywords('chuyên nghiệp');
                $category_info['category_id']=0;
            }else{
                $category_info['category_id']=0;
                $data['name'] = '';
                $this->document->setTitle('Tất cả mẫu');
                $this->document->setDescription('thiết kế chuyên nghiệp');
                $this->document->setKeywords('chuyên nghiệp');
                $category_info['category_id']=0;
            }
            $data['url'] = array();
            $url_string = '';
            if (isset($this->request->get['filter'])) {
                $data['url']['filter'] = $this->request->get['filter'];
            }

            if (isset($this->request->get['path'])) {
                $data['url']['path'] =  $this->request->get['path'];
            }

            if (isset($this->request->get['tag_id'])) {
                $data['url']['tag_id'] =  $this->request->get['tag_id'];
            }

            if (isset($this->request->get['price_filter'])) {
                $data['url']['price_filter'] = $this->request->get['price_filter'];
            }

            $url_filter=$data['url'];
            if(isset($url_filter['price_filter']))
                unset($url_filter['price_filter']);
            $url_string='&'.http_build_query($url_filter);
            $data['link_free']=$this->url->link('page/category',$url_string."&price_filter=0",'SSL');
            $data['link_buy']=$this->url->link('page/category',$url_string."&price_filter=1",'SSL');

            $url_filter=$data['url'];
            if(isset($url_filter['tag_id']))
                unset($url_filter['tag_id']);
            $url_string='&'.http_build_query($url_filter);
            $this->load->public_model('tag/tag');
            $tages=$this->model_tag_tag->getTagByCategory($category_info['category_id']);
            if(!empty($tages)){
                foreach($tages as $tag) {
                    $data['tages'][] = array(
                        'tag_id'=>$tag['tag_id'],
                        'name'=>$tag['name'],
                        'href'=>$this->url->link('page/category',$url_string.'&tag_id=' . $tag['tag_id'],'SSL')
                    );
                }
            }

            $data['products'] = array();
            $filter_data = array(
                'filter_category_id' => $category_info['category_id'],
                'filter_filter'      => $filter,
                'tag_id'             => $tag_id,
                'price_filter'       => $price_filter,
                'sort'               => $sort,
                'order'              => $order,
                'start'              => ($page - 1) * $limit,
                'limit'              => $limit
            );
            $product_total = $this->model_catalog_product->getTotalProducts($filter_data);
            $results = $this->model_catalog_product->getProducts($filter_data);
            foreach ($results as $result) {
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
                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price']);
                } else {
                    $tax = false;
                }
                if ($this->config->get('config_review_status')) {
                    $rating = (int)$result['rating'];
                } else {
                    $rating = false;
                }
                $data['products'][] = array(
                    'product_id'  => $result['product_id'],
                    'thumb'       => $image,
                    'name'        => $result['name'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('config_product_description_length')) . '..',
                    'price'       => $price,
                    'special'     => $special,
                    'tax'         => $tax,
                    'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating'      => $result['rating'],
                    'href'        => $this->url->link('page/details','path=' . $category_info['category_id'].'&product_id=' . $result['product_id']),
                    'link_view'   => $this->url->link('page/viewdemo','product_id='.$result['product_id'].'&code=' . $result['model'])
                );
            }

            $url_string='&'.http_build_query($data['url']);
            $pagination = new Pagination();
            $pagination->total = $product_total;
            $pagination->page = $page;
            $pagination->limit = $limit;
            $pagination->url = $this->url->link('page/category', $url_string . '&page={page}');
            $data['pagination'] = $pagination->render();
            $data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

            $data['sort'] = $sort;
            $data['order'] = $order;
            $data['limit'] = $limit;
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            $data['search'] = $this->load->controller('common/search');
            $data['theme_menu'] = $this->load->controller('part/theme_menu');
            $data['layout_product']=4;
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/list_product.tpl')) {
                $data['list_product'] = $this->load->view($this->config->get('config_template') . '/template/part/list_product.tpl',$data );
            } else {
                $data['list_product'] = $this->load->view($this->config->get('config_template') . '/template/part/list_product.tpl', $data);
            }
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/category.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/category.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/page/category.tpl', $data));
            }
        } else {
            $url = '';

            if (isset($this->request->get['path'])) {
                $url .= '&path=' . $this->request->get['path'];
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
}