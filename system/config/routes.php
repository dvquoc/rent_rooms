<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 4/4/2018
 * Time: 4:45 PM
 */
$router =  $registry->get('routes');
//detail rooms
$router->add(['/tim-kiem-theo-ban-do','find/map']);

$router->add(['/tim-kiem/phong-tro-gan-{special}/{lat},{lgn}','find/list']);
$router->add(['/tim-kiem/{city}/{district}','find/list']);

$router->add(['/tim-kiem/{city}','find/list']);
$router->add(['/phong-tro-{district}/{city}/{slug}-code-{id}','page/detail']);
//*******************************Owner******************************//
//Owner login
$router->add(['/ow-dang-nhap','page/owner/login']);
$router->add(['/ow-dang-nhap-fb','page/owner/login/fb_login']);
$router->add(['/ow-dang-nhap-google','page/owner/login/google_login']);
$router->add(['/ow-dang-nhap-form','page/owner/login/form_login']);
//Owner register
$router->add(['/ow-dang-ky','page/owner/register']);
$router->add(['/ow-dang-ky-fb','page/owner/register/fb_register']);
$router->add(['/ow-dang-ky-google','page/owner/register/google_register']);
$router->add(['/ow-dang-ky-form','page/owner/register/form_register']);
$router->add(['/ow-check-phone','page/owner/register/check_phone']);
$router->add(['/ow-update-phone','page/owner/register/submit_register']);
$router->add(['/ow-cap-nhap-thong-tin','page/owner/register/update_info']);

$router->add(['/thong-tin-chu-tro','page/owner/infoAccount']);
$router->add(['/cap-nhat-chu-tro','page/owner/infoAccount/update_account']);

//*********************************************************************//

//*******************************Customer******************************//
//Customer register
$router->add(['/cus-dang-ky','page/customer/register']);
$router->add(['/cus-dang-ky-fb','page/customer/register/fb_register']);
$router->add(['/cus-dang-ky-google','page/customer/register/google_register']);
$router->add(['/cus-dang-ky-form','page/customer/register/form_register']);
$router->add(['/cus-check-phone','page/customer/register/check_phone']);
$router->add(['/cus-update-phone','page/customer/register/submit_register']);
$router->add(['/cus-cap-nhap-thong-tin','page/customer/register/update_info']);
//Customer login
$router->add(['/cus-dang-nhap','page/customer/login']);
$router->add(['/cus-dang-nhap-fb','page/customer/login/fb_login']);
$router->add(['/cus-dang-nhap-google','page/customer/login/google_login']);
$router->add(['/cus-dang-nhap-form','page/customer/login/form_login']);

$router->add(['/thong-tin-tai-khoan','page/customer/infoAccount']);
$router->add(['/cap-nhat-tai-khoan','page/customer/infoAccount/update_account']);

//*********************************************************************//

//bassic login 
$router->add(['/dang-nhap','page/login']);

$router->add(['/dang-xuat','page/logout']);
$router->add(['/thong-tin-tai-khoan','page/infoAccount']);

$router->add(['/trang-chu','page/home']);

$router->add(['/them-phong-tro','page/rooms']);
$router->add(['/luu-phong-tro','page/rooms/add']);
$router->add(['/cap-nhat-phong-tro','page/rooms/edit']);
$router->add(['/danh-sach-quan-huyen/{id}','page/rooms/getDistricts']);












