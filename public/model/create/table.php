<?php
use Naucon\File\FileReader;

class ModelCreateTable extends Model {
    protected $_table = 'city';
    protected $_table_relative = [
        'district'=>'district',
        'street'=>'street',
        'special'=>'special'
    ];
    protected $_name_col;

    public function __construct($registry)
    {
        parent::__construct($registry);
    }

    function insertData()
    {
        //$data = $this->cache->get('location_1');
        $query = $this->db->query("SELECT * FROM city");

        $fileObject = new FileReader(DIR_SYSTEM."data_file/District-ward-stress-1.txt", 'r', true);
        foreach ($query->rows as $city){
            foreach (json_decode($fileObject->read()) as $item){
                if($item->name == $city['name']){
                    foreach ($item->districts as $district){
                        $data = array(
                            'name'=>$district->name,
                            'city_id'=>$city['city_id']
                        );
                        $set_tring = $this->__setStringUpdate($data,$this->_table_relative['district']);
                        $sql="INSERT `" . $this->_table_relative['district'] . "` SET " . $set_tring;
                        $this->db->query($sql);
                        $district_id = $this->db->getLastId();
                        foreach ($district->streets as $street){
                            $data = array(
                                'name'=>$street->name,
                                'district_id'=>$district_id
                            );
                            $set_tring = $this->__setStringUpdate($data,$this->_table_relative['street']);
                            $sql="INSERT `" . $this->_table_relative['street'] . "` SET " . $set_tring;
                            $this->db->query($sql);
                        }
                    }
                }

            }
        }
//        if (!$data) {
//            $query = $this->db->query("SELECT * FROM " . $this->_table);
//            $data = $query->rows;
//            $this->cache->set('location_1', $data);
//        }
        //return $data;
    }
}