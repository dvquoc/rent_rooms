 <?php

class ModelPageLogin extends Model {
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->owner;
    }
    
    public function get_user_by_social($source_id){
    	$OneResult = $this->table->findOne(['source_id'=>$id]);
    	if($OneResult){
    		return $OneResult;
    	}else
    		return 0;
    }

    public function get_user_by_id($id){
    	$OneResult = $this->table->findOne(['_id' => new MongoDB\BSON\ObjectId($id)]);
    	if($OneResult){
    		return $OneResult;
    	}else
    		return 0;
    }
}