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
$router->add(['/phong-tro-{district}/{city}/{slug}-code-{id}','page/detail']);
$router->add(['/dang-nhap','page/login']);
$router->add(['/dang-nhap-fb','page/login/fb_login']);
$router->add(['/dang-nhap-google','page/login/google_login']);
$router->add(['/dang-ky','page/register']);
$router->add(['/dang-ky-fb','page/register/fb_register']);
$router->add(['/dang-ky-google','page/register/google_register']);
$router->add(['/dang-ky-form','page/register/form_register']);

$router->add(['/cap-nhap-thong-tin','page/register/update_info']);
$router->add(['/test','page/register/submit_register']);









