<?php
class ModelLocationLocationAdmin extends Model {
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

    function getAllCity(){
        $query = $this->db->query("SELECT * FROM ".$this->_table);
        return $query->rows;
    }

    function getDistrictByCity($city_id){
        $query = $this->db->query("SELECT * FROM ".$this->_table_relative['district']." WHERE city_id = '" . (int)$city_id . "'");
        return $query->rows;
    }

    function getStreetByCity($district_id){
        $query = $this->db->query("SELECT * FROM ".$this->_table_relative['street']." WHERE district_id = '" . (int)$district_id . "'");
        return $query->rows;
    }

    function getSpecialByCity($district_id){
        $query = $this->db->query("SELECT * FROM ".$this->_table_relative['special']." WHERE district_id = '" . (int)$district_id . "'");
        return $query->rows;
    }
}