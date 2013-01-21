# jasmine = require('jasmine-node')
humon = require("../src/humon")
parse = humon.parse
j2h = humon.json2humon

code = """
a: 5
g: 6
c: 
  d: nested

"""

console.log "|#{code}|"
console.log parse code


json = 
  a:
    b: "5 6 7"
    c: 'lalala'
    d:
      e:
        f: 'wallala'
        h: 'wallala'
  d: 'zorger'

console.log "|#{json}|"
console.log j2h json
