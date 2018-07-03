<?php
class ControllerPageInfoAccount extends Controller {
	public function index() {
		$this->load->model('page/register');
		$id = $_SESSION['id_user'];
		$data['user']= $this->model_page_register->get_user_by_id($id);
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/page/info_account.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/page/info_account.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/page/info_account.tpl', $data));
        }
    }
    public function update_account(){
    	$this->load->model('page/register');
    	 $data = [
                'name'       => isset($_POST['firstname'])?$_POST['firstname']:'',
                'gender'     => isset($_POST['gender'])?$_POST['gender']:'',
                'birthDay'   => isset($_POST['day'])?$_POST['day']:'',
                'birthMonth' =>	isset($_POST['month'])?$_POST['month']:'',
                'birthYear'  =>	isset($_POST['year'])?$_POST['year']:'',
                'email'      =>	isset($_POST['email'])?$_POST['email']:'',
                'image'      =>	isset($_POST['file'])?$_POST['file']:'',
                'address'    =>	isset($_POST['address'])?$_POST['address']:'',
                'phone'      =>	isset($_POST['phonenumber'])?$_POST['phonenumber']:'',
            ];
    	$result = $this->model_page_register->update_account($_SESSION['id_user'],$data);
    	if($result)
    		$this->response->redirect('/tim-kiem-phong-tro');
    	die();
    }
}