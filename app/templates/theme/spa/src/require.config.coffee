# load all the scripts required for SPA
requirejs.config
   urlArgs : "?ver=#{Math.random()}"
   baseUrl : '../wp-content/themes/<%= themeNameSpace %>/spa'
   paths :
      jquery : 'src/bower_components/jquery/dist/jquery'
      backbone : 'src/bower_components/backbone/backbone'
      underscore : 'src/bower_components/underscore/underscore'
      marionette : 'src/bower_components/marionette/lib/core/backbone.marionette'
      mustache : 'src/bower_components/mustache/mustache'
      text : 'src/bower_components/requirejs-text/text'
      backbonesyphon : 'src/bower_components/backbone.syphon/lib/amd/backbone.syphon'
      'backbone.wreqr' : 'src/bower_components/backbone.wreqr/lib/backbone.wreqr'
      'backbone.babysitter' : 'src/bower_components/backbone.babysitter/lib/backbone.babysitter'
      plupload : 'src/bower_components/plupload/js/plupload.full.min'
      jasmineajax : 'src/bower_components/jasmine-ajax/lib/mock-ajax'
      jasminejquery : 'src/bower_components/jasmine-jquery/lib/jasmine-jquery'
      jqueryvalidate : 'src/bower_components/jquery.validation/dist/jquery.validate'
      plupload : 'src/bower_components/plupload/js/plupload.full.min'
      backboneassociations : 'src/bower_components/backbone-associations/backbone-associations'
      bootstraptour : 'src/bower_components/bootstrap-tour/build/js/bootstrap-tour.js'
      underscorestring : 'src/bower_components/underscore.string/lib/underscore.string'
      jqueryvalidate : 'src/bower_components/jquery.validation/dist/jquery.validate'
      extm : 'src/bower_components/extm/lib/extm.amd'
   shim :
      jquery : [ 'underscore' ]
      underscorestring : [ 'underscore' ]
      backbone : [ 'jquery', 'underscore' ]
      marionette :
         deps : [ 'backbone', 'backbone.wreqr', 'backbone.babysitter' ]
      backbonesyphon : [ 'backbone' ]
      backboneassociations : [ 'backbone' ]
      jqueryvalidate : [ 'jquery' ]
      bootstrap : [ 'jquery' ]
      bootstraptour : [ 'bootstrap' ]
      jasminejquery : [ 'jquery' ]
      jasmineajax : [ 'jquery' ]
      plupload :
         deps : [ 'jquery' ]
         exports : 'plupload'