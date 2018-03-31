<?php
class ModelCatalogInformation extends Model {
	public function getInformation($information_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE i.information_id = '" . (int)$information_id . "' AND id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.status = '1'");

		return $query->row;
	}

	public function getInformations($data=array()) {
		$sql="SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id'). "' AND i.status = '1'";

		if (isset($data['filter_category_id'])) {
			$sql .= " AND category_id=".$data['filter_category_id'];
		}

		if (isset($data['filter_information_type'])) {
			$sql .= " AND information_type='".$data['filter_information_type']."'";
		}

        if(isset($data['exclude']))
            $sql.=' AND i.information_id <> "'.$data['exclude'].'"';

		$sql .= " GROUP BY i.information_id";
		$sort_data = array(
				'id.title',
				'i.sort_order',
		);
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'id.title') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(id.title) DESC";
		} else {
			$sql .= " ASC, LCASE(id.title) ASC";
		}

		if (isset($data['start']) && isset($data['limit'])) {
			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);
		return $query->rows;
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
    public function getInformationMeta($information_id) {
        $information_store_meta = array();

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_meta WHERE information_id = '" . (int)$information_id . "'");
        foreach ($query->rows as $result) {
            $data = $result['meta_value'];
            if($result['type'] == 'json')
                $data = json_decode(html_entity_decode($result['meta_value']));
            if($result['type'] == 'serialized')
                $data = unserialize($result['meta_value']);
            $information_store_meta[$result['meta_key']] = $data;
        }
        return $information_store_meta;
    }

	public function getFeatureInformations($data=array()) {
		$sql="SELECT * FROM " . DB_PREFIX . "information i LEFT JOIN " . DB_PREFIX . "information_description id ON (i.information_id = id.information_id)  WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' AND i.status = '1'";

		if (isset($data['filter_category_id'])) {
			$sql .= " AND category_id=".$data['filter_category_id'];
		}

		if (isset($data['filter_information_type'])) {
			$sql .= " AND information_type='".$data['filter_information_type']."'";
		}

		$sql .= " AND feature='1'";

		$sql .= " GROUP BY i.information_id";
		$sort_data = array(
				'id.title',
				'i.sort_order',
		);
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			if ($data['sort'] == 'id.title') {
				$sql .= " ORDER BY LCASE(" . $data['sort'] . ")";
			} else {
				$sql .= " ORDER BY " . $data['sort'];
			}
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC, LCASE(id.title) DESC";
		} else {
			$sql .= " ASC, LCASE(id.title) ASC";
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
	}

	public function getTotalInformations($data=array()) {

		$sql = "SELECT COUNT(DISTINCT i.information_id) AS total FROM " . DB_PREFIX . "information i WHERE (1=1)";

		if (isset($data['filter_category_id'])) {
			$sql .= " AND category_id=".$data['filter_category_id'];
		}

		if (isset($data['filter_information_type'])) {
			$sql .= " AND information_type='".$data['filter_information_type']."'";
		}

		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getInformationLayoutId($information_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "information_to_layout WHERE information_id = '" . (int)$information_id. "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}
}