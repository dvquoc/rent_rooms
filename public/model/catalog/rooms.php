<?php
class ModelCatalogRooms extends Model {
    protected $_table = '1_1_rooms';
    protected $_name_col;

    public function __construct($registry)
    {
        parent::__construct($registry);
    }

    public function find($data_search){
        $query = $this->db->query('SELECT * FROM `'. $this->_table .'` WHERE `status` ='.$data_search['status']);
        return $query->rows;
    }

    public function addRooms($data){
        $set_tring = $this->__setStringUpdate($data);
        $sql="INSERT `" . $this->_table . "` SET " . $set_tring;
        $this->db->query($sql);
        $this->cache->delete('rooms');
        $this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));
    }

    public function editRooms($rooms_id, $data = array()){
        $set_tring = $this->__setStringUpdate($data);
        $sql="UPDATE `" . $this->_table . "` SET " . trim($set_tring,",");
        $sql.=" WHERE room_id = " . (int)$rooms_id ;
        //var_dump($sql); die();
        $this->db->query($sql);
        $this->cache->delete('rooms');
        $this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));
    }

    public function getRoom($rooms_id){
        $query = $this->db->query("SELECT DISTINCT * FROM "."1_1_rooms WHERE room_id = '" . (int)$rooms_id . "'");
        return $query->row;
    }
    public function getTotalRooms($data_search){
        $sql ="SELECT COUNT(*) AS total FROM " ."1_1_rooms WHERE (1=1)";

        if(isset($data['filter_rooms_type']))
            $sql.=' AND rooms_type="'.$data['filter_rooms_type'].'"';

        if(isset($data['filter_category_id']) && $data['filter_category_id']!=0)
            $sql.=' AND category_id="'.$data['filter_category_id'].'"';

        if (!empty($data['filter_name'])) {
            $sql .= " AND id.title LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
        }

        $query = $this->db->query($sql);
        return $query->row['total'];
    }

}