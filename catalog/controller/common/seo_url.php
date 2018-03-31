<?php
class ControllerCommonSeoUrl extends Controller {
    private $defined_seo_url=array();
    public function index() {
        //inclue router
        global $oject_alias;
        $this->defined_seo_url=$oject_alias;
        // Add rewrite to url class
        if ($this->config->get('config_seo_url')) {
            $this->url->addRewrite($this);
        }
        // Decode URL
        if (isset($this->request->get['_route_'])) {
            
            if(!isset($this->request->get['route'])){ // Set route cho trang lỗi khi không tìm thấy trang.
                $this->request->get['route'] = 'error/not_found';
            }
            // Chạy action với route đã lấy ở phía trên
            if (isset($this->request->get['route'])) {
                return new Action($this->request->get['route']);
            }

        }
    }

    public function rewrite($link) { // Cái này của Dvquoc viết.

        $url_info = parse_url(str_replace('&amp;', '&', $link));

        $url = array();

        $data = array();

        parse_str($url_info['query'], $data);

        foreach ($data as $key => $value) {
            if (isset($data['route']) && $data['route']!='common/home') {
                foreach($this->defined_seo_url as $item_object){
                foreach($item_object as $type_url => $item_defined){
                    if($key == $item_defined['request_id'] && $key!="route"){
                        $list_id = explode('_', $value); // Danh sách các id của một đối tượng page. Trong OC thì trường hợp này sảy ra cho path của danh mục.
                        foreach ($list_id as $item) {

                            $keyword=$this->alias->get($item_defined['request_id']."=".$item);

                            if ($keyword && $keyword['type'] == $type_url && $keyword['object_type'] == $item_defined['object_type']) {

                                $url[] =$keyword['query'];

                                unset($data[$key]);

                            }elseif($key=='code' && !empty($value)){
                                $url[] = 'xem-demo-'.$value;
                                unset($data[$key]);

                            }else{
                                break;
                            }

                        }

                    }
                }
                }
                if($key=='route') { // Không thể gộp diều kiện trên vì xóa $data[$key] mỗi khi ok. và cấu trúc là ví dụ: Common/abc chứ không phải là query_id=8.

                    $keyword=$this->alias->get($data['route']);

                    if ($keyword) {
                        $url[] = $keyword['query'];
                    }
                }
            }else{
                break;
            }
        }

        $url="/".implode('/', $url);

        if ($url!="/") {
            unset($data['route']);
            $query = '';
            if ($data) {
                foreach ($data as $key => $value) {
                    $query .= '&' . rawurlencode((string)$key) . '=' . rawurlencode((string)$value);
                }
                if ($query) {
                    $query = '?' . str_replace('&', '&amp;', trim($query, '&'));
                }
            }
            return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url.'.html' . $query;
        } else {
            if($data['route'] && $data['route']=='common/home')
                $link=str_replace('/index.php?route=common/home','',$link);
            return $link;
        }
    }
}
