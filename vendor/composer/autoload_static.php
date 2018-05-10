<?php

// autoload_static.php @generated by Composer

namespace Composer\Autoload;

class ComposerStaticInitc03a015b260f4bbbaaed4cb6483aa5b9
{
    public static $files = array (
        '3a37ebac017bc098e9a86b35401e7a68' => __DIR__ . '/..' . '/mongodb/mongodb/src/functions.php',
    );

    public static $prefixLengthsPsr4 = array (
        'N' => 
        array (
            'Naucon\\Utility\\' => 15,
            'Naucon\\File\\' => 12,
        ),
        'M' => 
        array (
            'MongoDB\\' => 8,
        ),
    );

    public static $prefixDirsPsr4 = array (
        'Naucon\\Utility\\' => 
        array (
            0 => __DIR__ . '/..' . '/naucon/utility/src',
        ),
        'Naucon\\File\\' => 
        array (
            0 => __DIR__ . '/..' . '/naucon/file/src',
        ),
        'MongoDB\\' => 
        array (
            0 => __DIR__ . '/..' . '/mongodb/mongodb/src',
        ),
    );

    public static function getInitializer(ClassLoader $loader)
    {
        return \Closure::bind(function () use ($loader) {
            $loader->prefixLengthsPsr4 = ComposerStaticInitc03a015b260f4bbbaaed4cb6483aa5b9::$prefixLengthsPsr4;
            $loader->prefixDirsPsr4 = ComposerStaticInitc03a015b260f4bbbaaed4cb6483aa5b9::$prefixDirsPsr4;

        }, null, ClassLoader::class);
    }
}
