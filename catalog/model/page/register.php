<?php

class ModelPageRegister extends Model {
	public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->owner;
    }
    public function add_user($data){
    	$insertOneResult = $this->table->insertOne($data);
    	return $insertOneResult->getInsertedId();
    }
    public function get_user($id){
    	$OneResult = $this->table->findOne(['source_id'=>$id]);
    	if($OneResult){
    		return $OneResult;
    	}else
    		return 0;
    }
}