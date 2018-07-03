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
$router->add(['/dang-nhap-form','page/login/form_login']);

$router->add(['/dang-ky','page/register']);
$router->add(['/dang-ky-fb','page/register/fb_register']);
$router->add(['/dang-ky-google','page/register/google_register']);
$router->add(['/dang-ky-form','page/register/form_register']);
$router->add(['/check-phone','page/register/check_phone']);
$router->add(['/test','page/register/submit_register']);
$router->add(['/dang-ky-2','page/register/register_customer']);
$router->add(['/dang-ky-form-2','page/register/form_register_2']);



$router->add(['/cap-nhap-thong-tin','page/register/update_info']);
$router->add(['/dang-xuat','page/logout']);
$router->add(['/thong-tin-tai-khoan','page/infoAccount']);
$router->add(['/cap-nhat','page/infoAccount/update_account']);













