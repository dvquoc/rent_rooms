<?php
/**
 * Created by PhpStorm.
 * User: doanvanquoc
 * Date: 5/19/2017
 * Time: 11:41 PM
 */
class ControllerPartRelative extends Controller
{
    public function index($setting= array())
    {
        if(isset($setting['information_id']) && $setting['information_id'] > 0){
            $this->load->model("catalog/information");
            $this->load->model("tool/image");

            $request_category=$this->object_current['alias_url']['category']['request_id'];
            $router_category=$this->object_current['alias_url']['category']['router_page'];

            $request_type=$this->object_current['alias_url']['type']['request_id'];
            $router_type=$this->object_current['alias_url']['type']['router_page'];

            $request_information=$this->object_current['alias_url']['information']['request_id'];
            $router_information=$this->object_current['alias_url']['information']['router_page'];
            $category_id = $setting['category_id'] ? $setting['category_id']: 0;
            $data_filter = array(
                'filter_category_id' =>$category_id,
                'filter_information_type' =>$setting['information_type'] ? $setting['information_type']: 'default',
                'exclude' =>$setting['information_id'],
                'start' =>0,
                'limit' =>3
            );
            $results = $this->model_catalog_information->getInformations($data_filter);
            $data['informations'] =array();
           if(!empty($results)){
               foreach ($results as $key => $result) {
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
                       'href' => $this->url->link($router_type, $request_type . '=' . $this->objects->object_type . '&' . $request_category . '=' . $category_id . '&' . $request_information . '=' . $result['information_id']),
                   );
               }
           }else{
               return false;
           }
            $theme = 'relative';
            if(isset($setting['theme']))
                $theme = $setting['theme'];
            $data['col'] = 3;
            return $this->load->view('part/relative/'.$theme, $data);
        }
        else{
            return  "<div class='alert alert-danger'>Không load được part sample</div>";
        }
    }
}