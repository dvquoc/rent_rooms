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
            $filter['price']= [
                '$gt'=>(float) $data['price'][0]*1000000,
                '$lt'=>(float) $data['price'][1]*1000000,
            ];
        }

        if(isset($data['acreage']) && !empty($data['acreage'])){
            $filter['acreage']= [
                '$gt'=>(int) $data['acreage'][0],
                '$lt'=>(int) $data['acreage'][1],
            ];
        }
        $this->load->model("location/location");
        if(isset($data['slug_city_name']) && !empty($data['slug_city_name'])){
           $city = $this->model_location_location->get_city_by_slug($data['slug_city_name']);
           $filter['city_id'] = $city['city_id'];
        }

        if(isset($data['slug_district_name']) && !empty($data['slug_district_name'])){
             $district = $this->model_location_location->get_district_by_slug($data['slug_district_name'],$filter['city_id']);
             $filter['district_id']=  $district['district_id'];
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