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

        return $this->load->view('part/theme_menu', $data);
    }
}