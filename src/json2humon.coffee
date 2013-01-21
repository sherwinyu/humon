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
    
   ###
      # a = Sysys.EnumerableObjectViaArray.create()
      a = Sysys.EnumerableObjectViaObject.create()
      for own k, v of val
        a.set(k, Sysys.JSONWrapper.recursiveDeserialize(v))
      return a
    if Sysys.JSONWrapper.isArray val
      a = []
      for v in val
        a.pushObject Sysys.JSONWrapper.recursiveDeserialize(v)
      return a
    throw new Error("this shoud never happen")
    ###
  
  recursiveSerialize: (val) ->
    if Sysys.JSONWrapper.isPlain val
      return val
    if val.isHash and val instanceof Sysys.EnumerableObjectViaObject
      ret = {}
      for key in val._keys
        ret[key] = Sysys.JSONWrapper.recursiveSerialize val.get(key)
      return ret
    if Sysys.JSONWrapper.isArray val
      ret = []
      for ele in val
        ret.pushObject Sysys.JSONWrapper.recursiveSerialize ele
      return ret
    throw new Error("this shoud never happen")

if exports?
  exports.recurser = Recurser
