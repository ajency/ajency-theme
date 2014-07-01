"use strict"
util = require "util"
yeoman = require "yeoman-generator"
_s = require 'underscore.string'

ModuleGenerator = yeoman.generators.Base.extend

    init : ( type ) ->

        if type is undefined
            console.log "Please specify the module type: theme or SPA"
            return

        @pkg = require "../package.json"

        @_askFor type

    _askFor : ( type )->
        cb = @async()

        prompts = [
            {
                name : "moduleName"
                message : "Name of the module you want to create?"
            }
            {
                name : "templateAuthor"
                message : "Author name: name (email) "
            }
        ]

        @prompt prompts, ( props ) =>
            { @moduleName, @templateAuthor } = props
            @slugifiedModuleName = _s.slugify @moduleName
            if type is 'theme'
                @_createThemeModule()
            else
                @_createSPAModule()
            cb()

    _createSPAModule : ->
        # setup all files
        @template "module.scripts.coffee", "#{@slugifiedModuleName}.scripts.coffee"
        @template "template-wp.php", "../template-#{@slugifiedModuleName}.php"
        @template "module.styles.less", "../css/#{@slugifiedModuleName}.styles.less"
        @_createWPPage @moduleName

    _createThemeModule : ->

        # setup all files
        @template "module.spa.coffee", "#{@slugifiedModuleName}.spa.coffee"
        @template "module.app.coffee", "pages/#{@slugifiedModuleName}.app.coffee"
        @template "template-wp.php", "../template-#{@slugifiedModuleName}.php"
        @template "module.styles.less", "../css/#{@slugifiedModuleName}.styles.less"
        @_createWPPage @moduleName


    _createWPPage: ( moduleName )->
        # create a wordpress page
        spawnCommand = require 'spawn-command'
        spawnCommand "wp post create --post_type=page --post_status=publish --post_title='#{moduleName}'"
        console.log "created page #{moduleName}. Assign the template from dashboard"



module.exports = ModuleGenerator
