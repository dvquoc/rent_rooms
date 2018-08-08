<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 7/21/2018
 * Time: 4:30 PM
 */

class ModelLocationSpecial extends model{
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->special;
    }

    public function add($data){
        $insertOneResult = $this->table->insertOne($data);
        return $insertOneResult->getInsertedId();
    }

    public function update($id, $data){
        return $this->table->updateOne(
            ['place_id' =>$id],
            ['$set' => $data]
        );
    }

    public function get_list($data = array()){
        $filter = [];
        $options =[
            'sort' => ['view'=>-1],
            'limit'=>8,
            'skip' =>0
        ];

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
                    ],

                ],
                ['$limit' => 8],
                ['$skip' =>0]
            ];
            return $this->table->aggregate($pipeline)->toArray();
        }
        return false;
    }

    public function getSpecialByCity($city_id){
        return $this->table->find(
            ['city_id'=> (int) $city_id],
            [
                'sort'  => ['view'=>-1],
                'limit' => 8,
            ]
        )->toArray();
    }
    public function getSpecialByDistrict($district_id){
        return $this->table->find(
            ['district_id'=> (int) $district_id],
            [
                'sort' => ['view'=>-1],
                'limit'      => 8,
            ]
        )->toArray();
    }

    public function getOne($data){
        return $this->table->findOne($data);
    }

    public function getOneByLatLgn($data){
        $point = [
            'type' => "Point",
            'coordinates' => $data
        ];
        return $this->table->findOne([
                'location'=>[
                    '$geoIntersects'=> [
                    '$geometry' =>$point
                    ]
                ]
            ]);
    }
    public function get_list_filter($data){
        $result = $this->table->find($data);
        return $result->toArray();
    }
    public function getSpecialByLocation(){

    }
}