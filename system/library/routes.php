<?php
class Routes {
	private $routes = array();

	public function get() {
        return $this->routes;
	}
	public function add($route = array()) {
			$this->routes[] = $route;
	}

	public function generateSeoURL($string, $wordLimit = 0){
        $separator = '-';
		$string = mb_strtolower($string,'UTF-8');
		$string=$this->vn_str_filter($string);
		if($wordLimit != 0){
			$wordArr = explode(' ', $string);
			$string = implode(' ', array_slice($wordArr, 0, $wordLimit));
		}
		$quoteSeparator = preg_quote($separator, '#');

		$trans = array(
				'&.+?;'                    => '',
				'[^\w\d _-]'            => '',
				'\s+'                    => $separator,
				'('.$quoteSeparator.')+'=> $separator
		);
		$string = strip_tags($string);
		foreach ($trans as $key => $val){
			$string = preg_replace('#'.$key.'#i'.(true ? 'u' : ''), $val, $string);
		}
		return trim($string);
	}

	public function vn_str_filter ($str){
		$unicode = array(
				'a'=>'á|à|ả|ã|ạ|ă|ắ|ặ|ằ|ẳ|ẵ|â|ấ|ầ|ẩ|ẫ|ậ',
				'd'=>'đ',
				'e'=>'é|è|ẻ|ẽ|ẹ|ê|ế|ề|ể|ễ|ệ',
				'i'=>'í|ì|ỉ|ĩ|ị',
				'o'=>'ó|ò|ỏ|õ|ọ|ô|ố|ồ|ổ|ỗ|ộ|ơ|ớ|ờ|ở|ỡ|ợ',
				'u'=>'ú|ù|ủ|ũ|ụ|ư|ứ|ừ|ử|ữ|ự',
				'y'=>'ý|ỳ|ỷ|ỹ|ỵ',
		);
		foreach($unicode as $nonUnicode=>$uni){
			$str = preg_replace("/($uni)/i", $nonUnicode, $str);
		}
		return $str;
	}
}