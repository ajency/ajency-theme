#global describe, beforeEach, it
"use strict"

assert = require "assert"

describe "ajency-theme generator", ->

    it "can be imported without blowing up", ->

        app = require("../app")
        assert app isnt 'undefined'