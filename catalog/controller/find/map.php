<?php
class ControllerFindMap extends Controller {
    public function index($params) {
        $this->load->model('find/map');
        $this->load->model('find/list');
        $this->load->model('location/location');
        $this->load->model('location/special');

        $get_request = $this->request->get;

        $data['type_page'] = false;
        $data['info_seo'] = false;
        $url = '';

        $data_search = ['status' => 1];
        if (isset($get_request['gia'])){
            $price = explode('-',$get_request['gia']);
            $data_search['price'] = $price;
        }

        if (isset($get_request['dien_tich'])){
            $area = explode('-',$get_request['dien_tich']);
            $data_search['acreage'] = $area;
        }


        $data['district_in_city'] = [];
        $data['city'] = [];
        $data['specials'] = [];

        /* Check is search special */
        if (isset($params['lat']) && isset($params['lgn'])) {
            $data['type_page'] = 'search-special';
            $data['point'] = $point = [
                'lat' => (double)$params['lat'],
                'lgn' => (double)$params['lgn']
            ];
            $data_search['point'] = [
                (double)$params['lgn'],
                (double)$params['lat']
            ];
            $data['specials'] = $this->model_location_special->get_list($data_search);
            $data['info_seo'] = $this->model_location_special->getOneByLatLgn($data_search['point']);
            if(!empty($data['info_seo'])){
            $url="/phong-tro-gan-".$data['info_seo']['slug'].'/'.$params['lat'].','.$params['lgn'];
            }else{
                if (isset($_COOKIE['special_search'])) {
                    $info_special = json_decode($_COOKIE['special_search'], true);
                    $url="/phong-tro-gan-".$info_special['slug'].'/'.$params['lat'].','.$params['lgn'];
                }
            }
        }

        /* Check search is city */
        if (isset($params['city'])) {
            $data_search['slug_city_name'] = $params['city'];
            $cityInfoByCache = $this->cache->get('city-cache-' . $params['city']);
            $data['type_page'] = 'search-city';
            $data['info_seo'] = $cityInfoByCache;
            $url="/".$data['info_seo']['slug_city'];
            $data['specials'] = $this->model_location_special->getSpecialByCity($cityInfoByCache['city_id']);
        }

        $data['district_in_city'] = $this->model_location_location->getDistrictByCity($data['info_seo']['city_id']);
        $data['city'] = $this->model_location_location->getCityById($data['info_seo']['city_id']);

        /* Check search is district */
        if (isset($params['district'])) {
            if ($cityInfoByCache) {
                $data['type_page'] = 'search-district';
                $data_search['slug_district_name'] = $params['district'];
                $districtInfoByCache = $this->model_location_location->get_district_by_slug($params['district'], $cityInfoByCache->city_id);
                $data['info_seo'] = $districtInfoByCache;
                $url.="/".$data['info_seo']['slug_district'];
                $data['specials'] = $this->model_location_special->getSpecialByDistrict($districtInfoByCache->district_id);
            }
        }

        /* Document get info page */
        //var_dump($data['info_seo']); die();
        $this->document->setTitle($data['info_seo']['name']);
        $this->document->setDescription($data['info_seo']['meta_description']);
        $this->document->setKeywords($data['info_seo']['meta_keyword']);
        $this->document->addLink("/map-tim-kiem".$url, 'canonical');


        $data['url'] = $url;
        $data['zoom']=15;
        $data['center']= isset($data['info_seo']['location']['coordinates']) ? $data['info_seo']['location']['coordinates'] : [10.7751766,106.6808529] ;
        $data['polygon']= isset($data['info_seo']['polygon']['coordinates']) ? $data['info_seo']['polygon']['coordinates'] : [] ;
        $data['listing'] = $this->model_find_list->get_list($data_search);


        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/find/map.tpl')) {
            $this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/find/map.tpl', $data));
        } else {
            $this->response->setOutput($this->load->view('default/template/find/map.tpl', $data));
        }
    }
    public function findMap(){
        $this->load->model('find/map');
        $data = array('data'=>null);
        $request = $this->request->post;
        if(!empty($request)){
            $result = $this->model_find_map->regionListing(json_decode($request['region'],true));
            $data['data']['listing'] = $result['data_lagre'];
            $data['data']['listing_small'] = $result['data_small'];
        }
        $this->response->encodeJson($data);
    }
}