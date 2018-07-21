<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 7/21/2018
 * Time: 4:30 PM
 */

class ModelLocationSpecial extends model{
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->special;
    }
    public function add($data){
        $insertOneResult = $this->table->insertOne($data);
        return $insertOneResult->getInsertedId();
    }
    public function  getSpecialById(){

    }
    public function getSpecialByLocation(){

    }
}