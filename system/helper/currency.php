<?php
if (!function_exists('format_currency')) {

    function format_currency($value, $format = true) {
        $symbol_right  = ' VNĐ';
        $decimal_place = 0;

        $string = '';
        $string .= number_format(round($value, (int)$decimal_place), (int)$decimal_place, ',', '.');
        if (($symbol_right) && ($format)) {
            $string .= $symbol_right;
        }
        return $string;
    }
}

if (!function_exists('format_acreage')) {

    function format_acreage($value, $format = true) {
        $symbol_right  = ' m2';
        $decimal_place = 0;

        $string = '';
        $string .= number_format(round($value, (int)$decimal_place), (int)$decimal_place, ',', '.');
        if (($symbol_right) && ($format)) {
            $string .= $symbol_right;
        }
        return $string;
    }
}
