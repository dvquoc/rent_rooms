<?php
abstract class Model {
	protected $registry;

	public function __construct($registry) {
		$this->registry = $registry;
		$this->_name_col = $registry->get('db')->query("SHOW COLUMNS FROM ".$this->_table)->rows;
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}

	public function __setStringUpdate($data) {
        $set_tring = '';
        foreach ($this->_name_col as $key => $item){
            if(isset($data[$item['Field']])){
                $type_compare =  preg_replace('/\(\d{1,}\)$/','',$item['Type']);
                $type  =  preg_grep("/^".$type_compare."$/"  , ['integer'=>'int', 'int'=>'tinyint', 'float'=>'float','double'=>'double']);
                $type = array_flip($type);
                if(!empty($type)){
                    settype($data[$item['Field']], $type[$type_compare]);
                    $value = $data[$item['Field']];
                }else{
                    $value = '\''.$data[$item['Field']] . '\'';
                }
                $set_tring .= "`".$item['Field']."`=". $value .',';
            }
        }
        return $set_tring;
	}
}