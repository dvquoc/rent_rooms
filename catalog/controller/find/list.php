<?php
/**
 * Class ControllerFindList
 * type_page: ['search-city','search-district','search-special']
 *
 */
class ControllerFindList extends Controller {
    public function index($params) {
        $this->load->model('find/list');
        $this->load->model('location/location');
        $this->load->model('location/special');

        $get_request = $this->request->get;
        if (isset($_COOKIE['user_location'])) {
            $params;
        } else {
            $semengts = explode('/', $get_request['_route_']);
        }

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

        $data['breadcrumbs'] = array([
            'text' => 'Tìm phòng trọ',
            'href' => '/'
        ]);

        $data['district_in_city'] = [];
        $data['city'] = [];
        $data['specials'] = [];

        /* Check is search special */
        if (isset($params['lat']) && isset($params['lgn'])) {
            $data['type_page'] = 'search-special';
            $data['has_point'] = true;
            $data['point'] = $point = [
                'lat' => (double)$params['lat'],
                'lng' => (double)$params['lgn']
            ];
            $data_search['point'] = [
                (double)$params['lgn'],
                (double)$params['lat']
            ];
            $data['specials'] = $this->model_location_special->get_list($data_search);
            $data['info_seo'] = $this->model_location_special->getOneByLatLgn($data_search['point']);

            if(!empty($data['info_seo'])){
                $data['breadcrumbs'][] = [
                    'text' => 'Gần ' . $data['info_seo']['name'],
                    'href' => ''
                ];
                $url="/phong-tro-gan-".$data['info_seo']['slug'].'/'.$params['lat'].','.$params['lgn'];
            }else{
                if (isset($_COOKIE['special_search'])) {
                    $info_special = json_decode($_COOKIE['special_search'], true);
                    $data['breadcrumbs'][] = [
                        'text' => 'Gần ' . $info_special['name'],
                        'href' => ''
                    ];
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
            $data['breadcrumbs'][] = [
                'text' => $cityInfoByCache['name'],
                'href' => '/tim-kiem/' . $params['city']
            ];
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
                $data['breadcrumbs'][] = [
                    'text' => $districtInfoByCache['name'],
                    'href' => '/tim-kiem/' . $params['city'] . '/' . $params['district']
                ];
                $url.="/".$data['info_seo']['slug_district'];
                $data['specials'] = $this->model_location_special->getSpecialByDistrict($districtInfoByCache->district_id);
            }
        }

        /* Document get info page */
        //var_dump($data['info_seo']); die();
        $this->document->setTitle($data['info_seo']['name']);
        $this->document->setDescription($data['info_seo']['meta_description']);
        $this->document->setKeywords($data['info_seo']['meta_keyword']);
        $this->document->addLink("/tim-kiem".$url, 'canonical');
        //$this->document->addScript('catalog/view/javascript/jquery/tabs.js');
        //$this->document->addStyle('catalog/view/javascript/jquery/colorbox/colorbox.css');
        $data['rooms'] = $this->model_find_list->get_list($data_search);
        $data['list_content'] = $this->load->view('part/content/list_content', $data);

        $data['featured'] = $this->model_find_list->get_list_featured();
        $data['url'] = $url;

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        $this->response->setOutput($this->load->view('find/list', $data));
    }

    public function findMap()
    {
        $this->load->model('find/map');
        $data = array('data' => null);
        $request = $this->request->post;
        if (!empty($request)) {
            $result = $this->model_find_map->regionListing(json_decode($request['region'], true));
            $data['data']['listing'] = $result['data_lagre'];
            $data['data']['listing_small'] = $result['data_small'];

        }
        $this->response->encodeJson($data);
    }

    public function drawCircle($point, $radius, $dir)
    {
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
            $extp[$i] = [$ey, $ex];
        }
        return $extp;
    }

    public function saveSpecial() {
        $this->load->model('location/special');
        $this->load->model('location/location');
        $request_post = $this->request->post;

        $citys = $this->model_location_location->getAllCity();
        $city = $district = null;
        foreach ($citys as $item) {
            if (preg_match("/[(.*?)\s]?" . $request_post['city_name'] . "$/mi", $item['name'], $matches)) {
                $city = $item;
                break;
            }
        }

        if (!$city)
            exit();

        $districts = $this->model_location_location->getDistrictByCity((int)$city['city_id']);
        foreach ($districts as $item) {
            if (preg_match("/[(.*?)\s]?" . $request_post['district_name'] . "$/mi", $item['name'], $matches)) {
                $district = $item;
                break;
            }
        }

        if (!$district)
            exit();

        $types = [
            "university"      =>"Trường đại học", // 
            "school"          =>"Trường học",
            "company"         =>"Công ty",
            "industrial_area" =>"Khu công nghiệp",
            "strees"          =>"Đường xá",
            "supermarket"     =>"Trung tâm thương mại",
            "market"          =>"Chợ",
            "other"           =>"Khác",
            "undefined"       =>"Chưa biết"
        ];
        $check = $this->model_location_special->getOne(['place_id' => $request_post['place_id']]);
        if (empty($check)) {
            $input = [
                'name'        => $request_post['name'],
                'district_id' => (int) $district['district_id'],
                'city_id'     => (int) $city['city_id'],
                'view'        => 1,
                'area'        => null,
                'place_id'    => $request_post['place_id'],
                'types_source' => $request_post['types'],
                'types'       => "undefined",
                'location'    => [
                    'type'        => 'Point',
                    'coordinates' => [(float)$request_post['lng'], (float)$request_post['lat']]
                ],
                'source'           => 'font-end',
                'adrress'          => $request_post['address'],
                'slug'             => $request_post['slug'],
                'meta_keyword'     => 'phòng trọ ' . $request_post['name'],
                'meta_description' => "Phòng trọ gần " . $request_post['name'] . " sẽ giúp cho bạn thuận tiện việc đi lại"
            ];
            $result = $this->model_location_special->add($input);
        } else {
            $result = $this->model_location_special->update($check->place_id, ['view' => ++ $check->view]);
        }
        exit();
    }
}