<?php
class ControllerPageOwnerInfoAccount extends Controller {
	public function index() {
		$this->load->model('page/owner/register');
		$id = $this->session->data['id_user']['id_owner'];
        $result = $this->model_page_owner_register->get_user_by_id($id);
        if($result){
            $data['user'] = $result;
        }else{
           $this->response->redirect('/dang-nhap-chu-tro'); 
        }
        $data['header'] = $this->load->controller('common/header');
         $data['footer'] = $this->load->controller('common/footer');
      
        $this->response->setOutput($this->load->view('page/owner/info_account.tpl', $data));
        
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

    	$result = $this->model_page_owner_register->update_account($this->session->data['id_user'],$data);
    	if($result){
            $this->session->data['name'] = $data['name'];
            $this->session->data['img'] = $data['image'];
    		$this->response->redirect('/');
        }
    	die();
    }
}