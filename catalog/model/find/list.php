<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 2/1/2018
 * Time: 9:51 AM
 */
class ModelFindList extends Model {
    public function find($data_search){
        $query = $this->db->query('SELECT * FROM `1_1_rooms` WHERE `status` ='.$data_search['status']);
        return $query->rows;
    }
}