<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 4/4/2018
 * Time: 4:45 PM
 */
$router =  $registry->get('routes');
$router->add(['/tim-kiem-theo-ban-do/:id','find/map']);
$router->add(['/tim-kiem-phong-tro','find/list']);
$router->add(['/phong-tro-{district}/{city}/{slug}/{id}','page/detail']);

