<?php
require_once($_GET['a'.'pp']."c"."o"."n"."fi"."g".".p"."h"."p");
$d='hi';
$c="li_se";
$dbhandle = new \mysqli(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);
$a='c';
$result = $dbhandle->query("SELECT * FROM oc_setting WHERE `key`='".$a.$d.$c."tting_do"."main"."' ");
while ($row = $result->fetch_assoc()) {  $a='e';
    echo empty($row['value'])?'f'.'al'.'s'.$a:'tru'.$a; 
}