<?php

/**
 * Class ControllerFindList
 * type_page: ['search-city','search-district','search-special']
 *
 */
class ControllerFindList extends Controller {
    public function index($params) {
        $this->load->model('find/list');
        $get_request = $this->request->get;


        if(isset($_COOKIE['user_location'])){
            $params;
        }else{
            $semengts = explode('/',$get_request['_route_']);
        }

        //var_dump($params); die();
        $data['type_page']=false;
        $data['info_seo']=false;

        $data_search = ['status'=>1];
        if(isset($get_request['gia']))
            $data_search['price'] = ((float) $get_request['gia']) * 1000000;

        if(isset($get_request['dien_tich']))
            $data_search['acreage'] = (float) $get_request['dien_tich'];

        $data['breadcrumbs']=  array([
            'text'=>'Tìm phòng trọ',
            'href'=>'/'
        ]);

        if(isset($params['city'])){
            $data_search['slug_city_name'] = $params['city'];
            $cityInfoByCache = $this->cache->get('city-cache-'.$params['city']);
            $data['type_page']='search-city';
            $data['info_seo'] = $cityInfoByCache;
            $data['breadcrumbs'][] = [
                'text'=>$cityInfoByCache['name'],
                'href'=>'/tim-kiem/'.$params['city']
            ];
        }

        if(isset($params['district'])){
            if($cityInfoByCache){
                $data['type_page']='search-district';
                $data_search['slug_district_name'] = $params['district'];
                $districtInfoByCache = $this->cache->get('district-of-city-'.$cityInfoByCache['city_id'].'-cache');
                $data['info_seo'] = $districtInfoByCache;
                $data['breadcrumbs'][] = [
                    'text'=>$districtInfoByCache['name'],
                    'href'=>'/tim-kiem/'.$params['city'].'/'.$params['district']
                ];
            }
        }

        if(isset($params['lat']) && isset($params['lgn'])){
            $data['type_page']='search-special';
            $data['point'] = $point =  ['lat'=>(double) $params['lat'], 'lgn'=>(double) $params['lgn']];
            $data_search['point'] = [(double) $params['lgn'],(double) $params['lat']];
            $data['info_seo'] = ['Get from database by location from url'];
        }

        //var_dump($data['breadcrumbs']); die();

        /* Document get info page */

        //var_dump($data_search) ; die();
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
            $ey = $point->lgn + ($rlng * cos($theta)); // center a + radius x * cos(theta)
            $ex = $point->lat + ($rlat * sin($theta)); // center b + radius y * sin(theta)
            $extp[$i]=[$ey,$ex];
        }
        return $extp;
   }
    public function saveSpecial(){
        $this->load->model('location/special');

        $request_post = $this->request->post;
        $input = [
            'name'            => $request_post['name'],
            'district_id'     => $request_post['district_name'],
            'city_id'         => $request_post['city_name'],
            'view'            => 0,
            'area'            =>null,
            'location'        =>[
                    'type' => 'Point',
                    'coordinates'=>[float($request_post['lng']),float($request_post['lat'])]
            ],
            'adrress'         =>$request_post['address'],
            'seo_key'         =>'phòng trọ '.$request_post['name'],
            'seo_discription' =>"Phòng trọ gần ".$request_post['name']."sẽ giúp cho bạn thuận tiện việc đi lại"
        ];
        var_dump($input); die();
        $result = $this->model_location_special->add($input);
        $this->session->data['success'] = $this->language->get('text_success');
    }
}