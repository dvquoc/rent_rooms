<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 7/21/2018
 * Time: 4:30 PM
 */

class ModelLocationLocation extends model{
    public function __construct($registry){
        parent::__construct($registry);

    }
    function getAllCity(){
        $citys = $this->cache->get('city-cache');
        if(!$citys){
            $result = $this->db->city->find()->toArray();
            $this->cache->set('city-cache', $result);
            return $result;
        }
        return $citys;
    }

    function getDistrictByCity($city_id){
        return $this->db->district->find(['city_id'=> $city_id])->toArray();
    }
    function getCityById($city_id){

        return $this->db->city->find(['city_id'=> $city_id])->toArray();
    }
    function getDistrictById($district_id){

        return $this->db->district->find(['district_id'=> $district_id])->toArray();
    }

    public function get_city_by_name($name){
        return $this->db->city->findOne(array('name'=> $name));
    }
    public function get_district_by_name($name,$id_city){
        return $this->db->district->find(array('name'=> $name,'city_id'=>$id_city))->toArray();
    }
    public function getSpecialByLocation(){

    }
}