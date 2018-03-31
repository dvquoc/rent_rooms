<?php
abstract class Controller {
    protected $registry;
    public function __construct($registry) {
        if(isset($registry->get('request')->get['object_type'])) {
            // Set type object hiện tại;
            $registry->get('objects')->setObjectType($registry->get('request')->get['object_type']);
            // Get data của object hiện tại;
            $registry->set('object_current', $registry->get('objects')->get($registry->get('request')->get['object_type']));
        }
        $this->registry = $registry;
    }

    public function __get($key) {
        return $this->registry->get($key);
    }

    public function __set($key, $value) {
        $this->registry->set($key, $value);
    }
}