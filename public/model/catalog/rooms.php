<?php
class ModelCatalogRooms extends Model {
    protected $table = null;
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->rooms;
    }
    public function find($data){
        $filter = [];
        if (!empty($data['city_id']))
            $filter['city_id']= (int) $data['city_id'];

        if (!empty($data['district_id']))
            $filter['district_id']=(int) $data['district_id'];

        if (isset($data['ads']) && $data['ads'] >=0)
            $filter['ads']= (int) $data['ads'];

        if (!empty($data['ads_position']) && $data['ads_position'] != -1)
            $filter['ads_position']=$data['ads_position'];

        if (isset($data['close_door']) && $data['close_door'] >=0)
            $filter['close_door']=$data['close_door'];

        if (isset($data['price']) && $data['price']>0)
            $filter['price']= (int) $data['price'];

        if (isset($data['acreage']) && $data['acreage']>0)
            $filter['acreage']= (int) $data['acreage'];

        if (isset($data['status']))
            $filter['status']= (int) $data['status'];

        $options =[
            'skip'       => isset($data['start']) ? $data['start']:0,
            'limit'      => isset($data['limit']) ? $data['limit']:20,
            'sort'       => ['room_id'=>-1],
            'projection' => [
                'room_id'  =>1,
                'name'     =>1,
                'address'  =>1,
                'location'  =>1,
                'ads'      =>1,
                'from_date'=>1,
                'to_date'  =>1,
                'price'    =>1,
                'acreage'  =>1,
            ],
        ];
        return $this->table->find($filter, $options)->toArray();
    }

    public function addRooms($data){
         $point = array(
            'type' =>'Point',
            'coordinates'=>[(float) $data['lng'],(float) $data['lat']]
        );
        $stt = $this->table->findOne([],['sort' => ['room_id' => -1],'projection' => ['room_id' => 1]]);
        return $this->table->insertOne([
            'master_id'         =>0,
            'user_id'           =>$this->user->getId(),
            'room_id'           => $stt->room_id+1,
            'name'              => $data['name'],
            'images'            => $data['images'],
            'city_id'           => (int) $data['city_id'],
            'district_id'       => (int) $data['district_id'],
            'address'           => $data['address'],
            'location'          => $point,
            'price'             => (int) $data['price'],
            'price_electricity' => (int) $data['price_electricity'],
            'price_water'       => (int) $data['price_water'],
            'price_deposit'     => (int) $data['price_deposit'],
            'acreage'           => (int) $data['acreage'],
            'amount_people'     => (int) $data['amount_people'],
            'close_door'        => $data['close_door'],
            'highlight'         => $data['highlight'],
            'regulation_room'   => $data['regulation_room'],
            'view'              => (int) $data['view'],
            'call'              => (int) $data['call'],
            'from_date'         => new MongoDB\BSON\UTCDateTime((int) $data['from_date']),
            'to_date'           => new MongoDB\BSON\UTCDateTime((int) $data['to_date']),
            'ads'               => (int) $data['ads'],
            'ads_position'      => $data['ads_position'],
            'status'            => (int) $data['status'],
            'date_crate'        => new MongoDB\BSON\UTCDateTime((new dateTime())->getTimestamp()),
            'source'            =>'back-end',
            'is_checked'        =>1,
            'slug'         => $data['slug'],
            'slug_city'         =>$data['slug_city'],
            'slug_district'     =>$data['slug_district'],

        ]);
    }

    public function editRooms($rooms_id, $data = array()){
        $point = array(
            'type' =>'Point',
            'coordinates'=>[(float) $data['lng'],(float) $data['lat']]
        );
        $data_set = [
            'name'              => $data['name'],
            'images'            => $data['images'],
            'city_id'           => (int) $data['city_id'],
            'district_id'       => (int) $data['district_id'],
            'address'           => $data['address'],
            'location'          => $point,
            'price'             => (int) $data['price'],
            'price_electricity' => (int) $data['price_electricity'],
            'price_water'       => (int) $data['price_water'],
            'price_deposit'     => (int) $data['price_deposit'],
            'acreage'           => (int) $data['acreage'],
            'amount_people'     => (int) $data['amount_people'],
            'close_door'        => $data['close_door'],
            'highlight'         => $data['highlight'],
            'regulation_room'   => $data['regulation_room'],
            'view'              => (int) $data['view'],
            'call'              => (int) $data['call'],
            'from_date'         => new MongoDB\BSON\UTCDateTime((int) $data['from_date']),
            'to_date'           => new MongoDB\BSON\UTCDateTime((int) $data['to_date']),
            'ads'               => (int) $data['ads'],
            'ads_position'      => $data['ads_position'],
            'status'            => (int) $data['status'],
            'is_checked'        =>(int) isset($data['is_check'])?1:0,
            'slug'         => $data['slug'],
            'slug_city'         =>$data['slug_city'],
            'slug_district'     =>$data['slug_district'],
        ];

        //var_dump($data_set); die();
        return $this->table->updateOne(
            ['room_id' => (int) $rooms_id],
            ['$set' => $data_set]
        );
    }

    public function getRoom($rooms_id){
        return $this->table->findOne(['room_id'=> (int) $rooms_id]);
    }

    public function getTotalRooms($data){
        $filter = [];
        if (!empty($data['city_id']))
            $filter['city_id']= (int) $data['city_id'];

        if (!empty($data['district_id']))
            $filter['district_id']=(int) $data['district_id'];

        if (isset($data['ads']) && $data['ads'] >=0)
            $filter['ads']= (int) $data['ads'];

        if (!empty($data['ads_position']) && $data['ads_position'] != -1)
            $filter['ads_position']=$data['ads_position'];

        if (isset($data['close_door']) && $data['close_door'] >=0)
            $filter['close_door']=$data['close_door'];

        if (isset($data['price']) && $data['price']>0)
            $filter['price']= (int) $data['price'];

        if (isset($data['acreage']) && $data['acreage']>0)
            $filter['acreage']= (int) $data['acreage'];

        if (isset($data['status']))
            $filter['status']= (int) $data['status'];

        $options =[];
        return $this->table->count($filter, $options);
    }
}