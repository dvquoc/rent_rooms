<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelFindMap extends Model {
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->rooms;
    }
    public function regionListing($data_region){
        $data = array(
                    'type'       =>'Polygon',
                    'coordinates'=>array($data_region)
                );
        $filter['location']= ['$geoWithin'=>['$geometry'=>$data]];
        $options =[
            'sort' => ['room_id'=>-1],
            'limit'=>1,
            'skip' =>0
        ];
        $options1 =[
            'sort' => ['room_id'=>-1],
            'limit'=>30,
            'skip' =>0
        ];
        $result['data_lagre'] = $this->table->find($filter,$options)->toArray();
        $result['data_small'] = $this->table->find($filter,$options1)->toArray();
        return $result;
    }
}