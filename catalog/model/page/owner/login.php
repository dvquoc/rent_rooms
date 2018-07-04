 <?php

class ModelPageOwnerLogin extends Model {
    public function __construct($registry){
        parent::__construct($registry);
        $this->table = $this->db->owner;
    }
    
    public function get_user_by_social($source_id){
    	$oneResult = $this->table->findOne(['source_id'=>$id]);
    	if($oneResult){
    		return $oneResult;
    	}else
    		return 0;
    }

    public function get_user_by_id($id){
    	$oneResult = $this->table->findOne(['_id' => new MongoDB\BSON\ObjectId($id)]);
    	if($oneResult){
    		return $oneResult;
    	}else
    		return 0;
    }

    public function login_form($data){
        $oneResult = $this->table->findOne([
            'phone' => $data['phone'],
            'password' =>$data['password']
        ]);
        return $oneResult;
    }
}