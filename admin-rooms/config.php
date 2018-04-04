<?php
$folder='';
define('URL_HOME','http://'.$_SERVER['HTTP_HOST'].$folder);
define('URL_HOMES','https://'.$_SERVER['HTTP_HOST'].$folder);
define('DIR_HOME',dirname(dirname(__FILE__))."");
// HTTP
define('HTTP_SERVER', URL_HOME.'/admin-rooms/');
define('HTTP_CATALOG', URL_HOME.'/');

// HTTPS
define('HTTPS_SERVER', URL_HOMES.'/admin-rooms/');
define('HTTPS_CATALOG', URL_HOMES.'/');

// DIR
define('DIR_APPLICATION', DIR_HOME.'/admin-rooms/');
define('DIR_PUBLIC', DIR_HOME.'/public/');
define('DIR_SYSTEM', DIR_HOME.'/system/');
define('DIR_LANGUAGE', DIR_HOME.'/admin-rooms/language/');
define('DIR_TEMPLATE', DIR_HOME.'/admin-rooms/view/template/');
define('DIR_TEMPLATE_PUBLIC', DIR_HOME.'/public/view/');
define('DIR_CONFIG', DIR_HOME.'/system/config/');
define('DIR_IMAGE', DIR_HOME.'/image/');
define('DIR_CACHE', DIR_HOME.'/system/cache/');
define('DIR_DOWNLOAD', DIR_HOME.'/system/download/');
define('DIR_UPLOAD', DIR_HOME.'/system/upload/');
define('DIR_LOGS', DIR_HOME.'/system/logs/');
define('DIR_MODIFICATION', DIR_HOME.'/system/modification/');
define('DIR_CATALOG', DIR_HOME.'/catalog/');

// DB
define('DB_DRIVER', 'mysqli');
if(DB_DRIVER == 'mongodb') {
    define('DB_HOSTNAME', 'localhost');
    define('DB_USERNAME', 'root');
    define('DB_PASSWORD', '');
    define('DB_DATABASE', 'admin');
    define('DB_PORT', '27017');
    define('DB_PREFIX', 'asdh1_');
}else{
    define('DB_HOSTNAME', 'localhost');
    define('DB_USERNAME', 'root');
    define('DB_PASSWORD', 'root');
    define('DB_DATABASE', 'rent_rooms');
    define('DB_PORT', '3306');
    define('DB_PREFIX', 'bahara_');
}