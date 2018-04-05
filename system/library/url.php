<?php
class Url {
	private $domain;
	private $ssl;
	private $rewrite = array();

	public function __construct($domain, $ssl = '') {
		$this->domain = $domain;
		$this->ssl = $ssl;
	}

	public function link_seo($link_seo, $secure = false) {
		if (!$secure) {
			$url = $this->domain;
		} else {
			$url = $this->ssl;
		}
		$url .=  $link_seo;
		return $url;
	}

    public function link($route, $args = '', $secure = false) {

        if (!$secure) {
            $url = $this->domain;
        } else {
            $url = $this->ssl;
        }

        $url .= 'index.php?route=' . $route;

        if ($args) {
            $url .= str_replace('&', '&amp;', '&' . ltrim($args, '&'));
        }

        return $url;
    }
}
