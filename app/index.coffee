"use strict"
util = require "util"
path = require "path"
yeoman = require "yeoman-generator"
chalk = require "chalk"

AjencyWpThemeGenerator = module.exports = AjencyWpThemeGenerator = (args, options, config) ->

    yeoman.generators.Base.apply this, arguments_

    @on "end", ->
        _that = this
        if @themeNameSpace
            process.chdir @themeNameSpace + "/grunt/"
            @installDependencies
                skipInstall : options["skip-install"]
                bower : false
                callback : (->
                    process.chdir "../js/"
                    @installDependencies
                        skipInstall : options["skip-install"]
                        npm : false
                        callback : (->
                            process.chdir "../SPA/"
                            @installDependencies
                                skipInstall : options["skip-install"]
                                npm : false

                            return
                        ).bind(this)

                    return
                ).bind(this)

        return

    @pkg = JSON.parse @readFileAsString path.join __dirname, "../package.json"

util.inherits AjencyWpThemeGenerator, yeoman.generators.Base

AjencyWpThemeGenerator::askFor = askFor = ->

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
            default : (answers) ->
                "Team Ajency"
        }
        {
            name : "themeAuthorURI"
            message : "Website of the themes authors?"
            default : (answers) ->
                "http://ajency.in/team"
        }
        {
            name : "themeURI"
            message : "Website of the theme?"
            default : (answers) ->
                "http://ajency.in/"
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
            name : "phpcsPath"
            message : "PHP Code Sniffer path?"
            default : "/usr/bin/phpcs"
        }
        {
            name : "phpUnitPath"
            message : "PHP unit path?"
            default : "/usr/bin/phpunit"
        }
        {
            name : "githubRepo"
            message : "Github repository path"
            default : ""
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
        @phpcsPath = props.phpcsPath
        @phpUnitPath = props.phpUnitPath
        @githubRepo = props.githubRepo
        @jshintTag = "<%= jshint.all %>"
        cb()

    ).bind(this)


AjencyWpThemeGenerator::app = app = ->

    currentDate = new Date()

    @themeCreated = currentDate.getFullYear() + "-" + (currentDate.getMonth() + 1) + "-" + currentDate.getDate()

    @directory "theme", @themeNameSpace

    @mkdir @themeNameSpace + "/production"
    @mkdir @themeNameSpace + "/css/fonts"
    @mkdir @themeNameSpace + "/js/modules"
    @mkdir @themeNameSpace + "/js/tests/specs"
    @mkdir @themeNameSpace + "/js/tests/helpers"
    @mkdir @themeNameSpace + "/grunt"
    @mkdir @themeNameSpace + "/SPA/tests/specs"
    @mkdir @themeNameSpace + "/SPA/tests/helpers"
    @mkdir @themeNameSpace + "/classes"
    @mkdir @themeNameSpace + "/tests"

    # move grunt config files
    @template "_Gruntfile.tpl", @themeNameSpace + "/grunt/Gruntfile.coffee"
    @template "_package.json", @themeNameSpace + "/grunt/package.json"
    @template "_coffeelint.json", @themeNameSpace + "/grunt/coffeelint.json"
    @template "_jshintignore", @themeNameSpace + "/grunt/.jshintignore"
    @template "_jshintrc", @themeNameSpace + "/grunt/.jshintrc"

    #move bower
    @template "_bower.json", @themeNameSpace + "/js/bower.json"
    @template "_spa-bower.json", @themeNameSpace + "/SPA/bower.json"
    return