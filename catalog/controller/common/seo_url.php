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
                $args = $router_define['params'];
            } elseif(!$router_define){
                $arrayPare = explode('/',$this->request->get['_route_']);
                $controler = $arrayPare[0].'/'.$arrayPare[1];
                $action = isset($arrayPare[2]) ? '/'.preg_replace("/[^a-zA-Z0-9]/",'',$arrayPare[2]):'';
                $this->request->get['route'] =  $controler.$action;
                // Get query form url
                parse_str($_SERVER['QUERY_STRING'], $queries);
                // Exclude route form $queries
                $args = array_diff_key($queries, ['route'=>'']);
            } else {
                $this->request->get['route'] = 'error/not_found';
            }
        }elseif (!empty($this->request->get['route'])){ // Not seo URL
            if(!isset($this->request->get['route'])){ // Set route cho trang lỗi khi không tìm thấy trang.
                $this->request->get['route'] = 'error/not_found';
            }
            // Get query form url
            parse_str($_SERVER['QUERY_STRING'], $queries);
            // Exclude route form $queries
            $args = array_diff_key($queries, ['route'=>'']);
        }else {
            $this->request->get['route'] = 'common/home';
        }
        return new Action($this->request->get['route'],$args);
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
        if (preg_match('/[^-:\/_{}()a-zA-Z\d\,\.]/', $pattern)){ // Check $pattern không có chuổi nàys
            return false; // Invalid pattern
        }
        // Turn "(/)" into "/?"
        $pattern = preg_replace('#\(/\)#', '/?', $pattern);

        // Cho phép các ký tự này trong mẫu
        $allowedParamChars = '[a-zA-Z0-9\_\-\,\.]+';

        //Khai báo theo ":parameter"
        $pattern = preg_replace(
            '/:(' . $allowedParamChars . ')/',   # Replace ":parameter"
            '(?<$1>' . $allowedParamChars . ')', # with "(?<parameter>[a-zA-Z0-9\_\-]+)"
            $pattern
        );

        // Khai báo theo '{parameter}'
        $pattern = preg_replace(
            '/{('. $allowedParamChars .')}/',    # Replace "{parameter}"
            '(?<$1>' . $allowedParamChars . ')', # with "(?<parameter>[a-zA-Z0-9\_\-]+)"
            $pattern
        );
        return "@^" . $pattern . "$@D";
    }
}
