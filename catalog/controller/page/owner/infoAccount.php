<?php
class ControllerPageOwnerInfoAccount extends Controller {
	public function index() {
		$this->load->model('page/owner/register');
		$id = $_SESSION['id_user'];
        $result = $this->model_page_owner_register->get_user_by_id($id);
        if($result){
            $data['user'] = $result;
        }else{
           $this->response->redirect('/dang-nhap-chu-tro'); 
        }
        $data['header'] = $this->load->controller('common/header');
         $data['footer'] = $this->load->controller('common/footer');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/owner/info_account.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/owner/info_account.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/owner/info_account.tpl', $data));
        }
    }
    public function update_account(){
    	$this->load->model('page/owner/register');

        $data = [
            'name'       => $_POST['firstname'],
            'gender'     => $_POST['gender'],
            'birthDay'   => $_POST['day'],
            'birthMonth' =>	$_POST['month'],
            'birthYear'  =>	$_POST['year'],
            'email'      =>	$_POST['email'],
            'image'      =>	$_POST['file'],
            'address'    =>	$_POST['address'],
            'phone'      =>	$_POST['phonenumber'],
        ];
        if(!empty($_POST['password']))
            $data['password'] = md5($_POST['password']);

    	$result = $this->model_page_owner_register->update_account($_SESSION['id_user'],$data);
    	if($result){
            $_SESSION['name'] = $data['name'];
            $_SESSION['img'] = $data['image'];
    		$this->response->redirect('/');
        }
    	die();
    }
}