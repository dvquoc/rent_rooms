<?php

class ControllerDataInsert extends Controller{
    private $error = array();
    public function index()
    {
        $this->load->public_model('create/table');
        $this->model_create_table->insertData();
    }
}
