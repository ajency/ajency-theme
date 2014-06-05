"use strict"

helpers = require('yeoman-generator').test
assert  = require('yeoman-generator').assert

describe "Ajency theme module test", ->

    module = null

    before ->
        module = require "../module"

    it "can be imported without blowing up", ->
        assert module isnt undefined

    it "must run with 0 arguments", ->
        module = helpers.createGenerator  'module', ['module']
        module.run()
