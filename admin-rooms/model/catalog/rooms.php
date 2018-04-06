<?php
class ModelCatalogRooms extends Model {
    public function addInformation($data) {
        $this->event->trigger('pre.admin.rooms.add', $data);

        $sql="INSERT INTO " . DB_PREFIX . "rooms SET sort_order = '" . (int)$data['sort_order']. "', category_id = '" . (isset($data['category_id']) ? (int)$data['category_id'] : 0) . "', status = '" . (int)$data['status'] . "', image = '" . $data['image']. "', feature = '" . $data['feature']. "'";

        if(!empty($data['rooms_type']))
            $sql.=", rooms_type = '" . $this->objects->object_type."'";

        if(!empty($data['rooms_images']))
            $sql.=", rooms_images = '" . serialize($data['rooms_images'])."'";

        if(!empty($data['rooms_tages']))
            $sql.=", rooms_tags = '" . serialize($data['rooms_tags'])."'";

        $this->db->query($sql);

        $rooms_id = $this->db->getLastId();

        foreach ($data['rooms_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_description SET rooms_id = '" . (int)$rooms_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");

            $keyword = $this->alias->generateSeoURL($value['keyword']);
            if(!empty($value['keyword']))
                $keyword=$this->alias->generateSeoURL($this->db->escape($value['title']));

            $query_check_keyword = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $keyword . "'");

            if($query_check_keyword->row)
                $keyword = $this->config->get($this->objects->object_type.'_rooms')['prefix_alias'] . $keyword;

            $text_query = $this->config->get($this->objects->object_type.'_rooms')['request_id'] .'='. (int)$rooms_id;

            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET object_type ='".$this->objects->object_type."', type='rooms', query = '".$text_query."', keyword = '".$keyword. "', `language_id`='".(int)$language_id."'");
        }



