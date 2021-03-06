<?php
class ControllerPageLogout extends Controller {
	public function index($args) {
		$config_file_path = "vendor/hybridauth/hybridauth/hybridauth/config.php";
                require_once( "vendor/hybridauth/hybridauth/hybridauth/Hybrid/Auth.php" );
                $hybridauth = new Hybrid_Auth( $config_file_path );
                $hybridauth->logoutAllProviders();
                if(isset($this->session->data['source_id'])){
                	unset($this->session->data['source_id']);
                }
                unset($this->session->data['id_user']);
                $this->response->redirect('/');
	}
}