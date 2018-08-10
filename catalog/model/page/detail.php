<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelPageDetail extends Model {
	public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->rooms;
    }
    public function get_room($id){
	    $option = [
        ];
    	$result = $this->table->findOne(['_id' => new MongoDB\BSON\ObjectId($id)],$option);
        return $result;
    }
    public function getRelative($data){
        $filter = [
            'city_id' =>$data['city_id'],
            'district_id' =>$data['district_id'],
        ];
        $point = array(
            'type'       =>'Point',
            'coordinates'=>$data['point']
        );
        $pipeline = [
            [
                '$geoNear' => [
                    'near' =>$point,
                    'distanceField' => "calculated",
                    'includeLocs'=> "location",
                    'maxDistance' => 2000,
                    'spherical'=> true,
                    'query'  => $filter
                ],

            ],
            ['$limit' => 6],
            ['$skip' =>0]
        ];

        $result = $this->table->aggregate($pipeline)->toArray();
        return $result;
    }
     public function get_user_by_id($id){
        $OneResult = $this->db->owner_user->findOne(['_id' =>new MongoDB\BSON\ObjectId($id)]);
        if($OneResult){
            return $OneResult;
        }else
            return 0;
    }
}