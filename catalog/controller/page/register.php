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
        $user = $this->model_page_register->get_user_by_social($user_profile->identifier);
        if($user != 0 ){
            
        }else{
             $data = [
                'name'       => $user_profile->displayName,
                'gender'     => $user_profile->gender,
                'age'        => $user_profile->age,
                'birthDay'   => $user_profile->birthDay,
                'birthMonth' =>$user_profile->birthMonth,
                'birthYear'  =>$user_profile->birthYear,
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
            $id_user = $this->model_page_register->add_user($data);
            // $hybridauth->redirect($_COOKIE['origin_ref']);
            $_SESSION['source_id'] = $user_profile->identifier;
            $_SESSION['id_user'] = $id_user;
            $_SESSION['phone'] = $user_profile->phone;
            $_SESSION['email'] = $user_profile->email;
            $this->response->redirect('/cap-nhap-thong-tin');

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
        $user = $this->model_page_register->get_user_by_social($user_profile->identifier);
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
            'password'=>'',
            'date_add'=>time(),
            'status'=>1,
            ];
            $this->model_page_register->add_user($data);
            //$hybridauth->redirect($_COOKIE['origin_ref']);
            $_SESSION['source_id'] = $user_profile->identifier;
            $_SESSION['id_user'] = $id_user;
            $_SESSION['phone'] = $user_profile->phone;
            $_SESSION['email'] = $user_profile->email;
            $this->response->redirect('/cap-nhap-thong-tin');

        }
        exit();
        
    }

    public function form_register(){
         $this->load->model('page/register');
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
            $id_user = $this->model_page_register->add_user($data);
            $_SESSION['id_user'] = $id_user;
            //$this->response->redirect($_COOKIE['origin_ref']);
            $this->response->redirect('/tim-kiem-phong-tro');


    }
    
    public function update_info(){
        $data['header'] = $this->load->controller('common/header');
        $data['phone'] = $_SESSION['phone'];
        $data['email'] = $_SESSION['email'];

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/update_info.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/update_info.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/update_info.tpl', $data));
        }
    }
    public function submit_register(){
        $this->load->model('page/register');
        $id_source = $_SESSION['id_source'];

        $data = [
            'phone'    => isset($_POST['phone'])?$_POST['phone']:'',
            'email'    => isset($_POST['email'])?$_POST['email']:'',
            'password' => isset($_POST['password'])?md5($_POST['password']):'',
        ];

        $result = $this->model_page_register->update_info($id_source,$data);
        if($result)
            $this->response->redirect('/tim-kiem-phong-tro');
        else
            var_dump('xảy ra lỗi thử lại');
        die();
    }
    public function check_phone(){
        $this->load->model('page/register');
        $phone = $_POST['phone'];
        $result = $this->model_page_register->get_phone($phone);
        if($result != 0){
            echo 'exist';
        }
        exit();
    }
}