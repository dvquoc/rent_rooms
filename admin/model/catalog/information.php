<?php
class ModelCatalogInformation extends Model {
	public function addInformation($data) {
		$this->event->trigger('pre.admin.information.add', $data);

		$sql="INSERT INTO " . DB_PREFIX . "information SET sort_order = '" . (int)$data['sort_order']. "', category_id = '" . (isset($data['category_id']) ? (int)$data['category_id'] : 0) . "', status = '" . (int)$data['status'] . "', image = '" . $data['image']. "', feature = '" . $data['feature']. "'";

		if(!empty($data['information_type']))
			$sql.=", information_type = '" . $this->objects->object_type."'";

		if(!empty($data['information_images']))
			$sql.=", information_images = '" . serialize($data['information_images'])."'";

		if(!empty($data['information_tages']))
			$sql.=", information_tags = '" . serialize($data['information_tags'])."'";

		$this->db->query($sql);

		$information_id = $this->db->getLastId();

        foreach ($data['information_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "information_description SET information_id = '" . (int)$information_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");

            $keyword = $this->alias->generateSeoURL($value['keyword']);
            if(!empty($value['keyword']))
                $keyword=$this->alias->generateSeoURL($this->db->escape($value['title']));

            $query_check_keyword = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $keyword . "'");

            if($query_check_keyword->row)
                $keyword = $this->config->get($this->objects->object_type.'_information')['prefix_alias'] . $keyword;

            $text_query = $this->config->get($this->objects->object_type.'_information')['request_id'] .'='. (int)$information_id;

            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET object_type ='".$this->objects->object_type."', type='information', query = '".$text_query."', keyword = '".$keyword. "', `language_id`='".(int)$language_id."'");
        }



		if (isset($data['information_layout'])) {
			foreach ($data['information_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "information_to_layout SET information_id = '" . (int)$information_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}

		if (isset($data['meta_data'])) {
			foreach ($data['meta_data'] as $key => $item_data) {
                $result = json_decode(html_entity_decode($item_data));
                if (json_last_error() === JSON_ERROR_NONE) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "information_to_meta SET information_id = '" . (int)$information_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='json'");
                }
                elseif(is_array($item_data)) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "information_to_meta SET information_id = '" . (int)$information_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='serializer'");
                }else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "information_to_meta SET information_id = '" . (int)$information_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='default'");
                }
			}
		}


