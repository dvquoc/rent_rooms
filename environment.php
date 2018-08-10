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
            define('URL_DB','mongodb://127.0.0.1:27017' );
        break;
    case "GOOGLE":
            define('URL_DB','mongodb://127.0.0.1:27017' );
            //define('URL_DB','mongodb://35.224.9.146:27017' );
        break;
    default:
            //define('URL_DB','mongodb://localhost:27017' );
            $user = rawurlencode("rooms");
            $pass = rawurlencode("123456");
            $dbName = rawurlencode("rents_room");
            define('URL_DB','mongodb://'.$user.':'.$pass.'@127.0.0.1:27017/'.$dbName);
        break;
}

