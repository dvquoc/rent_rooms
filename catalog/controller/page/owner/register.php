<?php
require_once( "vendor/recaptchalib.php" );

class ControllerPageOwnerRegister extends Controller {
    public function index() {
        $data['error_warning'] = '';
        if(isset($this->session->data['error_warning'])){
            $data['error_warning']=$this->session->data['error_warning'];
            unset($this->session->data['error_warning']);
        }

        if(isset($this->session->data['id_user']) || isset($this->session->data['source_id'])){
            $this->response->redirect('/thong-tin-chu-tro');
        }
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/owner/register.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/owner/register.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/owner/register.tpl', $data));
        }
    }
    public function fb_register(){
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
             $data = [
                'name'       =>$user_profile->displayName,
                'gender'     =>$user_profile->gender,
                'age'        =>(int)$user_profile->age,
                'birthDay'   =>(int)$user_profile->birthDay,
                'birthMonth' =>(int)$user_profile->birthMonth,
                'birthYear'  =>(int)$user_profile->birthYear, 
                'email'      =>$user_profile->email,
                'image'      =>$user_profile->photoURL,
                'country'    =>$user_profile->country,
                'address'    =>$user_profile->address,
                'phone'      =>$user_profile->phone,
                'groupUser'  =>1,
                'source'     =>'facebook',
                'source_id'  =>$user_profile->identifier,
                'password'   =>'',
                'date_add'   =>time(),
                'status'     =>1,
            ];
            if(!empty($user_profile->phone)){
                $id_user = $this->model_page_owner_register->add_user($data);
                $this->session->data['source_id'] = $id_source;
                $this->session->data['id_user']['id_owner'] = $id_user;
                $this->session->data['name'] = $data['name'];
                $this->session->data['img'] = $data['image'];
                 $this->response->redirect('/quan-ly-phong-tro');
            }else{
                $this->session->data['user_profile'] = $data;
                $this->response->redirect('/cap-nhap-thong-tin-chu-phong');
            }

        }
        exit();
    }

    public function google_register(){
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
             $data = [
            'name'       => $user_profile->displayName,
            'gender'     => $user_profile->gender,
            'age'        =>(int) $user_profile->age,
            'birthDay'   =>(int)$user_profile->birthDay,
            'birthMonth' =>(int)$user_profile->birthMonth,
            'birthYear'  =>(int)$user_profile->birthYear,
            'email'      =>$user_profile->email,
            'image'      =>$user_profile->photoURL,
            'country'    =>$user_profile->country,
            'address'    =>$user_profile->address,
            'phone'      =>$user_profile->phone,
            'groupUser'  =>1,
            'source'     =>'google',
            'source_id'  =>$user_profile->identifier,
            'password'   =>'',
            'date_add'   =>time(),
            'status'     =>1,
            ];
            if(!empty($user_profile->phone)){
                $id_user = $this->model_page_owner_register->add_user($data);
                $this->session->data['source_id'] = $id_source;
                $this->session->data['id_user'] = $id_user;
                $this->session->data['name'] = $data['name'];
                $this->session->data['img'] = $data['image'];
                 $this->response->redirect('/quan-ly-phong-tro');
            }else{
                $this->session->data['user_profile'] = $data;
                $this->response->redirect('/cap-nhap-thong-tin-chu-phong');
            }

        }
        exit();
        
    }

    public function form_register(){
        $this->load->model('page/owner/register');

        // your secret key
        $secret = "6LfgN2EUAAAAAHIlpYTJjHz7zIvFMtR7WaAB_c_m";
         
        // empty response
        $response = null;
         
        // check secret key
        $reCaptcha = new ReCaptcha($secret);
        // if submitted check response
        if ($_POST["g-recaptcha-response"]) {
            $response = $reCaptcha->verifyResponse(
                $_SERVER["REMOTE_ADDR"],
                $_POST["g-recaptcha-response"]
            );
        }
        if ($response != null && $response->success) {
             $data = [
                'name'       =>$_POST['firstname'],
                'gender'     =>'',
                'age'        =>'',
                'birthDay'   =>'',
                'birthMonth' =>'',
                'birthYear'  =>'',
                'email'      =>$_POST['email'],
                'image'      =>'',
                'country'    =>'',
                'address'    =>'',
                'phone'      =>$_POST['phone'],
                'groupUser'  =>1,
                'source'     =>'',
                'source_id'  =>'',
                'password'   =>md5($_POST['password']),
                'date_add'   =>time(),
                'status'     =>1,
            ];
            $id_user = $this->model_page_owner_register->add_user($data);
            $this->session->data['id_user']['id_owner'] = $id_user;
            $this->session->data['name'] = $data['name']; 
            $this->session->data['img'] = '';
             $this->response->redirect('/quan-ly-phong-tro');
        }else{
            echo 'capcha';
        }
        exit();
    }
    
    public function update_info(){
        $data['header'] = $this->load->controller('common/header');
      
        $data['phone'] = $this->session->data['user_profile']['phone'];


        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/owner/update_info.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/owner/update_info.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/owner/update_info.tpl', $data));
        }
    }
    public function submit_register(){
        $this->load->model('page/owner/register');
        $id_source = $this->session->data['user_profile']['id_source'];
      
        $this->session->data['user_profile']['phone'] = $_POST['phone'];

        $id_user = $this->model_page_owner_register->add_user($this->session->data['user_profile']);
        if($id_user){
            $this->session->data['source_id'] = $id_source;
            $this->session->data['id_user']['id_owner'] = $id_user;
            $this->session->data['name'] = $this->session->data['user_profile']['name'];
            $this->session->data['img'] = $this->session->data['user_profile']['image'];
            unset($this->session->data['user_profile']);
             $this->response->redirect('/quan-ly-phong-tro');
        }
     
    }

    public function check_phone(){
        $this->load->model('page/owner/register');
        $phone = $_POST['phone'];
        $result = $this->model_page_owner_register->get_phone($phone);
        if($result != 0){
            echo 'exist';
        }
        exit();
    }

  
}