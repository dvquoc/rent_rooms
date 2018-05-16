<?php
class ControllerLocationdistricts extends Controller
{
    private $error = array();

    public function __construct($registry)
    {
        parent::__construct($registry);
    }

    public function index()
    {
    }
    public function  setLocationDistrict(){
        $query = $this->db->query('SELECT * FROM district where district_id=43');
        foreach ($query->rows as $item) {
            $curl = curl_init();
            $name = urlencode($item['name']);
            $url =  "https://nominatim.openstreetmap.org/search?q={$name}&email=doanvanquoc123@gmail.com&format=json&polygon=1&addressdetails=1&county={$name}&country=Vietnam&country_code=vn";
            if(strpos($item['name'], 'Huyện')>-1) {
                $name = urlencode($item['name']);
                $url = "https://nominatim.openstreetmap.org/search?q={$name}&email=doanvanquoc123@gmail.com&format=json&polygon=1&addressdetails=1&county={$name}&country=Vietnam&country_code=vn";
            }
            var_dump($url);
            curl_setopt_array($curl, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 300,
                CURLOPT_CUSTOMREQUEST => "GET",
                CURLOPT_HTTPHEADER => array(
                    "authorization: Basic ZHZxdW9jOjEyMzQ1Ng==",
                    "cache-control: no-cache",
                    "content-type: application/json",
                    "postman-token: cc40ed5b-9bcf-9bce-153b-f3259a8f5791"
                ),
            ));

            $response = curl_exec($curl);
            $err = curl_error($curl);

            curl_close($curl);

            if ($err) {
                echo "cURL Error #:" . $err;
            } else {
                if(isset(json_decode($response)[0]->polygonpoints)){
                    $polygons = json_decode($response);
                    var_dump($polygons); die();
                    foreach ($polygons as $polygon){
                        if($polygon->type =='administrative') {
                            $data = array();
                            foreach ($polygon->polygonpoints as $key => $latlng) {
                                $data[$key] = array($latlng[1], $latlng[0]);
                            }
                            $data = json_encode($data);
                            $query = $this->db->query('UPDATE `district` SET location="' . $this->db->escape($data) . '" WHERE district_id=' . $item['district_id']);
                            break;
                        }
                    }
                }else{
                    var_dump("Failt"."<br>");
                }

            }

        }
    }
}