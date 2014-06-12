##
## The main dashboard App
##
define [ 'marionette', 'msgbus' ], ( Marionette, msgbus )->

    window.App = new Marionette.Application

    # Main app regions
    App.addRegions
        yourRegionName : '#your-region-id' # TODO: add page specific regions


    # The default route for app
    App.rootRoute = ""

    # Reqres handler to return a default region. If a controller is not explicitly specified a
    # region it will trigger default region handler
    msgbus.reqres.setHandler "default:region", ->
        App.mainContentRegion

    # Registers a controller instance
    msgbus.commands.setHandler "register:instance", ( instance, id ) ->
        App.register instance, id

    App.on "initialize:after", ( options ) ->
        App.startHistory()
        App.navigate( @rootRoute, trigger : true ) unless App.getCurrentRoute()

    App