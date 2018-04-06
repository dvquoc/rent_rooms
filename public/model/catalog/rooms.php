<?php

class ModelCatalogRooms extends Model {
    public function find($data_search){
        $query = $this->db->query('SELECT * FROM `1_1_rooms` WHERE `status` ='.$data_search['status']);
        return $query->rows;
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