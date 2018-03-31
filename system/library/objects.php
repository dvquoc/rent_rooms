<?php
class Objects {
    private $data = array();
    private $object_type_default = 'default';
    public $object_type = 'default';

    public function get($key) {
            return (isset($this->data[$key]) ? $this->data[$key] : null);
    }
    public function set($key, $value) {
            $this->data[$key] = $value;
    }
    public function has($key) {
            return isset($this->data[$key]);
    }
    public function dataObject(){
        return (!empty($this->data) ? $this->data : null);
    }

    public function typeDefault(){
        return $this->object_type_default;
    }
    public function setObjectType($type){
        if(isset($this->data[$type]))
            $this->object_type=$type;
    }

}