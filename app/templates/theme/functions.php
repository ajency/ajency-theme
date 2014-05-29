<?php
/**
 * <%= themeNameSpace %> functions file
 *
 * @package    WordPress
 * @subpackage <%= themeNameSpace %>
 * @since      <%= themeNameSpace %> 1.0
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

add_action( 'setup_theme', '<%= themeNameSpace %>_theme_setup' );


function <%= themeNameSpace %>_after_init() {

    show_admin_bar( FALSE );
}

add_action( 'init', '<%= themeNameSpace %>_after_init' );


if ( is_development_environment() ) {

    function <%= themeNameSpace %>_dev_enqueue_scripts() {

        wp_enqueue_script( "requirejs",
            get_template_directory_uri() . "/js/bower_components/requirejs/require.js",
            array(),
            get_current_version(),
            TRUE );

        wp_enqueue_script( "require-config",
            get_template_directory_uri() . "/js/require.config.js",
            array( "requirejs" ) );

        $module = get_module_name();

        wp_enqueue_script( "$module-script",
            get_template_directory_uri() . "/js/{$module}.scripts.js",
            array( "require-config" ) );

        // TODO: Add support for GLOBAL variables like, AJAXURL, SITEURL
        // TODO: Decide on basic global variales required for all projects

    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_dev_enqueue_scripts' );

    function <%= themeNameSpace %>_dev_enqueue_styles() {

        $module = get_module_name();

        wp_enqueue_style( "$module-script", get_template_directory_uri() . "/css/{$module}.styles.css" );

    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_dev_enqueue_styles' );
}

if ( !is_development_environment() ) {

    function <%= themeNameSpace %>_production_enqueue_script() {

        $module = get_module_name();
        $path   = get_template_directory_uri() . "/production/js/{$module}.scripts.min.js";

        if ( is_single_page_app() )
            $path = get_template_directory_uri() . "/production/spa/{$module}.spa.min.js";

        wp_enqueue_script( "$module-script",
            $path,
            array(),
            get_current_version(),
            TRUE );

    }

    add_action( 'wp_enqueue_scripts', '<%= themeNameSpace %>_production_enqueue_script' );

    function <%= themeNameSpace %>_production_enqueue_styles() {

        $module = get_module_name();

        wp_enqueue_style( "$module-styles",
            get_template_directory_uri() . "/production/css/{$module}.styles.min.css",
            array(),
            get_current_version(),
            TRUE );

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

function is_single_page_app() {
    // TODO: Application logic to identify if current page is a SPA

    return FALSE;

}


function get_module_name() {

    $module = "";

    // TODO: Handle with better logic here. Regex or something
    if ( is_page() )
        $module = sanitize_title( get_the_title() );


    return $module;
}