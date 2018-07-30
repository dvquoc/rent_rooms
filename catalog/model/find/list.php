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
            'sort' => ['rooms_id'=>1],
            'limit'=>20,
            'skip' =>0
        ];
        if(isset($data['price']) && !empty($data['price'])){
            $filter['price']= $data['price'];
        }

        if(isset($data['acreage']) && !empty($data['acreage'])){
            $filter['acreage']= $data['acreage'];
        }

        if(isset($data['slug_city_name']) && !empty($data['slug_city_name'])){
            $filter['slug_city_name']= $data['slug_city_name'];
        }

        if(isset($data['slug_district_name']) && !empty($data['slug_district_name'])){
            $filter['slug_district_name']= $data['slug_district_name'];
        }

        $filter['status']= 1;

    	if(isset($data['point']) && !empty($data['point'])){
             $data = array(
                 'type'       =>'Point',
                 'coordinates'=>$data['point']
             );
            $pipeline = [
                [
                    '$geoNear' => [
                        'near' =>$data,
                        'distanceField' => "calculated",
                        'includeLocs'=> "location",
                        'maxDistance' => 3000,
                        'spherical'=> true,
                        'query'=>$filter
                    ],

                ],[
                    '$limit' => 10,
                ],[
                    '$skip' =>0
                ]
            ];
            $result = $this->table->aggregate($pipeline)->toArray();
        }else{
            $result = $this->table->find($filter,$options)->toArray();
        }
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