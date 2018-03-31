<?php
class ControllerObjectTypeDetail extends Controller {
    private $_object=NULL;
    public function getInfoObject(){
        $this->_object=$this->objects->get($this->objects->object_type);
    }
    public function index() {
        $this->getInfoObject();
        $this->load->language('information/information');
        $this->load->model('catalog/information');
        $this->load->model('catalog/category');
        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $text_request_category=$this->_object['alias_url']['category']['request_id'];
        $router_page_category=$this->_object['alias_url']['category']['router_page'];

        $text_request_information=$this->_object['alias_url']['information']['request_id'];
        $router_page_detail=$this->_object['alias_url']['information']['router_page'];

        if (isset($this->request->get[$text_request_information])) {
            $information_id = (int)$this->request->get[$text_request_information];
        } else {
            $information_id = 0;
        }
        $information = $this->model_catalog_information->getInformation($information_id);

        if ($information) {
            $this->document->setTitle($information['meta_title']);
            $this->document->setDescription($information['meta_description']);
            $this->document->setKeywords($information['meta_keyword']);

            if (isset($this->request->get[$text_request_category])) {
                $parts = explode('_', (string)$this->request->get[$text_request_category]);
                $category_id = (int)array_pop($parts);
            } else {
                $category_id = 0;
            }
            $category_info = $this->model_catalog_category->getCategory($category_id);
            if($category_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link($router_page_category, $text_request_category . "=" . $category_info['category_id'])
                );
                $data['breadcrumbs'][] = array(
                    'text' => $information['title'],
                    'href' => $this->url->link($router_page_category, $text_request_category . "=" . $category_info['category_id'].'&'.$text_request_information.'=' .  $information_id)
                );
            }else{
                $data['breadcrumbs'][] = array(
                    'text' => $information['title'],
                    'href' => $this->url->link($router_page_category, $text_request_information.'=' .  $information_id)
                );
            }

            $data['heading_title'] = $information['title'];

            $data['button_continue'] = $this->language->get('button_continue');

            $data['description'] = html_entity_decode($information['description'], ENT_QUOTES, 'UTF-8');
            preg_match("/\<code\>\[module code=\'(.*?)\'\](\d+)\[\/module\]\<\/code\>/", $data['description'],$module);
            if (isset($module[1])) {
                $this->load->model('extension/module');
                $setting_info = $this->model_extension_module->getModule($module[2]);
                $html_module = $this->load->controller('module/'.$module[1], $setting_info);
               $data['description'] = str_replace("<code>[module code='".$module[1]."']".$module[2]."[/module]</code>", $html_module, $data['description']);
            }

            $data['information_tags']=array();
            if($information['information_tags']){
                $data['prefix_tag']=$this->config->get('tag');
                $tages = unserialize($information['information_tags']);
                $this->load->public_model('tag/tag');
                foreach ($tages as $tag) {
                    $tag_id=str_replace($data['prefix_tag']['prefix_alias'],'',$tag);
                    $tag_info = $this->model_tag_tag->getTag($tag_id);
                    if ($tag_info) {
                        $data['information_tags'][] = array(
                            'tag_id' => $tag_info['tag_id'],
                            'name' => $tag_info['name'],
                            'href' => $this->url->link('page/search', 'tag_id=' . $tag_info['tag_id'])
                        );
                    }
                }
            }

            $data['continue'] = $this->url->link('common/home');

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/'.$router_page_detail.'.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/'.$router_page_detail.'.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/'.$router_page_detail.'.tpl', $data));
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
}