<?php
require_once( "vendor/recaptchalib.php" );
class ControllerPageOwnerLogin extends Controller {
    public function index() {
        // $this->load->model('page/detail');
        // $data_search = array(
        //     'status'=>1
        // );
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/owner/login.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/owner/login.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/owner/login.tpl', $data));
        }
    }
    public function fb_login(){
        $this->load->model('page/owner/register');
        $config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
        require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
        $hybridauth = new Hybrid_Auth( $config_file_path );
        $adapter  = $hybridauth->authenticate('facebook');
        $user_profile = $adapter->getUserProfile('facebook');
        $user = $this->model_page_owner_register->get_user_by_social($user_profile->identifier);
        if($user != 0 ){
            $_SESSION['source_id'] = $user_profile->identifier;
            $_SESSION['id_user'] = $user['_id'];
            $_SESSION['name'] = $user['name'];
            $_SESSION['img'] = $user['image'];
            $this->response->redirect('/tim-kiem-phong-tro');
        }
        exit();
    }

    public function google_login(){
        $this->load->model('page/owner/register');
        $config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
        require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
        $hybridauth = new Hybrid_Auth( $config_file_path );
        $adapter  = $hybridauth->authenticate('google');
        $user_profile = $adapter->getUserProfile('google');
        $user = $this->model_page_owner_register->get_user_by_social($user_profile->identifier);
        if($user != 0 ){
            $_SESSION['source_id'] = $user_profile->identifier;
            $_SESSION['id_user'] = $user['_id'];
            $_SESSION['name'] = $user['name'];
            $_SESSION['img'] = $user['image'];
            $hybridauth->redirect('/tim-kiem-phong-tro');
        }
        exit();
    }
    public function form_login(){
        $this->load->model('page/owner/login');
        $this->load->model('page/owner/register');

        $secret = "6LfgN2EUAAAAAHIlpYTJjHz7zIvFMtR7WaAB_c_m";
        $response = null;

        $reCaptcha = new ReCaptcha($secret);
        // if submitted check response

        if ($_POST["g-recaptcha-response"]) {
            $response = $reCaptcha->verifyResponse(
                $_SERVER["REMOTE_ADDR"],
                $_POST["g-recaptcha-response"]
            );
        }
        if($response != null && $response->success) {
            $data = [
                'phone' =>$_POST['sdt'],
                'password'=>md5($_POST['password']),
            ];
            $result = $this->model_page_owner_login->login_form($data);
            if($result){
                $user = $this->model_page_owner_register->get_user_by_id($result['_id']);
                $_SESSION['id_user'] = $result['_id'];
                $_SESSION['name'] = $user['name'];
                $_SESSION['img'] = $user['image'];
                echo 1; //account math
            }
            else{
                echo 0; // account not exist
            }
        }else{
            echo 2; // capcha not check
        }
       
        exit();

    }
    
}