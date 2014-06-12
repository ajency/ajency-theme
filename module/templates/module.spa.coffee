# set all plugins for this SPA here
define "plugins-loader", [ 'underscore'
                           'jquery'
                           'bootstrap'
                           'backbone'
                           'marionette'
                           'backbonesyphon'
                           'jqueryvalidate' ], ->

# set all plugin configurations for this SPA here
define "config-loader", [ 'configs/backbone.config'
                          'configs/marionette.config'
                          'configs/jquery.config' ], ->

# add your apps to load here
define "apps-loader", []

# add your components to load here
define "components-loader", [ 'components/loading/controller' ]

# add you entities
define "entitites-loader", []

# define 'app'
define "app", [ 'pages/<%= slugifiedModuleName %>.app' ], ( App ) ->
    App

# All Done, Load all in browser and start the App
require [ 'plugins-loader'
          'config-loader'
          'app'
          'components-loader'
          'entitites-loader'
          'apps-loader' ], ( p, c, App ) ->

    App.start()