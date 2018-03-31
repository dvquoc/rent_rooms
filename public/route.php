<?php
// Dvquoc difine
$GLOBALS['oject_alias']=array();
foreach($default_object_project as $object){
    if(!empty($object['alias_url']))
        foreach($object['alias_url'] as $key=>$item){
            $item['object_type']=$object['alias_name'];
            $oject_alias[$object['alias_name']][$key]=$item;
        }
}

//echo "<pre>";
//print_r($oject_alias);
//echo "</pre>";
//die();
