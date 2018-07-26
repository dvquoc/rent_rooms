<?php

class ModelPageOwnerRegister extends Model {
	public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->owner_user;
    }
    public function add_user($data){
    	$insertOneResult = $this->table->insertOne($data);
    	return $insertOneResult->getInsertedId();
    }

    public function get_user_by_social($source_id){
    	$OneResult = $this->table->findOne(['source_id' => $source_id]);
    	if($OneResult){
    		return $OneResult;
    	}else
    		return 0;
    }

    public function get_user_by_id($id){
       
    	$OneResult = $this->table->findOne(['_id' =>new MongoDB\BSON\ObjectId($id['id_owner'])]);
    	if($OneResult){
    		return $OneResult;
    	}else
    		return 0;
    }
    public function update_info($id_source,$data){
    	$updateResult =  $this->table->updateOne(
    	 	['source_id' => $id_source],
    	 	['$set' => $data]
    	 );
    	return $updateResult;
    }
    public function get_phone($phone){
        $OneResult = $this->table->findOne(['phone' => $phone]);
        if($OneResult){
            return $OneResult;
        }else
            return 0;
    }
     public function update_account($id,$data){
        $updateResult =  $this->table->updateOne(
            ['_id' => new MongoDB\BSON\ObjectId($id['id_owner'])],
            ['$set' => $data]
         );
        return $updateResult;
    }
}