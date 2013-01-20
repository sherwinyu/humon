# jasmine = require('jasmine-node')
humon = require("../src/humon")
parse = humon.parse

code = """
a: 5
g: 6
c: 
  d: nested

"""

console.log "|#{code}|"
console.log parse code
