<?php
class ControllerPageDetail extends Controller {
	public function index() {
       var_dump("asdasd"); die();
	}
	public function test($data){
	    var_dump($data['id']);
    }
}