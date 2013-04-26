Recurser =
  isHash: (val) ->
    val? and (typeof val is 'object') and !(val instanceof Array)
  isArray: (val) ->
    val? and typeof val is 'object' and val instanceof Array and typeof val.length is 'number'
  isPlain: (val) ->
    val? and typeof val isnt 'object'

  indent: (str, level) ->
    ret = Array(level * 2 + 1).join(" ") + str
    console.log  "ret is" + ret
    ret

  isImplicitString: (str) ->
    # starts with non space and composed of alphanumerispaces
    /^\w+[\w ]*$/.test(str) and 
      /\w$/.test str # ends on non whitespace

  implicitString: (str) ->
    "\"#{str}\""

  json2humon: (val, level=0, context) ->
    if Recurser.isPlain val
      str = ""
      str += " " if Recurser.isHash(context)
      str += Recurser.indent(val, 0) + "\n"
      return str 
    if Recurser.isHash val
      str = unless level is 0 then "\n" else ""
      for own key, v of val
        str += Recurser.indent(key, level) + ":" + Recurser.json2humon(v, level + 1, val)
      return str

if exports?
  exports.recurser = Recurser
