<?php
require_once( "vendor/recaptchalib.php" );
class ControllerPageOwnerLogin extends Controller {
    public function index() {
        $data['error_warning'] = '';
        if(isset($this->session->data['error_warning'])){
            $data['error_warning']=$this->session->data['error_warning'];
            unset($this->session->data['error_warning']);
        }
        if(isset($this->session->data['id_user']) || isset($this->session->data['source_id'])){
            $this->response->redirect('/thong-tin-chu-tro');
        }
        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
       
        $this->response->setOutput($this->load->view('page/owner/login', $data));
        
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
            $this->session->data['source_id'] = $user_profile->identifier;
            $this->session->data['id_user']['id_owner'] = $user['_id'];
            $this->session->data['name'] = $user['name'];
            $this->session->data['img'] = $user['image']; 
            $this->response->redirect('/quan-ly-phong-tro');
        }else{
            $this->session->data['error_warning'] = 'Bạn chưa có tài khoản vui lòng đăng ký';
            $this->response->redirect('/dang-ky-chu-phong');
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
            $this->session->data['source_id'] = $user_profile->identifier;
            $this->session->data['id_user']['id_owner'] = $user['_id'];
            $this->session->data['name'] = $user['name'];
            $this->session->data['img'] = $user['image'];
            $this->response->redirect('/quan-ly-phong-tro');
        }else{
            $this->session->data['error_warning'] = 'Bạn chưa có tài khoản vui lòng đăng ký';
            $this->response->redirect('/dang-ky-chu-phong');
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
                $this->session->data['id_user']['id_owner'] = $result['_id'];
                $this->session->data['name'] = $user['name'];
                $this->session->data['img'] = $user['image'];
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