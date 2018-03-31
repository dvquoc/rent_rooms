<?php
abstract class Model {
	protected $registry;

	public function __construct($registry) {
		$this->registry = $registry;
		if(isset($registry->get('request')->get['object_type']))
			$registry->get('objects')->setObjectType($registry->get('request')->get['object_type']);
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
}