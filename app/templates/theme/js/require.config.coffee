requirejs.config
    urlArgs : "?ver=#{Math.random()}"
    baseUrl : '../wp-content/themes/<%= themeNameSpace %>/js/'
    paths :
        jquery : 'bower_components/jquery/dist/jquery'