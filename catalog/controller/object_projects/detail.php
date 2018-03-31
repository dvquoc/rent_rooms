<?php
class ControllerObjectProjectsDetail extends Controller {
    public function index() {
        $this->load->language('common/information_type');
        $this->load->language('information/information');
        $this->load->model('catalog/information');
        $this->load->model('catalog/category');
        $this->load->model('tool/image');

        $this->document->addScript("/public/assets/plugins/fancybox/jquery.fancybox.min.js");
        $this->document->addScript("/public/assets/plugins/photoswipe/photoswipe-ui-default.min.js");
        $this->document->addScript("/public/assets/plugins/photoswipe/photoswipe.js");
        $this->document->addScript("/public/assets/pages/projects/projects_detail.js");
        $this->document->addStyle("/public/assets/plugins/photoswipe/photoswipe.css");
        $this->document->addStyle("/public/assets/plugins/photoswipe/default-skin/default-skin.css");
        $this->document->addStyle("/public/assets/plugins/fancybox/jquery.fancybox.min.css");
        $this->document->addStyle("/public/assets/css/detail_project.css");

        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $request_category=$this->object_current['alias_url']['category']['request_id'];
        $router_category=$this->object_current['alias_url']['category']['router_page'];

        $request_type=$this->object_current['alias_url']['type']['request_id'];
        $router_type=$this->object_current['alias_url']['type']['router_page'];

        $request_information=$this->object_current['alias_url']['information']['request_id'];
        $router_information=$this->object_current['alias_url']['information']['router_page'];


        if (isset($this->request->get[$request_information])) {
            $information_id = (int)$this->request->get[$request_information];
        } else {
            $information_id = 0;
        }
        $information = $this->model_catalog_information->getInformation($information_id);
        if ($information) {
            $this->document->setTitle($information['meta_title']);
            $this->document->setDescription($information['meta_description']);
            $this->document->setKeywords($information['meta_keyword']);

            if (isset($this->request->get[$request_category])) {
                $parts = explode('_', (string)$this->request->get[$request_category]);
                $category_id = (int)array_pop($parts);
            }elseif(!empty($information['category_id'])){
                $category_id = (int)$information['category_id'];
            } else {
                $category_id = 0;
            }

            $category_info = $this->model_catalog_category->getCategory($category_id);

            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_'.$this->objects->object_type),
                'href' => $this->url->link($router_type, $request_type. "=" . $this->objects->object_type)
            );

            if($category_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link($router_category, $request_type. "=" . $this->objects->object_type."&".$request_category. "=" . $category_info['category_id'])
                );
                $data['breadcrumbs'][] = array(
                    'text' => $information['title'],
                    'href' => $this->url->link($router_information, $request_type. "=" . $this->objects->object_type.'&'.$request_category. "=" . $category_info['category_id'].'&'.$request_information.'=' .  $information_id)
                );
            }else{
                $data['breadcrumbs'][] = array(
                    'text' => $information['title'],
                    'href' => $this->url->link($router_information, $request_type. "=" . $this->objects->object_type.'&'.$request_information.'=' .  $information_id)
                );
            }

            $data['link_detail'] = end($data['breadcrumbs'])['href'];


            $data['heading_title'] = $information['title'];

            $data['button_continue'] = $this->language->get('button_continue');

            $data['meta_data']=array();
            if(isset($this->object_current['meta_array'])) {
                $information_meta = $this->model_catalog_information->getInformationMeta($information_id);
                $data['meta_data'] = $information_meta;
            }
            $data['information_images'] = array();
            $data['information_full_images'] = array();
            $list_images  =  unserialize($information['information_images']);
            if(!empty($list_images)) {
                foreach ($list_images as $image){
                    $data['information_images'][] = $this->model_tool_image->resize($image, 370, 210,'a');
                    $data['information_full_images'][] = $this->model_tool_image->resize($image);
                }
            }

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
            if(!empty($data['meta_data']) && (isset($data['meta_data']['_project_news_relatevie']) && !empty($data['meta_data']['_project_news_relatevie']))) {
                $results = $this->model_catalog_information->getInformationByListId(unserialize($data['meta_data']['_project_news_relatevie']));
                $data_relative['informations'] =array();
                foreach ($results as $key=>$result) {
                    if ($result['image']) {
                        $image = $this->model_tool_image->resize($result['image'],360, 258,'a');
                    } else {
                        $image = $this->model_tool_image->resize('placeholder.png', 360, 258,'a');
                    }
                    $data_relative['informations'][] = array(
                        'information_id'  => $result['information_id'],
                        'thumb'       => $image,
                        'name'        => $result['title'],
                        'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 200) . '..',
                        'href'        => $this->url->link($router_information, $request_type.'='.$this->objects->object_type.'&'.$request_category.'='.$category_info['category_id'].'&'.$request_information.'='. $result['information_id']),
                    );
                    if(isset($this->object_current['meta_array'])) {
                        $information_meta = $this->model_catalog_information->getInformationMeta($result['information_id']);
                        $data_relative['informations'][$key]['meta_data'] = $information_meta;
                    }
                }

                $data_relative['col'] = 3;

                if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/relative/relative.tpl')) {
                    $data['relative_news'] = $this->load->view($this->config->get('config_template') . '/template/part/relative/relative.tpl', $data_relative);
                } else {
                    $data['relative_news'] = $this->load->view('default/template/part/relative/relative.tpl', $data_relative);
                }
            }
            $data['relative'] = $this->load->controller('part/relative',array('information_id'=>$information_id, 'category_id'=>$category_id,'information_type'=>$this->objects->object_type));
            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/'.$router_information.'.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/'.$router_information.'.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/'.$router_information.'.tpl', $data));
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