        if (isset($data['rooms_layout'])) {
            foreach ($data['rooms_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_layout SET rooms_id = '" . (int)$rooms_id . "', layout_id = '" . (int)$layout_id . "'");
            }
        }

        if (isset($data['meta_data'])) {
            foreach ($data['meta_data'] as $key => $item_data) {
                $result = json_decode(html_entity_decode($item_data));
                if (json_last_error() === JSON_ERROR_NONE) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_meta SET rooms_id = '" . (int)$rooms_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='json'");
                }
                elseif(is_array($item_data)) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_meta SET rooms_id = '" . (int)$rooms_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='serializer'");
                }else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_meta SET rooms_id = '" . (int)$rooms_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='default'");
                }
            }
        }


        $this->cache->delete('rooms');
        $this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));

        $this->event->trigger('post.admin.rooms.add', $rooms_id);

        return $rooms_id;
    }

    public function editInformation($rooms_id, $data) {

        $this->event->trigger('pre.admin.rooms.edit', $data);

        $sql="UPDATE " . DB_PREFIX . "rooms SET sort_order = '" . (int)$data['sort_order']. "', category_id = '" . (isset($data['category_id']) ? (int)$data['category_id'] : 0) . "', status = '" . (int)$data['status'] ."', image = '" . $data['image']. "', feature = '" . $data['feature']."'";

        if(!empty($data['rooms_type']))
            $sql.=", rooms_type = '" . $data['rooms_type']."'";

        if(!empty($data['rooms_images']))
            $sql.=", rooms_images = '" . serialize($data['rooms_images'])."'";

        if(!empty($data['rooms_tags']))
            $sql.=", rooms_tags = '" . serialize($data['rooms_tags'])."'";

        $sql.=" WHERE rooms_id = '" . (int)$rooms_id . "'";


        $this->db->query($sql);

        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms_description WHERE rooms_id = '" . (int)$rooms_id . "'");

        $text_query = $this->config->get($this->objects->object_type.'_rooms')['request_id'] .'='. (int)$rooms_id;
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '".$text_query."'");

        foreach ($data['rooms_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_description SET rooms_id = '" . (int)$rooms_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
            $keyword = $this->alias->generateSeoURL($value['keyword']);
            if(!empty($value['keyword']))
                $keyword=$this->alias->generateSeoURL($this->db->escape($value['title']));

            $query_check_keyword = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $keyword . "'");

            if($query_check_keyword->row)
                $keyword = $this->config->get($this->objects->object_type.'_rooms')['prefix_alias'] . $keyword;

            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET object_type ='".$this->objects->object_type."', type='rooms', query = '".$text_query."', keyword = '".$keyword. "', `language_id`='".(int)$language_id."'");
        }




        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms_to_layout WHERE rooms_id = '" . (int)$rooms_id . "'");

        if (isset($data['rooms_layout'])) {
            foreach ($data['rooms_layout'] as $store_id => $layout_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_layout SET rooms_id = '" . (int)$rooms_id . "', layout_id = '" . (int)$layout_id . "'");
            }
        }
        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms_to_meta WHERE rooms_id = '" . (int)$rooms_id . "'");
        if (isset($data['meta_data'])) {
            foreach ($data['meta_data'] as $key => $item_data) {
                $result = json_decode(html_entity_decode($item_data));
                if (json_last_error() === JSON_ERROR_NONE) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_meta SET rooms_id = '" . (int)$rooms_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='json'");
                }
                elseif(is_array($item_data)) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_meta SET rooms_id = '" . (int)$rooms_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape(serialize($item_data)) . "', type='serializer'");
                }else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "rooms_to_meta SET rooms_id = '" . (int)$rooms_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='default'");
                }
            }
        }

        $this->cache->delete('rooms');
        $this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));

        $this->event->trigger('post.admin.rooms.edit', $rooms_id);
    }

    public function deleteInformation($rooms_id) {
        $this->event->trigger('pre.admin.rooms.delete', $rooms_id);

        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms WHERE rooms_id = '" . (int)$rooms_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms_description WHERE rooms_id = '" . (int)$rooms_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms_to_layout WHERE rooms_id = '" . (int)$rooms_id . "'");
        // TODO: warning - Xóa trường hợp keyword trùng  => Prefix.
        $text_query = $this->config->get($this->objects->object_type.'_rooms')['request_id']."=" . (int)$rooms_id;
        $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '".$text_query."' AND object_type='".$this->objects->object_type."' AND type='rooms'");

        $this->db->query("DELETE FROM " . DB_PREFIX . "rooms_to_meta WHERE 'rooms_id=" . (int)$rooms_id . "'");

        $this->cache->delete('rooms');

        $this->event->trigger('post.admin.rooms.delete', $rooms_id);
    }

    public function getInformation($rooms_id) {
        $query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'rooms_id=" . (int)$rooms_id . "') AS keyword FROM " . DB_PREFIX . "rooms WHERE rooms_id = '" . (int)$rooms_id . "'");

        return $query->row;
    }

    public function getInformationByListId($rooms_ids=array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "rooms i LEFT JOIN " . DB_PREFIX . "rooms_description id ON (i.rooms_id = id.rooms_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        if(!empty($rooms_ids)) {
            $list_id = implode(',', $rooms_ids);
            $sql = "SELECT * FROM " . DB_PREFIX . "rooms i LEFT JOIN " . DB_PREFIX . "rooms_description id ON (i.rooms_id = id.rooms_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.rooms_id in(".$list_id.")";
            $query = $this->db->query($sql);
            return $query->rows;
        }
        return false;
    }

    public function getRooms($data = array()) {
        if ($data) {
            $sql = "SELECT * FROM " . DB_PREFIX . "rooms i LEFT JOIN " . DB_PREFIX . "rooms_description id ON (i.rooms_id = id.rooms_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

            if(isset($data['filter_rooms_type']))
                $sql.=' AND rooms_type="'.$data['filter_rooms_type'].'"';
            else
                $sql.=' AND rooms_type="rooms"';

            if(isset($data['filter_category_id']) && $data['filter_category_id']!=0)
                $sql.=' AND category_id="'.$data['filter_category_id'].'"';

            if(isset($data['exclude']))
                $sql.=' AND i.rooms_id <> "'.$data['exclude'].'"';

            if (!empty($data['filter_name'])) {
                $sql .= " AND id.title LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
            }

            $sort_data = array(
                'id.title',
                'i.sort_order'
            );

            if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $data['sort'];
            } else {
                $sql .= " ORDER BY id.title";
            }

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

            return $query->rows;
        } else {
            $rooms_data = $this->cache->get('rooms.' . (int)$this->config->get('config_language_id'));

            if (!$rooms_data) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "rooms i LEFT JOIN " . DB_PREFIX . "rooms_description id ON (i.rooms_id = id.rooms_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

                $rooms_data = $query->rows;

                $this->cache->set('rooms.' . (int)$this->config->get('config_language_id'), $rooms_data);
            }

            return $rooms_data;
        }
    }

    public function getInformationDescriptions($rooms_id) {
        $rooms_description_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "rooms_description WHERE rooms_id = '" . (int)$rooms_id . "'");
        $keyword_query = $this ->getInformationKeyword((int)$rooms_id);

        foreach ($query->rows as $result) {
            $rooms_description_data[$result['language_id']] = array(
                'title'            => $result['title'],
                'description'      => $result['description'],
                'meta_title'       => $result['meta_title'],
                'meta_description' => $result['meta_description'],
                'meta_keyword'     => $result['meta_keyword'],
                'keyword'          => isset($keyword_query[$result['language_id']]) ? $keyword_query[$result['language_id']]['keyword'] : $this->alias->generateSeoURL($this->db->escape($result['title']))
            );
        }

        return $rooms_description_data;
    }

    public function getInformationKeyword($rooms_id) {
        $rooms_keyword_data = array();
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->config->get('rooms')['request_id'] .'='. (int)$rooms_id  . "'");

        foreach ($query->rows as $result) {
            $rooms_keyword_data[$result['language_id']] = array(
                'query'         => $result['query'],
                'keyword'       => $result['keyword']
            );
        }
        return $rooms_keyword_data;
    }

    public function getInformationMeta($rooms_id) {
        $rooms_store_meta = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "rooms_to_meta WHERE rooms_id = '" . (int)$rooms_id . "'");
        foreach ($query->rows as $result) {
            $rooms_store_meta[$result['meta_key']] = $result['meta_value'];
        }

        return $rooms_store_meta;
    }

    public function getInformationLayouts($rooms_id) {
        $rooms_layout_data = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "rooms_to_layout WHERE rooms_id = '" . (int)$rooms_id . "'");

        foreach ($query->rows as $key=>$result) {
            $rooms_layout_data[$key] = $result['layout_id'];
        }

        return $rooms_layout_data;
    }

    public function getTotalRooms($data=array()) {
        $sql ="SELECT COUNT(*) AS total FROM " . DB_PREFIX . "rooms i LEFT JOIN " . DB_PREFIX . "rooms_description id ON (i.rooms_id = id.rooms_id) WHERE (1=1)";

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

    public function getTotalRoomsByLayoutId($layout_id) {
        $query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "rooms_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

        return $query->row['total'];
    }
}