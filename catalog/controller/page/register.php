<?php

class ControllerPageRegister extends Controller {
    public function index() {
        // $this->load->model('page/detail');
        // $data_search = array(
        //     'status'=>1
        // );
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/register.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/register.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/register.tpl', $data));
        }
    }
    public function fb_register(){
        $this->load->model('page/register');
        $config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
        require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
        $hybridauth = new Hybrid_Auth( $config_file_path );
        $adapter  = $hybridauth->authenticate('facebook');
        $user_profile = $adapter->getUserProfile('facebook');
        $user = $this->model_page_register->get_user($user_profile->identifier);
        $_SESSION['id_source'] = $user_profile->identifier;
        if($user != 0 ){
            var_dump('tài khoản đã tồn tại');
        }else{
             $data = [
            'name' => $user_profile->displayName,
            'gender' => $user_profile->gender,
            'age' => $user_profile->age,
            'birthDay' => $user_profile->birthDay,
            'birthMonth'=>$user_profile->birthMonth,
            'birthYear'=>$user_profile->birthYear,
            'email'=>$user_profile->email,
            'image'=>$user_profile->photoURL,
            'country'=>$user_profile->country,
            'address'=>$user_profile->address,
            'phone'=>$user_profile->phone,
            'groupUser'=>1,
            'source'=>'facebook',
            'source_id'=>$user_profile->identifier,
            'password'=>123456,
            'date_add'=>time(),
            'status'=>1,
            ];
            $this->model_page_register->add_user($data);
            $hybridauth->redirect($_COOKIE['origin_ref']);
            $_SESSION['id_source'] = $user_profile->identifier;
        }
        exit();
    }

    public function google_register(){
        $this->load->model('page/register');
        $config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
        require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
        $hybridauth = new Hybrid_Auth( $config_file_path );
        $adapter  = $hybridauth->authenticate('google');
        $user_profile = $adapter->getUserProfile('google');
        $user = $this->model_page_register->get_user($user_profile->identifier);
        if($user != 0 ){
             $hybridauth->redirect($_COOKIE['origin_ref']);
        }else{
             $data = [
            'name' => $user_profile->displayName,
            'gender' => $user_profile->gender,
            'age' => $user_profile->age,
            'birthDay' => $user_profile->birthDay,
            'birthMonth'=>$user_profile->birthMonth,
            'birthYear'=>$user_profile->birthYear,
            'email'=>$user_profile->email,
            'image'=>$user_profile->photoURL,
            'country'=>$user_profile->country,
            'address'=>$user_profile->address,
            'phone'=>$user_profile->phone,
            'groupUser'=>1,
            'source'=>'google',
            'source_id'=>$user_profile->identifier,
            'password'=>123456,
            'date_add'=>time(),
            'status'=>1,
            ];
            $this->model_page_register->add_user($data);
            $hybridauth->redirect($_COOKIE['origin_ref']);
            $_SESSION['id_source'] = $user_profile->identifier;

        }
        exit();
        
    }
    

}