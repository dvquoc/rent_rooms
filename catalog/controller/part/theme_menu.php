<?php
class ControllerPartThememenu extends Controller {
    public function index() {
        /* Nếu có nghiêp vụ thì làm tại đây*/
        $data=array();
        $data['link_category_comp']= $this->url->link('page/category', '&path=59','SSL');
        $data['link_category_shop']= $this->url->link('page/category', '&path=60','SSL');
        $data['link_category_estate']= $this->url->link('page/category', '&path=66','SSL');
        $data['link_category_laddingpage']= $this->url->link('page/category','&path=62','SSL');
        $data['link_category_all']= $this->url->link('page/category','&path=0','SSL');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/part/theme_menu.tpl')) {
            return $this->load->view($this->config->get('config_template') . '/template/part/theme_menu.tpl', $data);
        } else {
            return $this->load->view('default/template/part/theme_menu.tpl', $data);
        }
    }
}