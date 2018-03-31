<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelCatalogTest extends Model {
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
        $result = $this->db->listing->find(array(
            'location'=>['$geoWithin'=>['$geometry'=>$data]],
        ),
        array(
            'limit'=>200
        )
        );
        if(count($result) > 0)
            return $result->toArray();
        return false;
    }
}