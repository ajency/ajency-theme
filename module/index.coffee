"use strict"
util = require("util")

yeoman = require("yeoman-generator")

ModuleGenerator = yeoman.generators.NamedBase.extend

    init : (args) ->
        console.log "You called the module subgenerator with the argument #{arguments[0]}"


module.exports = ModuleGenerator