		$this->cache->delete('information');
		$this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));

		$this->event->trigger('post.admin.information.add', $information_id);

		return $information_id;
	}

	public function editInformation($information_id, $data) {

		$this->event->trigger('pre.admin.information.edit', $data);

		$sql="UPDATE " . DB_PREFIX . "information SET sort_order = '" . (int)$data['sort_order']. "', category_id = '" . (isset($data['category_id']) ? (int)$data['category_id'] : 0) . "', status = '" . (int)$data['status'] ."', image = '" . $data['image']. "', feature = '" . $data['feature']."'";

		if(!empty($data['information_type']))
			$sql.=", information_type = '" . $data['information_type']."'";

		if(!empty($data['information_images']))
			$sql.=", information_images = '" . serialize($data['information_images'])."'";

		if(!empty($data['information_tags']))
			$sql.=", information_tags = '" . serialize($data['information_tags'])."'";

		$sql.=" WHERE information_id = '" . (int)$information_id . "'";


		$this->db->query($sql);

		$this->db->query("DELETE FROM " . DB_PREFIX . "information_description WHERE information_id = '" . (int)$information_id . "'");

		$text_query = $this->config->get($this->objects->object_type.'_information')['request_id'] .'='. (int)$information_id;
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '".$text_query."'");

		foreach ($data['information_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "information_description SET information_id = '" . (int)$information_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
            $keyword = $this->alias->generateSeoURL($value['keyword']);
            if(!empty($value['keyword']))
			    $keyword=$this->alias->generateSeoURL($this->db->escape($value['title']));

			$query_check_keyword = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $keyword . "'");

            if($query_check_keyword->row)
                $keyword = $this->config->get($this->objects->object_type.'_information')['prefix_alias'] . $keyword;

			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET object_type ='".$this->objects->object_type."', type='information', query = '".$text_query."', keyword = '".$keyword. "', `language_id`='".(int)$language_id."'");
		}




		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "'");

		if (isset($data['information_layout'])) {
			foreach ($data['information_layout'] as $store_id => $layout_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "information_to_layout SET information_id = '" . (int)$information_id . "', layout_id = '" . (int)$layout_id . "'");
			}
		}
		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_meta WHERE information_id = '" . (int)$information_id . "'");
		if (isset($data['meta_data'])) {
			foreach ($data['meta_data'] as $key => $item_data) {
                $result = json_decode(html_entity_decode($item_data));
                if (json_last_error() === JSON_ERROR_NONE) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "information_to_meta SET information_id = '" . (int)$information_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='json'");
                }
                elseif(is_array($item_data)) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "information_to_meta SET information_id = '" . (int)$information_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape(serialize($item_data)) . "', type='serializer'");
                }else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "information_to_meta SET information_id = '" . (int)$information_id . "', `meta_key` = '" . $key . "', `meta_value` = '" . $this->db->escape($item_data) . "', type='default'");
                }
			}
		}

		$this->cache->delete('information');
		$this->cache->delete('alias-cache-'.$this->config->get('config_language_id'));

		$this->event->trigger('post.admin.information.edit', $information_id);
	}

	public function deleteInformation($information_id) {
		$this->event->trigger('pre.admin.information.delete', $information_id);

		$this->db->query("DELETE FROM " . DB_PREFIX . "information WHERE information_id = '" . (int)$information_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "information_description WHERE information_id = '" . (int)$information_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "'");
        // TODO: warning - Xóa trường hợp keyword trùng  => Prefix.
		$text_query = $this->config->get($this->objects->object_type.'_information')['request_id']."=" . (int)$information_id;
		$this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = '".$text_query."' AND object_type='".$this->objects->object_type."' AND type='information'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "information_to_meta WHERE 'information_id=" . (int)$information_id . "'");

		$this->cache->delete('information');

		$this->event->trigger('post.admin.information.delete', $information_id);
	}

	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT keyword FROM " . DB_PREFIX . "url_alias WHERE query = 'information_id=" . (int)$information_id . "') AS keyword FROM " . DB_PREFIX . "information WHERE information_id = '" . (int)$information_id . "'");

		return $query->row;
	}

    public function getInformationByListId($information_ids=array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";
        if(!empty($information_ids)) {
            $list_id = implode(',', $information_ids);
            $sql = "SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.information_id in(".$list_id.")";
            $query = $this->db->query($sql);
            return $query->rows;
        }
        return false;
    }

	public function getInformations($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

			if(isset($data['filter_information_type']))
				$sql.=' AND information_type="'.$data['filter_information_type'].'"';
			else
				$sql.=' AND information_type="information"';

			if(isset($data['filter_category_id']) && $data['filter_category_id']!=0)
				$sql.=' AND category_id="'.$data['filter_category_id'].'"';

            if(isset($data['exclude']))
                $sql.=' AND i.information_id <> "'.$data['exclude'].'"';

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
			$information_data = $this->cache->get('information.' . (int)$this->config->get('config_language_id'));

			if (!$information_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

				$information_data = $query->rows;

				$this->cache->set('information.' . (int)$this->config->get('config_language_id'), $information_data);
			}

			return $information_data;
		}
	}

	public function getInformationDescriptions($information_id) {
		$information_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_description WHERE information_id = '" . (int)$information_id . "'");
		$keyword_query = $this ->getInformationKeyword((int)$information_id);

		foreach ($query->rows as $result) {
			$information_description_data[$result['language_id']] = array(
				'title'            => $result['title'],
				'description'      => $result['description'],
				'meta_title'       => $result['meta_title'],
				'meta_description' => $result['meta_description'],
				'meta_keyword'     => $result['meta_keyword'],
                'keyword'          => isset($keyword_query[$result['language_id']]) ? $keyword_query[$result['language_id']]['keyword'] : $this->alias->generateSeoURL($this->db->escape($result['title']))
			);
		}

		return $information_description_data;
	}

    public function getInformationKeyword($information_id) {
        $information_keyword_data = array();
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->config->get('information')['request_id'] .'='. (int)$information_id  . "'");

        foreach ($query->rows as $result) {
            $information_keyword_data[$result['language_id']] = array(
                'query'         => $result['query'],
                'keyword'       => $result['keyword']
            );
        }
        return $information_keyword_data;
    }

	public function getInformationMeta($information_id) {
		$information_store_meta = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_meta WHERE information_id = '" . (int)$information_id . "'");
		foreach ($query->rows as $result) {
			$information_store_meta[$result['meta_key']] = $result['meta_value'];
		}

		return $information_store_meta;
	}

	public function getInformationLayouts($information_id) {
		$information_layout_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id . "'");

		foreach ($query->rows as $key=>$result) {
			$information_layout_data[$key] = $result['layout_id'];
		}

		return $information_layout_data;
	}

	public function getTotalInformations($data=array()) {
		$sql ="SELECT COUNT(*) AS total FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE (1=1)";

		if(isset($data['filter_information_type']))
			$sql.=' AND information_type="'.$data['filter_information_type'].'"';

		if(isset($data['filter_category_id']) && $data['filter_category_id']!=0)
			$sql.=' AND category_id="'.$data['filter_category_id'].'"';

		if (!empty($data['filter_name'])) {
			$sql .= " AND id.title LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getTotalInformationsByLayoutId($layout_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "information_to_layout WHERE layout_id = '" . (int)$layout_id . "'");

		return $query->row['total'];
	}
}