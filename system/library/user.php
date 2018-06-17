<?php
class User {
	private $user_id;
	private $username;
	private $permission = array();

	public function __construct($registry) {
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		if (isset($this->session->data['user_id'])) {
			$user_query = $this->db->user->findOne([
			    '_id' => $this->session->data['user_id'],
			    'status' =>1,
            ]);
			if ($user_query) {
				$this->user_id = $user_query['_id'];
				$this->username = $user_query['username'];
				$this->user_group_id = $user_query['user_group_id'];
                $this->db->user->updateOne(
                    ['_id' => $user_query['_id']],
                    ['$set' => ['ip' => $this->request->server['REMOTE_ADDR']]]
                );
				$user_group_query = $this->db->user_group->findOne([
                    '_id' => $user_query['user_group_id'],
                ]);
				$permissions = unserialize($user_group_query['permission']);
				if (is_array($permissions)) {
					foreach ($permissions as $key => $value) {
						$this->permission[$key] = $value;
					}
				}
			} else {
				$this->logout();
			}
		}
	}

	public function login($username, $password) {
		$user_query = $this->db->user->findOne([
            'username' => $username,
            'password' => md5($password),
            'status' => 1,
        ]);
		if ($user_query) {
			$this->session->data['user_id'] = $user_query['_id'];
			$this->user_id = $user_query['_id'];
			$this->username = $user_query['username'];
			$this->user_group_id = $user_query['user_group_id'];

            $user_query = $this->db->user_group->findOne([
                '_id' => $user_query['user_group_id'],
            ]);
			$permissions = unserialize($user_query->permission);
			if (is_array($permissions)) {
				foreach ($permissions as $key => $value) {
					$this->permission[$key] = $value;
				}
			}
			return true;
		} else {
			return false;
		}
	}

	public function logout() {
		unset($this->session->data['user_id']);
		$this->user_id = '';
		$this->username = '';
	}

	public function hasPermission($key, $value) {
		if (isset($this->permission[$key])) {
			return in_array($value, $this->permission[$key]);
		} else {
			return false;
		}
	}

	public function isLogged() {
		return $this->user_id;
	}

	public function getId() {
		return $this->user_id;
	}

	public function getUserName() {
		return $this->username;
	}

	public function getGroupId() {
		return $this->user_group_id;
	}
}