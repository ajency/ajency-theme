#global describe, beforeEach, it 
"use strict"

path = require "path"
helpers = require("yeoman-generator").test
assert = require "assert"

describe "ajency-theme generator", ->

    it "creates expected files", ->

        app = require "../app"
        assert app isnt 'undefined'
