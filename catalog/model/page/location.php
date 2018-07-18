<?php
class ModelPageLocation extends Model {
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

    function getOneById($table, $id){
        $sql = "SELECT * FROM ".$table." WHERE ".$table."_id= ".$id;
        $query = $this->db->query($sql);
        return $query->row;
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

        return $this->db->district->find(['city_id'=> (string)$city_id])->toArray();
    }
    function getCityById($city_id){
        
        return $this->db->city->find(['city_id'=> $city_id])->toArray();
    }
    function getDistrictById($district_id){
        
        return $this->db->district->find(['district_id'=> $district_id])->toArray();
    }

    public function get_city_by_name($name){
        return $this->db->city->find(array('name'=> $name))->toArray();
    }
    public function get_district_by_name($name,$id_city){
        return $this->db->district->find(array('name'=> $name,'city_id'=>$id_city))->toArray();
    }

    function getStreetTotalByDistrict($data){
        $sql = "SELECT COUNT(*) AS total FROM ".$this->_table_relative['street']." WHERE (1=1)";
        if(!empty($data['name']))
            $sql.=' AND name LIKE "%'. $data['name'].'%"';

        if(!empty($data['district']))
            $sql.=' AND district_id ='. $data['district'];

        if(!empty($data['location']))
            $sql.=' AND location IS NOT NULL';
        else
            $sql.=' AND location IS NULL';

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    function getStreetById($street_id){
        $sql = "SELECT * FROM ".$this->_table_relative['street']." WHERE street_id= ".$street_id;
        $query = $this->db->query($sql);
        return $query->row;
    }

    function getSpecialByDistrict($district_id){
        $sql = "SELECT * FROM ".$this->_table_relative['special']." WHERE (1=1)";
        if(!empty($data['name']))
            $sql.=' AND name LIKE "%'. $data['name'].'%"';

        if(!empty($data['district_id']))
            $sql.=' AND district_id ='. $data['district_id'];

        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }
            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }
            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }
        $query = $this->db->query($sql);
        return $query->rows;
    }

    function getSpecialTotalByDistrict($data){
        $sql = "SELECT COUNT(*) AS total FROM ".$this->_table_relative['special']." WHERE (1=1)";
        if(!empty($data['name']))
            $sql.=' AND name LIKE "%'. $data['name'].'%"';

        if(!empty($data['district']))
            $sql.=' AND district_id ='. $data['district'];

        if(!empty($data['location']))
            $sql.=' AND location IS NOT NULL';
        else
            $sql.=' AND location IS NULL';

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

    function getSpecialById($special_id){
        $sql = "SELECT * FROM ".$this->_table_relative['special']." WHERE special_id= ".$special_id;
        $query = $this->db->query($sql);
        return $query->row;
    }

    function getLocationDistrict($district_id){
        $sql = "SELECT `location` FROM ".$this->_table_relative['district']." WHERE district_id= ".$district_id;
        $query = $this->db->query($sql);
        return $query->row;
    }
}