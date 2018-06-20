<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelFindList extends Model {
	public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->rooms;
    }
    public function get_list(){
    	 $options =[
            'sort' => ['room_id'=>-1],
            'limit'=>10,
            'skip' =>0
        ];
    	$result = $this->table->find(array(),$options)->toArray();
        return $result;
    }
}