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

    public function get_list($data){
        $result = $this->table->find($data);
        return $result;
    }

    public function update($id,$data){
    	$updateResult =  $this->table->updateOne(
    	 	['_id' => new MongoDB\BSON\ObjectId($id)],
    	 	['$set' => $data]
    	 );
    	return $updateResult;
    }

    public function get_special($id){

    	$OneResult = $this->table->findOne(['_id' => new MongoDB\BSON\ObjectId($id)]);
    	if($OneResult){
    		return $OneResult;
    	}else
    		return 0;
    }

    public function delete_list($ids){
    	$arr_value = [];
    	foreach ($ids as $value) {
    		$arr_value[] = new MongoDB\BSON\ObjectId($value);
    	}
    	$deleteResult = $this->table->deleteMany(
    		['_id' =>  ['$in' => $arr_value]]
    	);
    	return $deleteResult;
    }

   
}