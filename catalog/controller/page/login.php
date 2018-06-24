<?php

class ControllerPageLogin extends Controller {
    public function index() {
        // $this->load->model('page/detail');
        // $data_search = array(
        //     'status'=>1
        // );
         $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/login.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/login.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/login.tpl', $data));
        }
    }
    public function fb_login(){

        $config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
        require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
        $hybridauth = new Hybrid_Auth( $config_file_path );
        $adapter  = $hybridauth->authenticate('facebook');
        $user_profile = $adapter->getUserProfile();
        if(!$hybridauth->isConnectedWith()){
            var_dump('da login');

        }else{
            var_dump('chua login');

        }
        exit();
    }

    public function google_login(){

        $config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
        require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
        $hybridauth = new Hybrid_Auth( $config_file_path );
        $adapter  = $hybridauth->authenticate('google');
        $user_profile = $adapter->getUserProfile();
        if(!$hybridauth->isConnectedWith()){
            var_dump('da login');

        }else{
            var_dump('chua login');

        }
        exit();
    }
}