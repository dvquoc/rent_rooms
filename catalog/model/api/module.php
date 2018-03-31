<?php
class ModelApiModule extends Model {
    public function getModuleActive($code ='module') {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module ORDER BY `name`");
        return $query->rows;
    }
}