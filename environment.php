<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 7/11/2018
 * Time: 10:41 AM
 */
// Version
define('VERSION', '2.0.3.1');

define('ENV_SERVER', array('35.224.9.146' , 'conphong.com'));
define('ENV_NAME', array('GOOGLE' , 'PRODUCTION','LOCAL'));

// Set Environtment name
$server = array_search($_SERVER['SERVER_NAME'], ENV_SERVER, true);

if($server !== false){
    define('ENV', ENV_NAME[$server]);
}
else {
    define('ENV', "LOCAL");
}

switch (ENV) {
    case "PRODUCTION":
            define('IP_DB','conphong.com' );
        break;
    case "GOOGLE":
            define('IP_DB','35.224.9.146' );
        break;
    default:
            define('IP_DB','127.0.0.1' );
        break;
}

