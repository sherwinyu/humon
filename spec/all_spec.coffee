# jasmine = require('jasmine-node')
humon = require("../src/humon")


# console.log 'hi!'
# console.log humon.parse '5'



parse = humon.parse
describe "humon.parse", ->
  it "should work for 5", ->
    code = "5"
    # console.log parse 5
    expect(parse code).toEqual(5)

  describe "simple values", ->
    it "should work for 5", ->
      code = "5"
      # console.log parse 5
      expect(parse code).toEqual(5)

  describe "simple hash", ->
    @code = """ """

