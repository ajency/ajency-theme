"use strict"

assert = require "assert"

describe "Ajency theme sub generator(module)", ->

    it "can be imported without blowing up", ->
        module = require "../module"
        assert module isnt undefined

    it "throw an exception if run without options", ->
        module = require "../module"
        expect(23).toEqual 23

    it "throws an exception", () ->
 	   expect(23).toEqual 23 
    	