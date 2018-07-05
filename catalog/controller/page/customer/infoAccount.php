<?php
class ControllerPageCustomerInfoAccount extends Controller {
	public function index() {
		$this->load->model('page/customer/register');
		$id = $_SESSION['id_user'];
        $result = $this->model_page_customer_register->get_user_by_id($id);
        if($result){
            $data['user'] = $result;
        }else{
           $this->response->redirect('/thong-tin-chu-tro'); 
        }
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/customer/info_account.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/customer/info_account.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/customer/info_account.tpl', $data));
        }
    }
    public function update_account(){
    	$this->load->model('page/customer/register');
    	 $data = [
            'name'       => $_POST['firstname'],
            'gender'     => $_POST['gender'],
            'birthDay'   => $_POST['day'],
            'birthMonth' => $_POST['month'],
            'birthYear'  => $_POST['year'],
            'email'      => $_POST['email'],
            'image'      => $_POST['file'],
            'address'    => $_POST['address'],
            'phone'      => $_POST['phonenumber'],
        ];
        if(!empty($_POST['password']))
            $data['password'] = md5($_POST['password']);

        $result = $this->model_page_customer_register->update_account($_SESSION['id_user'],$data);
        if($result){
            $_SESSION['name'] = $data['name'];
            $_SESSION['img'] = $data['image'];
            $this->response->redirect('/tim-kiem-phong-tro');
        }
        die();
    }
}