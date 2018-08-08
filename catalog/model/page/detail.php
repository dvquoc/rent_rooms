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
            'projection' => [
                'name'     =>1,
                'images'   =>1,
                'city_id'   =>1,
                'district_id'=>1,
                'address'  =>1,
                'location' =>1,
                'ads'      =>1,
                'price'    =>1,
                'price_electricity'   =>1,
                'price_water'   =>1,
                'price_deposit'   =>1,
                'acreage'  =>1,
                'amount_people'  =>1,
                'close_door'  =>1,
                'highlight'  =>1,
                'regulation_room'  =>1,
            ]
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
}