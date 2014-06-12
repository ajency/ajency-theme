"use strict"
util = require "util"
yeoman = require "yeoman-generator"
_s = require 'underscore.string'

ModuleGenerator = yeoman.generators.Base.extend

    init : (args, name) ->
        @pkg = require("../package.json")

    askFor : ->
        cb = @async()

        prompts = [
            {
                name : "moduleName"
                message : "Name of the module you want to create?"
            }
            {
                name : "templateAuthor"
                message : "Template author name( Format: name (email) )  "
            }
        ]

        @prompt prompts, (props) =>
            { @moduleName, @templateAuthor } = props
            @slugifiedModuleName  = _s.slugify @moduleName
            cb()

    createSPAModule:->
        # setup all files
        @template "module.spa.coffee",  "#{@slugifiedModuleName}.spa.coffee"
        @template "module.app.coffee",  "pages/#{@slugifiedModuleName}.app.coffee"
        @template "template-wp.php",  "../template-#{@slugifiedModuleName}.php"
        @template "module.styles.less",  "../css/#{@slugifiedModuleName}.styles.less"

        # create a wordpress page
        spawnCommand = require 'spawn-command'
        spawnCommand "wp post create --post_type=page --post_status=publish --post_title='#{@moduleName}'"

module.exports = ModuleGenerator
