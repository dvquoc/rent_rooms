<?php

/**
 * HybridAuth
 * http://hybridauth.sourceforge.net | http://github.com/hybridauth/hybridauth
 * (c) 2009-2015, HybridAuth authors | http://hybridauth.sourceforge.net/licenses.html
 */
// ----------------------------------------------------------------------------------------
//	HybridAuth Config file: http://hybridauth.sourceforge.net/userguide/Configuration.html
// ----------------------------------------------------------------------------------------

return array(
    "base_url" => "http://localhost/vendor/hybridauth/hybridauth/hybridauth",
    "providers" => array(
        // openid providers
        "Google" => array(
            "enabled" => true,
            "keys" => array("id" => "891127608934-v3bl5s8ru5obrlor07jda6b6esca2297.apps.googleusercontent.com", "secret" => "io9Y_ygYMTNpHqgPsU8otCeA"),
             "scope"   => "https://www.googleapis.com/auth/plus.login ". // optional
                       "https://www.googleapis.com/auth/plus.me ". // optional
                       "https://www.googleapis.com/auth/plus.profile.emails.read", // optional
              "access_type"     => "offline",   // optional
              "approval_prompt" => "force",     // optional
        ),
        "Facebook" => array(
            "enabled" => true,
            "keys" => array("id" => "2119353828347192", "secret" => "871c2e33986cb65cb48d5e83fc3b271b"),
            'scope'   => 'email,user_birthday,user_location,user_gender,user_photos',
            'trustForwarded' => false
        ),
    ),
    // If you want to enable logging, set 'debug_mode' to true.
    // You can also set it to
    // - "error" To log only error messages. Useful in production
    // - "info" To log info and error messages (ignore debug messages)
    "debug_mode" => false,
    // Path to file writable by the web server. Required if 'debug_mode' is not false
    "debug_file" => "",
);
