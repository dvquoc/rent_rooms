<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelLocationCity extends Model {
	public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->city;
    }
    // public function add($data){
    //     // $point = array(
    //     //     'type' =>'Point',
    //     //     'coordinates'=>[(double)$data['location'][0],(double)$data['location'][1]],
    //     // );
    //     // $data['location'] = $point;
    // 	$insertOneResult = $this->table->insertOne($data);
    // 	return $insertOneResult->getInsertedId();
    // }

    // public function get_list_filter($data){
    //     $result = $this->table->find($data);
    //     return $result->toArray();
    // }

    // public function get_location_by_id($id){
    //     $OneResult = $this->table->findOne(['place_id' => $id]);
    //     if($OneResult){
    //         return $OneResult;
    //     }else
    //         return 0;
    // }

    public function updateCity($id,$data){
    	$updateResult =  $this->table->updateOne(
    	 	['city_id' => (int)$id],
    	 	['$set' => $data]
    	 );
    	return $updateResult;
    }

     public function updateDistrict($id,$data){
        $updateResult =  $this->db->district->updateOne(
            ['district_id' => (int)$id],
            ['$set' => $data]
         );
        return $updateResult;
    }

    // public function get_special($id){

    // 	$OneResult = $this->table->findOne(['_id' => new MongoDB\BSON\ObjectId($id)]);
    // 	if($OneResult){
    // 		return $OneResult;
    // 	}else
    // 		return 0;
    // }

    // public function delete_list($ids){
    // 	$arr_value = [];
    // 	foreach ($ids as $value) {
    // 		$arr_value[] = new MongoDB\BSON\ObjectId($value);
    // 	}
    // 	$deleteResult = $this->table->deleteMany(
    // 		['_id' =>  ['$in' => $arr_value]]
    // 	);
    // 	return $deleteResult;
    // }

   
}