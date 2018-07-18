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
    public function get_list($data = array()){
        $filter = [];
    	 $options =[
            'sort' => ['room_id'=>1],
            'limit'=>20,
            'skip' =>0
        ];
        if(isset($data['price']) && !empty($data['price'])){
            $filter['price']= $data['price'];
        }

        if(isset($data['acreage']) && !empty($data['acreage'])){
            $filter['acreage']= $data['acreage'];
        }
    	if(isset($data['region']) && !empty($data['region'])){
             $data = array(
                 'type'       =>'Polygon',
                 'coordinates'=>[$data['region']]
             );
             $filter['location']= ['$geoWithin'=>['$geometry'=>$data]];
        }
    	$result = $this->table->find($filter,$options)->toArray();
        return $result;
    }
    public function get_list_featured(){
         $options =[
            'limit'=>6,
            'skip' =>0
        ];
        $result = $this->table->find(array(),$options)->toArray();
        return $result;
    }

  
}