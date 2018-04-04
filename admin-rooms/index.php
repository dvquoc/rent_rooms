<?php
// Version
define('VERSION', '2.0.3.1');

// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}
// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}

// Startup
require_once(DIR_SYSTEM . 'startup.php');

// Registry
$registry = new Registry();

// Config
$config = new Config();
$registry->set('config', $config);

// Database
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
// Settings
$query = $db->query("SELECT * FROM " . DB_PREFIX . "setting");

foreach ($query->rows as $setting) {
	if (!$setting['serialized']) {
		$config->set($setting['key'], $setting['value']);
	} else {
		$config->set($setting['key'], unserialize($setting['value']));
	}
}

// Loader
$loader = new Loader($registry);
$registry->set('load', $loader);

// Url
$url = new Url(HTTP_SERVER, $config->get('config_secure') ? HTTPS_SERVER : HTTP_SERVER);
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
$registry->set('response', $response);

// Cache
$cache = new Cache('file');
$registry->set('cache', $cache);

// Session
$session = new Session();
$registry->set('session', $session);

// Language
$language = new Language();
$language->load(DIR_LANGUAGE."vietnamese/");
$registry->set('language', $language);

// Document
$registry->set('document', new Document());
// User
$registry->set('user', new User($registry));

// Front Controller
$controller = new Front($registry);

// Login
$controller->addPreAction(new Action('common/login/check'));

// Permission
$controller->addPreAction(new Action('error/permission/check'));

// Router
if (isset($request->get['route'])) {
	$action = new Action($request->get['route']);
} else {
	$action = new Action('common/dashboard');
}
// Dispatch
$controller->dispatch($action, new Action('error/not_found'));

// Output
$response->output();