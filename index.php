<?php
// Version
define('VERSION', '2.0.3.1');
// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}

require 'vendor/autoload.php';

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Config
$config = new Config();
$registry->set('config', $config);

// Dom
//$domNode = new simple_html_dom();
//$registry->set('domNode', $domNode);

// Database
if(DB_DRIVER == 'mysqli') {
    //$db = new DB("mysqli", "124.158.14.30", "propzydeveloper", "DevPropzy2017!@#", "propzy_vietnam");
    //$query = $db->query("select Title,Photo,Address,CityID,DistrictID,Latitude,Longitude,ListingTypeName from listing where CityID = 1 limit 0,10000");
    $db = new DB(DB_DRIVER, DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE);
    $registry->set('db', $db);
}
if(DB_DRIVER == 'mongodb') {
    //$pass = rawurlencode("DevPropzy2017!@#");
    //$user = rawurlencode("propzydeveloper");
    //$dbName = rawurlencode("protal-cms-dev");
    //$connect = new \MongoDB\Client("mongodb://".$user.":".$pass."@124.158.14.30:27017/".$dbName);
    //$connect = $connect->selectDatabase("protal-cms-dev");

    $connect = new \MongoDB\Client();
    $connect = $connect->selectDatabase("rents_room");
    $registry->set('db', $connect);

    /*
    foreach ($query->rows as $item){
        $insert_data = array(
            'title'=>$item['Title'],
            'photo'=>$item['Photo'],
            'address'=>$item['Address'],
            'cityID'=>(int) $item['CityID'],
            'districtID'=>(int) $item['DistrictID'],
            'location'=>array(
                'type'=>'Point',
                'coordinates'=>array((float) $item['Longitude'],(float) $item['Latitude'])
            ),
            'cityID'=>$item['CityID'],
        );
        if(false)
            $connect->listing->insertOne($insert_data);
    }
    */
}

// Cache
$cache = new Cache('file');
$registry->set('cache', $cache);
// Settings
$setting = $cache->get('setting-cache');
if(!$setting) {
	$query = "query config by mongodb";
	$cache->set('setting-cache', 'Kết quả lấy từ mongdb');
	$setting=false;
}
if($setting && false) {
    foreach ($setting as $result) {
        if (!$result['serialized']) {
            $config->set($result['key'], $result['value']);
        } else {
            $config->set($result['key'], unserialize($result['value']));
        }
    }
}


$config->set('config_url', HTTP_SERVER);
$config->set('config_ssl', HTTPS_SERVER);

// Set seo
$config->set('config_seo_url', 1);

// Url
$url = new Url($config->get('config_url'), $config->get('config_secure') ? $config->get('config_ssl') : $config->get('config_url'));
$registry->set('url', $url);


// Log
$log = new Log('error.log');
$registry->set('log', $log);

function error_handler($errno, $errstr, $errfile, $errline) {
	global $log, $config;

	// error suppressed with @
	if (error_reporting() === 0) {
		return false;
	}

	switch ($errno) {
		case E_NOTICE:
		case E_USER_NOTICE:
			$error = 'Notice';
			break;
		case E_WARNING:
		case E_USER_WARNING:
			$error = 'Warning';
			break;
		case E_ERROR:
		case E_USER_ERROR:
			$error = 'Fatal Error';
			break;
		default:
			$error = 'Unknown';
			break;
	}

	if ($config->get('config_error_display')) {
		echo '<b>' . $error . '</b>: ' . $errstr . ' in <b>' . $errfile . '</b> on line <b>' . $errline . '</b>';
	}

	if ($config->get('config_error_log')) {
		$log->write('PHP ' . $error . ':  ' . $errstr . ' in ' . $errfile . ' on line ' . $errline);
	}

	return true;
}

// Error Handler
set_error_handler('error_handler');

// Request
$request = new Request();
$registry->set('request', $request);

// Response
$response = new Response();
$response->addHeader('Content-Type: text/html; charset=utf-8');
$response->setCompression($config->get('config_compression'));
$registry->set('response', $response);

// Session
$session = new Session();
$registry->set('session', $session);

// Document
$registry->set('document', new Document());

// Encryption
$registry->set('encryption', new Encryption($config->get('config_encryption')));

// Front Controller
$controller = new Front($registry);

// Maintenance Mode
//$controller->addPreAction(new Action('common/maintenance'));

// router
$routes = new Routes();
$registry->set('routes', $routes);
require_once(DIR_SYSTEM.'config/'. 'routes.php');
// SEO URL's
$controller->addPreAction(new Action('common/seo_url'));


// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} else {
	$action = new Action('common/home');
}

// Dispatch
$controller->dispatch($action, new Action('error/not_found'));
// Output
$response->output();
