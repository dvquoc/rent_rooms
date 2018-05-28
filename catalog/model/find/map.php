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
    public function common(){
        $result = $this->db->ladingpage->find();
        if(count($result) > 0)
            return $result->toArray();
        return false;
    }
    public function regionListing($data_region){
        $data = array(
                    'type' =>'Polygon',
                    'coordinates'=>array($data_region)
                );
        $result = $this->table->find(
            ['location'=>['$geoWithin'=>['$geometry'=>$data]]],
            ['sort'       => ['room_id'=>-1]],
            ['limit'=>500]
        )->toArray();
        return $result;
    }
}