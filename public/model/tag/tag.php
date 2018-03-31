<?php
class ModeltagTag extends Model {

    public function addTag($data) {
        $sql="INSERT " . DB_PREFIX . "tag SET tag_feature=".$data['tag_feature'];

        if(isset($data['tag_type'])) {
            $sql .= ", tag_type='" . $this->objects->object_type . "'";
        }

        if(isset($data['tag_category']))
            $sql.=", category_tag_id='".$data['tag_category']."'";

        $this->db->query($sql);
        $tag_id = $this->db->getLastId();
        if(!empty($tag_id)) {
            foreach ($data['tag'] as $language_id => $value) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "tag_description SET tag_id = '" . (int)$tag_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "'");

                $keyword=$this->alias->generateSeoURL($this->db->escape($value['name']));
                if(!empty($value['keyword']))
                    $keyword=$this->alias->generateSeoURL($this->db->escape($value['keyword']));

                $query_check_keyword = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $keyword . "'");

                if($query_check_keyword->row)
                    $keyword = $this->config->get($this->objects->object_type.'_tag')['prefix_alias'] . $keyword;

                $text_query = $this->config->get($this->objects->object_type.'_tag')['request_id']."=". (int)$tag_id;

                $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET object_type ='".$this->objects->object_type."', type='tag', query = '".$text_query. "', keyword = '".$keyword . "', `language_id`='".(int)$language_id."'");
            }
        }
        $this->cache->delete('tag');
        $this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));
    }

    public function editTag($tag_id, $data) {

        $this->db->query("DELETE FROM " . DB_PREFIX . "tag_description WHERE tag_id = '" . (int)$tag_id . "'");

        $sql="UPDATE " . DB_PREFIX . "tag SET tag_feature=".$data['tag_feature'];

        if(isset($data['tag_type'])) {
            $sql .= ", tag_type='" . $this->objects->object_type . "'";

        }

        if(isset($data['tag_category']))
            $sql.=", category_tag_id='".$data['tag_category']."'";

        $sql.="  WHERE tag_id = '" . (int)$tag_id . "'";

        $this->db->query($sql);


        $text_query = $this->config->get($this->objects->object_type.'_tag')['request_id']."=". (int)$tag_id;

        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '".$text_query."'");

        foreach ($data['tag'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "tag_description SET tag_id = '" . (int)$tag_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description='".$value['description']."', meta_title='".$value['meta_title']."', meta_description='".$value['meta_description']."', meta_keyword='".$value['meta_keyword']."'");

            $keyword=$this->alias->generateSeoURL($this->db->escape($value['name']));
            if(!empty($value['keyword']))
                $keyword=$this->alias->generateSeoURL($this->db->escape($value['keyword']));

            $query_check_keyword = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $keyword . "'");

            if($query_check_keyword->row)
                $keyword = $this->config->get($this->objects->object_type.'_tag')['prefix_alias'] . $keyword;

            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET object_type ='".$this->objects->object_type."', type='tag', query = '".$text_query. "', keyword = '".$keyword . "', `language_id`='".(int)$language_id."'");
        }

        $this->cache->delete('tag');
        $this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));
    }

    public function deleteTag($tag_id) {
        $this->db->query("DELETE FROM " . DB_PREFIX . "tag WHERE tag_id = '" . (int)$tag_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "tag_description WHERE tag_id = '" . (int)$tag_id . "'");

        // TODO: warning - Xóa trường hợp keyword trùng  => Prefix.
        $text_query = $this->config->get($this->objects->object_type.'_tag')['request_id']."=" . (int)$tag_id;
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '".$text_query."' AND object_type='".$this->objects->object_type."' AND type='tag'");
    }
    public function getProductTages($product_id) {
        $query=$this->db->query("SELECT * FROM " . DB_PREFIX . "tag_to_product WHERE product_id = '" . (int)$product_id . "'");
        return $query->rows;
    }

    public function getTagProducts($data) {
        $sql="SELECT * FROM " . DB_PREFIX . "tag_to_product WHERE tag_id = '" . (int)$data['tag_id'] . "'";
        if (isset($data['start']) || isset($data['limit'])) {
            if ($data['start'] < 0) {
                $data['start'] = 0;
            }
            if ($data['limit'] < 1) {
                $data['limit'] = 20;
            }
            $sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
        }

        $query=$this->db->query($sql);
        return $query->rows;
    }

    public function getTag($tag_id) {
        $query = $this->db->query("SELECT t.tag_id, t.category_tag_id,t.tag_type, t.tag_feature, td.name, t.status FROM " . DB_PREFIX . "tag t LEFT JOIN " . DB_PREFIX . "tag_description td ON (t.tag_id = td.tag_id) WHERE t.tag_id = '" . (int)$tag_id . "' AND td.language_id = '" . (int)$this->config->get('config_language_id') . "'");
        return $query->row;
    }

    public function getTages($data = array()) {

        if (!empty($data['filter_tag_type']))
            $tag_type = $data['filter_tag_type'];
        else
            $tag_type="default";

        $sql = "SELECT t.tag_id, td.name, t.tag_feature, t.status FROM " . DB_PREFIX . "tag t LEFT JOIN " . DB_PREFIX . "tag_description td ON (t.tag_id = td.tag_id) WHERE td.language_id = '" . (int)$this->config->get('config_language_id') . "'";

        if (!empty($data['filter_name'])) {
            $sql .= " AND td.name LIKE '%" . $this->db->escape(mb_convert_encoding($data['filter_name'], "UTF-8")) . "%'";
        }

        if (!empty($data['filter_cateogry_id'])) {
            $sql .= " AND (category_tag_id = '" .(int)$data['filter_cateogry_id']. "'";
        }

        if (!empty($data['filter_cateogry_id'])) {
            $sql .= " OR category_tag_id = '0')";
        }

        $sql .= " AND tag_type = '" .$tag_type. "'";

        $sql .= " GROUP BY t.tag_id";
        $sql .= " ORDER BY t.view";
        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }
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

        $tag_data=$query->rows;

    return $tag_data;
    }

    public function getTagDescriptions($tag_id) {
        $tag_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "tag_description WHERE tag_id = '" . (int)$tag_id . "'");
        $keyword_query = $this ->getTagKeyword((int)$tag_id);
        foreach ($query->rows as $result) {
            $tag_data[$result['language_id']] = array(
                'name' => $result['name'],
                'description' => $result['description'],
                'meta_title' => $result['meta_title'],
                'meta_description' => $result['meta_description'],
                'meta_keyword' => $result['meta_keyword'],
                'keyword'          => isset($keyword_query[$result['language_id']]) ? $keyword_query[$result['language_id']]['keyword'] : $this->alias->generateSeoURL($this->db->escape($result['name']))
            );
        }
