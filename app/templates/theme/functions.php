<?php
/**
 * <%= themeNameSpace %> functions file
 *
 * @package    WordPress
 * @subpackage <%= themeNameSpace %>
 * @since      <%= themeNameSpace %> 0.0.1
 */

function <%= themeNameSpace %>_theme_setup() {

    // load language
    load_theme_textdomain( '<%= themeNameSpace %>', get_template_directory() . '/languages' );

    // add theme support
    add_theme_support( 'post-formats', array( 'image', 'quote', 'status', 'link' ) );
    add_theme_support( 'post-thumbnails' );
    add_theme_support( 'menus' );
    add_theme_support( 'automatic-feed-links' );
    add_theme_support( 'html5', array( 'search-form', 'comment-form', 'comment-list' ) );

    // define you image sizes here
    add_image_size( '<%= themeNameSpace %>-full-width', 1038, 576, TRUE );

    // This theme uses its own gallery styles.
    add_filter( 'use_default_gallery_style', '__return_false' );

}

add_action( 'after_setup_theme', '<%= themeNameSpace %>_theme_setup' );


function <%= themeNameSpace %>_after_init() {

    show_admin_bar( FALSE );
}

add_action( 'init', '<%= themeNameSpace %>_after_init' );


if (is_development_environment()) {

    function <%= themeNameSpace %>_dev_enqueue_scripts() {

        // TODO: handle with better logic to define patterns and folder names
        $module = get_module_name();

        $pattern     = 'scripts';
        $folder_path = 'js/src';

        if ( is_single_page_app( $module ) ) {
            $pattern     = 'spa';
            $folder_path = 'spa/src';
        }

        wp_enqueue_script( "requirejs",
                            get_template_directory_uri() . "/js/bower_components/requirejs/require.js",
                            array(),
                            get_current_version(),
                            TRUE );

        wp_enqueue_script( "require-config",
                            get_template_directory_uri() . "/{$folder_name}/require.config.js",
                            array( "requirejs" ),
                            get_current_version(),
                            TRUE );


        wp_enqueue_script( "$module-script",
                            get_template_directory_uri() . "/{$folder_name}/{$module}.{$pattern}.js",
                            array( "require-config" ),
                            get_current_version(),
                            TRUE );

        // localized variables
        wp_localize_script( "requirejs", "SITEURL", site_url() );
        wp_localize_script( "requirejs", "AJAXURL", admin_url( "admin-ajax.php" ) );
        wp_localize_script( "requirejs", "UPLOADURL", admin_url( "async-upload.php" ) );
        wp_localize_script( "requirejs", "_WPNONCE", wp_create_nonce( 'media-form' ) );
    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_dev_enqueue_scripts' );

    function <%= themeNameSpace %>_dev_enqueue_styles() {

        $module = get_module_name();

        wp_enqueue_style( "$module-style", get_template_directory_uri() . "/css/{$module}.styles.css" );

    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_dev_enqueue_styles' );
}

if (!is_development_environment()) {

    function <%= themeNameSpace %>_production_enqueue_script() {

        $module = get_module_name();

        if (is_single_page_app( $module ))
            $path = get_template_directory_uri() . "/production/spa/{$module}.spa.min.js";
        else
            $path = get_template_directory_uri() . "/production/js/{$module}.scripts.min.js";

        wp_enqueue_script( "$module-script",
                            $path,
                            array(),
                            get_current_version(),
                            TRUE );

        // localized variables
        wp_localize_script( "$module-script", "SITEURL", site_url() );
        wp_localize_script( "$module-script", "AJAXURL", admin_url( "admin-ajax.php" ) );
        wp_localize_script( "$module-script", "UPLOADURL", admin_url( "async-upload.php" ) );
        wp_localize_script( "$module-script", "_WPNONCE", wp_create_nonce( 'media-form' ) );

    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_production_enqueue_script' );

    function <%= themeNameSpace %>_production_enqueue_styles() {

        $module = get_module_name();

        wp_enqueue_style( "$module-style",
                            get_template_directory_uri() . "/production/css/{$module}.styles.min.css",
                            array(),
                            get_current_version(),
                            "all" );

    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_production_enqueue_styles' );
}


function is_development_environment() {

    if ( defined( 'ENV' ) && ENV === "production" )
        return FALSE;

    return TRUE;
}


function get_current_version() {

    global $wp_version;

    if ( defined( 'VERSION' ) )
        return VERSION;

    return $wp_version;

}

function is_single_page_app( $module_name ) {

    // add slugs of SPA pages here
    $spa_pages = array();

    return in_array( $module_name, $spa_pages );

}


function get_module_name() {

    $module = "";

    // TODO: Handle with project specific logic here to define module names
    if ( is_page() )
        $module = sanitize_title( get_the_title() );

    return $module;

}