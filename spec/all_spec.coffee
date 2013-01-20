# jasmine = require('jasmine-node')
humon = require("../src/humon")

parse = humon.parse
describe "humon.parse", ->
  describe "simple values", ->
    it "should work for numbers", ->
      code = "5"
      expect(parse code).toEqual(5)

    it "should work for explicit double quote strings", ->
      code = '"a string"'
      expect(parse code).toEqual('a string')

    it "should work for implicit strings", ->
      code = 'an implicit string'
      expect(parse code).toEqual('an implicit string')


  describe "simple hashes", ->
    it "should be valid with implicit keys", ->
      code = "a: 5"
      expect(parse code).toEqual({a: 5})
      code = "a: an implicit string"
      expect(parse code).toEqual({a: 'an implicit string'})

    it "should be valid with explicit keys", ->
      code = '"a": 5'
      expect(parse code).toEqual({a: 5})
      code = '"key with spaces": 5'
      expect(parse code).toEqual({"key with spaces": 5})

    it "should be valid with multiple key value pairs", ->
      code = """
              a: 5
              g: 6
              """
      expect(parse code).toEqual({a: 5, g: 6})

  describe "nested hashes", ->
    it "should be valid with multi line nesting", ->
      code = """
              a: 5
              nested:
                a: 5
                b: 6
              g: 6
              """
      expect(parse code).toEqual({a: 5, nested: {a: 5, b: 6}, g: 6})