//        echo "<pre>";
//        var_dump($tag_data);
//        echo "</pre>";
//        die();
        return $tag_data;
    }
    public function getTagKeyword($tag_id) {
        $category_keyword_data = array();
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->config->get($this->objects->object_type."_tag")['request_id'] .'='. (int)$tag_id  . "'");
        foreach ($query->rows as $result) {
            $category_keyword_data[$result['language_id']] = array(
                'query'         => $result['query'],
                'keyword'       => $result['keyword']
            );
        }

        return $category_keyword_data;
    }

    public function getTagByCategory($category_id,$tag_type='default'){
        $sql="SELECT t.tag_id, t.category_tag_id, t.tag_feature, td.name FROM " . DB_PREFIX . "tag t LEFT JOIN " . DB_PREFIX . "tag_description td ON (t.tag_id = td.tag_id) WHERE (t.category_tag_id = '" . (int)$category_id . "' OR t.category_tag_id = '0') AND tag_type='".$tag_type."'  AND td.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY t.view DESC";
        $query = $this->db->query($sql);
        return $query->rows;
    }

    public function addView($tag_id){
        $sql="UPDATE " . DB_PREFIX . "tag SET view = view + 1 WHERE tag_id=".$tag_id;
        $query = $this->db->query($sql);
    }

    public function getTagFeatures($category_id,$tag_type='default'){
        $query = $this->db->query("SELECT t.tag_id, t.category_tag_id, t.tag_feature, td.name FROM " . DB_PREFIX . "tag t LEFT JOIN " . DB_PREFIX . "tag_description td ON (t.tag_id = td.tag_id) WHERE (t.category_tag_id = '" . (int)$category_id . "' OR t.category_tag_id = '0') AND tag_type='".$tag_type."' AND t.tag_feature=1  AND td.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY td.name");
        return $query->rows;
    }

    public function getTotal($data=array()){

        $sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX;
        if (isset($data['tag_id'])) {
            $sql .="tag_to_product WHERE tag_id='" . $data['tag_id'] . "'";
        }else if(isset($data['product_id'])){
            $sql.="tag_to_product WHERE product_id='".$data['product_id']."'";
        }else{
            $sql.='tag';
            if (!empty($data['filter_tag_type'])) {
                $sql .= " WHERE tag_type = '" .$data['filter_tag_type']. "'";
            }
        }
        $query = $this->db->query($sql);

        return $query->row['total'];
    }

    public function getTotalProductsByTagId($tag_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "tag_to_product WHERE tag_id = '" . (int)$tag_id . "'");
        return $query->row['total'];
    }
}