<?php
class ControllerFindList extends Controller {
    public function index($param) {
        $this->load->model('find/list');
        $get_request = $this->request->get;
        $data_search = ['status'=>1];
        if(isset($get_request['gia']))
            $data_search['price'] = ((float) $get_request['gia']) * 1000000;
        if(isset($get_request['dien_tich']))
            $data_search['acreage'] = (float) $get_request['dien_tich'];

        if(isset($get_request['location'])){
            $array_location = explode(',',$get_request['location']);
            $point = (object) ['lat'=>(double) $array_location[0], 'lng'=>(double) $array_location[1]];
            $data_search['region'] = $this->drawCircle($point,3,1);
        }

        $data['rooms'] = $this->model_find_list->get_list($data_search);
        $data['featured'] = $this->model_find_list->get_list_featured();

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/find/list.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/find/list.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/find/list.tpl', $data));
        }
    }
    public function findMap(){
        $this->load->model('find/map');
        $data = array('data'=>null);
        $request = $this->request->post;
        if(!empty($request)) {
            $result = $this->model_find_map->regionListing(json_decode($request['region'],true));
            $data['data']['listing'] = $result['data_lagre'];
            $data['data']['listing_small'] = $result['data_small'];

        }
        $this->response->encodeJson($data);
    }
    public function drawCircle($point, $radius, $dir) {
        $d2r = pi() / 180;   // degrees to radians
        $r2d = 180 / pi();   // radians to degrees
        $earthsradius = 3963; // 3963 is the radius of the earth in miles

        $points = 32;

        // find the raidus in lat/lon
        $rlat = ($radius / $earthsradius) * $r2d;
        $rlng = $rlat / cos($point->lat * $d2r);

        $extp = [];
        if ($dir == 1) {
            $start = 0;
            $end = $points + 1; // one extra here makes sure we connect the path
        } else {
            $start = $points + 1;
            $end = 0;
        }
        for ($i = $start; ($dir == 1 ? $i < $end : $i > $end); $i = $i + $dir) {
            $theta = pi() * ($i / ($points / 2));
            $ey = $point->lng + ($rlng * cos($theta)); // center a + radius x * cos(theta)
            $ex = $point->lat + ($rlat * sin($theta)); // center b + radius y * sin(theta)
            $extp[$i]=[$ey,$ex];
        }
        return $extp;
   }
}