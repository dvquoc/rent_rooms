<?php
class Url {
	private $domain;
	private $ssl;
	private $rewrite = array();

	public function __construct($domain, $ssl = '') {
		$this->domain = $domain;
		$this->ssl = $ssl;
	}

	public function link($link_seo, $args = array(), $secure = false) {
		if (!$secure) {
			$url = $this->domain;
		} else {
			$url = $this->ssl;
		}
		$url .=  $link_seo;

		if (!empty($args)) {
		    $query ='';
		    foreach ($args as $segment=>$value){
		        if(!empty($segment)){
                    $query.=$segment.'='.$value.'&';
                }else{
		            break;
                }
            }
            $url .= $query != '' ? '?'. $query : '';
		}
		return $url;
	}
}
