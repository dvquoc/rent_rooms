<?php
class ControllerModuleInformationType extends Controller {
    private $_object=NULL;
    public function getInfoObject($type){
        $this->_object=$this->objects->get($type);
    }
	public function index($setting) {
        $this->getInfoObject($setting['type']);

        $this->load->model('catalog/information');

        $request_category=isset($this->_object['alias_url']['category']) ? $this->_object['alias_url']['category']['request_id']: false;
        $router_category=isset($this->_object['alias_url']['category']['router_page']) ? $this->_object['alias_url']['category']['router_page'] : false;

        $request_type=isset($this->_object['alias_url']['type']) ? $this->_object['alias_url']['type']['request_id']:false;
        $router_type=isset($this->_object['alias_url']['type']) ? $this->_object['alias_url']['type']['router_page'] : false;

        $request_information=$this->_object['alias_url']['information']['request_id'];
        $router_detail=$this->_object['alias_url']['information']['router_page'];
        if(empty($setting['information_list'])) {
            $data_filter = array(
                'filter_category_id' => $setting['category'],
                'filter_information_type' => $setting['type'],
                'limit' => $setting['limit'],
                'start' => 0,
            );
            $list_informations = $this->model_catalog_information->getInformations($data_filter);
        }else{
            $list_informations = $this->model_catalog_information->getInformationByListId($setting['information_list']);
        }

        $data['title'] =$setting['name'];
        $data['des'] =$setting['description'];
        $limit_des =!empty($setting['limit_des']) ? $setting['limit_des'] : $this->config->get('config_product_description_length');
        $data['show_type'] = $setting['show_type'];
        $data['slider'] = $setting['slider'];
        $data['prefix_module'] = $setting['prefix_module'];
        $data['show_category_link'] = 0;
        if(isset($setting['show_category_link']) && $setting['show_category_link']){
            $data['show_category_link'] = $setting['show_category_link'];
            if($setting['category']!=0)
                $data['category_link'] = $this->url->link($router_category, $request_type.'='.$setting['type'].'&'.$request_category ."=". $setting['category']);
            else
                $data['category_link'] = $this->url->link($router_type,$request_type.'='.$setting['type']);
        }


        $data['informations'] =array();
        if(!empty($list_informations)) {
            $this->load->model('tool/image');
            foreach ($list_informations as $key => $result) {
                if($setting['show_type']== 'news') {
                    if($key==0){
                        $width = 500;
                        $height = 350;
                    }else{
                        $width = $this->config->get('config_image_additional_width');
                        $height = $this->config->get('config_image_additional_height');
                    }
                }else if($setting['show_type']== 'news_feature'){
                    if($key==0){
                        $width = 560;
                        $height = 320;
                    }else{
                        $width = 220;
                        $height = 110;
                    }
                }elseif($setting['show_type']== 'question'){
                    $width = 365;
                    $height = 205;
                }else{
                    $width = 360;
                    $height = 258;
                }
                $image = $this->model_tool_image->resize($result['image'], $width, $height,'a');
                $category ="";
                if(!empty($result['category_id']) && isset($this->_object['alias_url']['category']))
                    $category = "&".$request_category.'='.$result['category_id'];
                $data['informations'][$key] =array (
                    'information_id'  => $result['information_id'],
                    'thumb'       => $image,
                    'name'        => $result['title'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $limit_des) . '...',
                    'href'        => $this->url->link($router_type,$request_type."=".$setting['type'].$category.'&'.$request_information.'='. $result['information_id']),
                );
                if(isset($this->_object['meta_array'])) {
                    $information_meta = $this->model_catalog_information->getInformationMeta($result['information_id']);
                    $data['informations'][$key]['meta_data'] = $information_meta;
                }
            }
        }


        $data['col'] = 3;
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/information_type/'.$setting['show_type'].'_content.tpl')) {
            $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/module/information_type/'.$setting['show_type'].'_content.tpl', $data);
        } else {
            $data['list_information'] = $this->load->view($this->config->get('config_template') . '/template/module/information_type/'.$setting['show_type'].'_content.tpl', $data);
        }

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/information_type.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/module/information_type.tpl', $data);
        } else {
            return $this->load->view('default/template/module/information_type.tpl', $data);
        }
	}
}