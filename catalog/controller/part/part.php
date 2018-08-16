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
            $this->response->setOutput($this->load->view($args['load_theme'], $data));
        }
        else{
            echo "Không load được part sample";
        }
    }
}