"use strict"
util = require("util")
path = require("path")
yeoman = require("yeoman-generator")
yosay = require("yosay")
chalk = require("chalk")

AjencyWpThemeGenerator = yeoman.generators.Base.extend

    init : ->

        @pkg = require("../package.json")

        afterNPMInstallComplete = =>
            process.chdir "../js/"
            console.log "Installing theme bower components"
            @installDependencies
                skipInstall : @options["skip-install"]
                npm : false
                callback : afterThemeBowerInstallComplete

        afterThemeBowerInstallComplete = =>
            process.chdir "../SPA/"
            console.log "Installing SPA bower components"
            @installDependencies
                skipInstall : @options["skip-install"]
                npm : false

        @on "end", ->
            if @themeNameSpace
                process.chdir @themeNameSpace + "/grunt/"
                console.log "Installing grunt modules"
                @installDependencies
                    skipInstall : @options["skip-install"]
                    bower : false
                    callback : afterNPMInstallComplete

    askFor : ->
        cb = @async()

        console.log "Ajency.in Logo/Name comming soon :P"

        prompts = [
            {
                name : "themeName"
                message : "Name of the theme you want to create?"
            }
            {
                name : "themeNameSpace"
                message : "Uniq name-space for the theme (foldername)?"
                default : (answers) ->
                    answers.themeName.replace(/\W/g, "").toLowerCase()
            }
            {
                name : "themeAuthor"
                message : "Name of the themes author?"
                default : "Team Ajency"
            }
            {
                name : "themeAuthorURI"
                message : "Website of the themes authors?"
                default : "http://ajency.in/team"
            }
            {
                name : "themeURI"
                message : "Website of the theme?"
                default : "http://ajency.in/"
            }
            {
                type : "checkbox"
                name : "themeTags"
                message : "Theme tags ( more available on wordpress.org )?"
                choices : [
                    "dark"
                    "light"
                ]
            }
            {
                name : "themeDescription"
                message : "Description of the theme?"
                default : (answers) ->
                    "This is a description for the " + answers.themeName + " theme."
            }
            {
                name : "githubRepo"
                message : "Github repository path"
                default : (answers)->
                    "http://github.com/ajency/#{answers.themeNameSpace}"
            }
        ]
        @prompt prompts, ((props) ->
            @themeName = props.themeName
            @themeNameSpace = props.themeNameSpace
            @themeAuthor = props.themeAuthor
            @themeAuthorURI = props.themeAuthorURI
            @themeURI = props.themeURI
            @themeTags = props.themeTags
            @themeTags = props.themeTags
            @githubRepo = props.githubRepo
            @jshintTag = "<%= jshint.all %>"
            cb()

        ).bind(this)

    app : ->
        currentDate = new Date()

        @themeCreated = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1) + "-" + currentDate.getDate()

        @directory "theme", @themeNameSpace

        # create theme folders
        @mkdir @themeNameSpace + "/production"
        @mkdir @themeNameSpace + "/css/fonts"

        # create theme js folders
        @mkdir @themeNameSpace + "/js/modules"
        @mkdir @themeNameSpace + "/js/tests/specs"
        @mkdir @themeNameSpace + "/js/tests/helpers"

        # create grunt folder
        @mkdir @themeNameSpace + "/grunt"

        # create test folders
        @mkdir @themeNameSpace + "/SPA/tests/specs"
        @mkdir @themeNameSpace + "/SPA/tests/helpers"

        # create SPA folders for marionette
        @mkdir @themeNameSpace + "/SPA/apps"
        @mkdir @themeNameSpace + "/SPA/behaviors"
        @mkdir @themeNameSpace + "/SPA/pages"
        @mkdir @themeNameSpace + "/SPA/entities"

        # create folders for PHP code
        @mkdir @themeNameSpace + "/classes"
        @mkdir @themeNameSpace + "/tests"

        # move grunt config files
        @template "_Gruntfile.tpl", @themeNameSpace + "/grunt/Gruntfile.coffee"
        @template "_package.json", @themeNameSpace + "/grunt/package.json"
        @template "_coffeelint.json", @themeNameSpace + "/grunt/coffeelint.json"
        @template "_jshintignore", @themeNameSpace + "/grunt/.jshintignore"
        @template "_jshintrc", @themeNameSpace + "/grunt/.jshintrc"

        # move composer file
        @template "composer.tpl", @themeNameSpace + "/composer.json"

        #move bower
        @template "_bower.json", @themeNameSpace + "/js/bower.json"
        @template "_spa-bower.json", @themeNameSpace + "/SPA/bower.json"


module.exports = AjencyWpThemeGenerator
