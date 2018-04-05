<?php
class ControllerCommonSeoUrl extends Controller {
    private $defined_seo_url=array();
    public function index() {
        if (!empty($this->request->get['_route_'])) {
            // Check lại dấu / ở phần đầu và phần cuối của _route_
            $router_define = $this->pareUrl('/'.$this->request->get['_route_']);
            $args =array();

            if($router_define && $this->config->get(config_seo_url)) {
                $this->request->get['route'] = $router_define['action'];
                $args = $router_define['action'];
            } else {
                $this->request->get['route'] = 'error/not_found';
            }
            return new Action($this->request->get['route'],$args);

        }elseif (!empty($this->request->get['route'])){
            // Not seo URL
            if(!isset($this->request->get['route'])){ // Set route cho trang lỗi khi không tìm thấy trang.
                $this->request->get['route'] = 'error/not_found';
            }
            // Chạy action với route đã lấy ở phía trên
            if (isset($this->request->get['route'])) {
                return new Action($this->request->get['route'],$args =array());
            }
        }else {
            $this->request->get['route'] = 'common/home';
            return new Action($this->request->get['route'],$args =array());
        }

    }
    public function pareUrl($url){
        foreach ($this->routes->get() as $item) {
            // Make regexp from route
            $patternAsRegex = $this->getRegex($item['0']);

            $array_router = array();
            if ($ok = !!$patternAsRegex) {
                // We've got a regex, let's parse a URL
                $ok = preg_match($patternAsRegex, $url, $matches);
                if ($ok) {
                    $array_router['params'] = array_intersect_key($matches, array_flip(array_filter(array_keys($matches), 'is_string')));
                    $array_router['action'] = $item[1];
                }
            }
            if ($ok)
                return $array_router;
        }
        return false;
    }
    public function getRegex($pattern){
        if (preg_match('/[^-:\/_{}()a-zA-Z\d]/', $pattern))
            return false; // Invalid pattern
        // Turn "(/)" into "/?"
        $pattern = preg_replace('#\(/\)#', '/?', $pattern);
        $allowedParamChars = '[a-zA-Z0-9\_\-]+';
        //Create capture group for ":parameter"
        $pattern = preg_replace(
            '/:(' . $allowedParamChars . ')/',   # Replace ":parameter"
            '(?<$1>' . $allowedParamChars . ')', # with "(?<parameter>[a-zA-Z0-9\_\-]+)"
            $pattern
        );
        // Create capture group for '{parameter}'
        $pattern = preg_replace(
            '/{('. $allowedParamChars .')}/',    # Replace "{parameter}"
            '(?<$1>' . $allowedParamChars . ')', # with "(?<parameter>[a-zA-Z0-9\_\-]+)"
            $pattern
        );
        return "@^" . $pattern . "$@D";
    }
}
