<?php
/**
 * Created by PhpStorm.
 * User: doanvanquoc
 * Date: 5/19/2017
 * Time: 11:41 PM
 */
class ControllerPartPart extends Controller
{
    public function index($args)
    {
        if(!empty($args['theme'])){
            if(!empty($args['lib_theme'])){
                foreach($args['lib_theme'] as $key=>$item){
                    if($item['type']=='js')
                        $this->document->addScript($item['link']);
                    if($item['type']='css')
                        $this->document->addStyle($item['link']);
                }
            }
            if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/'.$args['load_theme'].'.tpl')) {
                $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/'.$args['load_theme'].'.tpl', $data));
            } else {
                $this->response->setOutput($this->load->view('default/template/'.$args['load_theme'].'tpl', $data));
            }
        }
        else{
            echo "Không load được part sample";
        }
    }
}