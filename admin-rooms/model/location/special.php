<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelLocationSpecial extends Model {
	public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->special;
    }
    public function add($data){
    	$insertOneResult = $this->table->insertOne($data);
    	return $insertOneResult->getInsertedId();
    }
}