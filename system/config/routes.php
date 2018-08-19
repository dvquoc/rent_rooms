<?php
/**
 * Created by PhpStorm.
 * User: User
 * Date: 4/4/2018
 * Time: 4:45 PM
 */
$router =  $registry->get('routes');

// Find width map
$router->add(['/map-tim-kiem/phong-tro-gan-{special}/{lat},{lgn}','find/map']);
$router->add(['/map-tim-kiem/{city}/{district}','find/map']);
$router->add(['/map-tim-kiem/{city}','find/map']);
// Find width list
$router->add(['/tim-kiem/phong-tro-gan-{special}/{lat},{lgn}','find/list']);
$router->add(['/tim-kiem/{city}/{district}','find/list']);
$router->add(['/tim-kiem/{city}','find/list']);
$router->add(['/sap-xep','find/list/setSort']);


//detail rooms
$router->add(['/phong-tro-{district}/{city}/{slug}-code-{id}','page/detail']);
//*******************************Owner******************************//
//Owner login
$router->add(['/dang-nhap-chu-phong','page/owner/login']);
$router->add(['/dang-nhap-fb-chu-phong','page/owner/login/fb_login']);
$router->add(['/dang-nhap-google-chu-phong','page/owner/login/google_login']);
$router->add(['/dang-nhap-form-chu-phong','page/owner/login/form_login']);
//Owner register 
$router->add(['/dang-ky-chu-phong','page/owner/register']);
$router->add(['/dang-ky-fb-chu-phong','page/owner/register/fb_register']);
$router->add(['/dang-ky-google-chu-phong','page/owner/register/google_register']);
$router->add(['/dang-ky-form-chu-phong','page/owner/register/form_register']);
$router->add(['/kiem-tra-sdt-chu-phong','page/owner/register/check_phone']);
$router->add(['/cap-nhat-sdt-chu-phong','page/owner/register/submit_register']);
$router->add(['/cap-nhap-thong-tin-chu-phong','page/owner/register/update_info']);

$router->add(['/thong-tin-chu-tro','page/owner/infoAccount']);
$router->add(['/cap-nhat-chu-tro','page/owner/infoAccount/update_account']);

//*********************************************************************//

//*******************************Customer******************************//
//Customer register
	// $router->add(['/cus-dang-ky','page/customer/register']);
	// $router->add(['/cus-dang-ky-fb','page/customer/register/fb_register']);
	// $router->add(['/cus-dang-ky-google','page/customer/register/google_register']);
	// $router->add(['/cus-dang-ky-form','page/customer/register/form_register']);
	// $router->add(['/cus-check-phone','page/customer/register/check_phone']);
	// $router->add(['/cus-update-phone','page/customer/register/submit_register']);
	// $router->add(['/cus-cap-nhap-thong-tin','page/customer/register/update_info']);
//Customer login
	// $router->add(['/cus-dang-nhap','page/customer/login']);
	// $router->add(['/cus-dang-nhap-fb','page/customer/login/fb_login']);
	// $router->add(['/cus-dang-nhap-google','page/customer/login/google_login']);
	// $router->add(['/cus-dang-nhap-form','page/customer/login/form_login']);

	// $router->add(['/thong-tin-tai-khoan','page/customer/infoAccount']);
	// $router->add(['/cap-nhat-tai-khoan','page/customer/infoAccount/update_account']);

//*********************************************************************//

//bassic login 
$router->add(['/dang-nhap','page/login']);

$router->add(['/dang-xuat','page/logout']);
$router->add(['/thong-tin-tai-khoan','page/infoAccount']);

$router->add(['/trang-chu','page/home']);
//*********************************************************************//
$router->add(['/them-phong-tro/{id}','page/rooms']);
$router->add(['/them-phong-tro','page/rooms']);
$router->add(['/luu-phong-tro','page/rooms/add']);
$router->add(['/cap-nhat-phong-tro/{id}','page/rooms/edit']);
$router->add(['/xoa-phong-tro','page/rooms/delete']);
$router->add(['/danh-sach-quan-huyen/{id}','page/rooms/getDistricts']);
$router->add(['/quan-ly-phong-tro','page/rooms/getList']);
$router->add(['/dia-chi-phong-tro','page/rooms/getAddress']);













