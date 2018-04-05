<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 4/4/2018
 * Time: 4:45 PM
 */
$router =  $registry->get('routes');
$router->add(['/tim-kiem-theo-ban-do','find/map']);
$router->add(['/tim-kiem-theo-list','find/list']);

