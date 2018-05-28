<?php
class ModelUserUser extends Model {
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->user;
    }

	public function addUser($data) {
        return $this->table->insertOne([
            'username' => $data['username'],
            'image' => $data['image'],
            'user_group_id' => new MongoDB\BSON\ObjectId($data['user_group_id']),
            'password' => md5($data['password']),
            'firstname' => $data['firstname'],
            'lastname' => $data['lastname'],
            'email' =>$data['email'],
            'status' => (int) $data['status'],
            'date_added' => new MongoDB\BSON\UTCDateTime((new dateTime())->getTimestamp())
        ]);
	}

	public function editUser($user_id, $data) {
        $data_set = [
            'username' => $data['username'],
            'image' => $data['image'],
            'user_group_id' => new MongoDB\BSON\ObjectId($data['user_group_id']),
            'firstname' => $data['firstname'],
            'lastname' => $data['lastname'],
            'email' =>$data['email'],
            'status' => (int) $data['status'],
        ];
        //var_dump($data_set); die();
        return $this->table->updateOne(
            ['user_id' => new MongoDB\BSON\ObjectId($user_id)],
            ['$set' => $data_set]
        );
		if ($data['password']) {
            return $this->table->updateOne(
                ['user_id' => new MongoDB\BSON\ObjectId($user_id)],
                ['$set' => ['password' => md5($data['password'])]]
            );
		}
	}

	public function editPassword($user_id, $password) {
		$this->db->query("UPDATE `" . DB_PREFIX . "user` SET salt = '" . $this->db->escape($salt = substr(md5(uniqid(rand(), true)), 0, 9)) . "', password = '" . $this->db->escape(sha1($salt . sha1($salt . sha1($password)))) . "', code = '' WHERE user_id = '" . (int)$user_id . "'");
	}

	public function editCode($email, $code) {
		$this->db->query("UPDATE `" . DB_PREFIX . "user` SET code = '" . $this->db->escape($code) . "' WHERE LCASE(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");
	}

	public function deleteUser($user_id) {
		$this->db->query("DELETE FROM `" . DB_PREFIX . "user` WHERE user_id = '" . (int)$user_id . "'");
	}

	public function getUser($user_id) {
        return $this->table->findOne([
            '_id' => new MongoDB\BSON\ObjectId($user_id),
        ]);
	}

	public function getUserByUsername($username) {
        return $this->db->user->findOne([
            'username' => $username,
        ]);
	}

	public function getUsers($data = array()) {
        $filter = [];
        $options =[
            'skip'       => isset($data['start']) ? $data['start']:0,
            'limit'      => isset($data['limit']) ? $data['limit']:20,
            'sort'       => ['user_id'=>-1],
        ];
        return $this->table->find($filter, $options)->toArray();
	}

	public function getTotalUsers() {
        $filter =[];
        $options =[];
        return $this->table->count($filter, $options);
	}

	public function getTotalUsersByGroupId($user_group_id) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "user` WHERE user_group_id = '" . (int)$user_group_id . "'");

		return $query->row['total'];
	}

	public function getTotalUsersByEmail($email) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "user` WHERE LCASE(email) = '" . $this->db->escape(utf8_strtolower($email)) . "'");

		return $query->row['total'];
	}
}