Generator = require("jison").Generator

unwrap = /^function\s*\(\)\s*\{\s*return\s*([\s\S]*);\s*\}/
o = (patternString, action, options) ->
  patternString = patternString.replace /\s{2,}/g, ' '
  return [patternString, '$$ = $1;', options] unless action
  action = if match = unwrap.exec action then match[1] else "(#{action}())"
  action = action.replace /\bnew /g, '$&yy.'
  action = action.replace /\b(?:Block\.wrap|extend)\b/g, 'yy.$&'
  console.log "action is: #{action}"
  [patternString, "$$ = #{action};", options]

createObject = (arg)->
  b = {}
  b[args.key] = args.val
  b


@bnf = 
  Value: [
    o 'STRING', -> console.log('STRING -> Value', $1); $1
    o 'NUMBER', -> console.log('NUMBER -> Value', $1); Number($1)
    o 'Object', -> console.log('Object -> Value', $1); $1
    o 'Array', -> console.log('Array -> Value', $1); $1
  ]

  Element: [
    o 'Value %', -> console.log('Value ; -> Element', $1); $1
  ]
  ElementList: [
    o 'Element', -> console.log('Value', $1); [$1]
    o 'ElementList  Element', -> console.log('ElementList Element -> ElementList', $1, $2); $1.push $2; $1
    # o 'ElementList  Value TERMINATOR', -> console.log('ElementList Value TERM -> ElementList', $1, $2); $1.push $2; $1
    # o 'ElementList  Element', -> console.log('ValueList ; Value -> ValueList', $1, $3); $1.push $3; $1
  ]

  Array: [
    o '[ ]', -> []
    o '[ ElementList ]', -> $2
    o 'ElementList', -> console.log('ElementList -> Array', $1); $1
    o 'ElementList TERMINATOR', -> console.log('ElementList TERMINATOR -> Array', $1); $1
    # o 'ValueList', -> console.log('ValueList -> Array', $1); $1
  ]

  AssignList: [
    # o 'AssignObj , AssignList', -> ($4[$1.key] = $1.val) && $4
    o 'AssignList , AssignObj', -> console.log('assignlist , assignobj matched', $1, $3); $1[$3.key] = $3.val; $1
    o 'AssignList TERMINATOR AssignObj', -> console.log('AssignList TERM AssignObj->AssignList', $1, $3); ($1[$3.key] = $3.val); $1
    #o 'AssignObj', -> new ObjectProxy($1) # $1 # && console.log('worger', $1)
    o 'AssignObj', ->  console.log('AssignObj->AssignList', $1); b = {}; b[$1.key] = $1.val; b # && console.log('worger', $1)
  ]


  Object: [
    o '{ }', -> {}
    o '{ AssignList }', -> $2

    ## do i want this one?
    o 'AssignList', -> console.log('AssignList -> Object', $1); $1
    o 'AssignList TERMINATOR', -> console.log('AssignList TERM -> Object', $1); $1
    o 'INDENT AssignList OUTDENT', -> console.log('Object matched', $2); $2
  ]

  AssignObj: [
    o 'STRING : Value', -> console.log('STRING : Value -> AssignObj', $1, $3); ({key: $1, val: $3})
  ]



  RootPlex: [
    o "Value", -> console.log("Value -> RootPlex", $1); $1
    o "Value TERMINATOR", -> console.log("Value TERM -> RootPlex", $1); $1
    # ["Value TERMINATOR", "console.log('Root matched terminator', $1); return $1"]
    # o "Value", -> $1
    # o "Value TERMINATOR", -> $1
  ]

  Root: [
    ["RootPlex", "console.log('RootPlex->Root', $1); return $1"]
  ]
  

    ###
  AssignObj: [
    o 'ObjAssignable',                          -> new Value $1
    o 'ObjAssignable : Expression',             -> new Assign new Value($1), $3, 'object'
    o 'ObjAssignable :
       INDENT Expression OUTDENT',              -> new Assign new Value($1), $4, 'object'
    o 'Comment'
  ]
    ###



  ###
    JSONMemberList: [["JSONMember", "$$ = {}; $$[$1[0]] = $1[1];"],
                    ["JSONMember , JSONMemberList", "$$ = $3; $3[$1[0]] = $1[3];"],
                    ["JSONMember TERMINATOR JSONMemberList", "$$ = $3; $3[$1[0]] = $1[3];"]]
                    ###


  ###
  AlphaNumeric: [
    o 'NUMBER',                                 -> $1
    o 'STRING',                                 -> $1
  ]
  Object: [
    o '{ }', -> {}
    o '{ JSONMemberList }', -> $2
    o 'JSONMemberList', -> $1
  ]
  ###

grammar =
  tokens: "STRING NUMBER { } [ ] , ; % : TRUE FALSE NULL INDENT OUTDENT"
  start: "Root"
  bnf:  @bnf
    ###
    JSONString: [["STRING", "$$ = yytext;"]]
    JSONNumber: [["NUMBER", "$$ = Number(yytext);"]]
    JSONNullLiteral: [["NULL", "$$ = null;"]]
    JSONBooleanLiteral: [["TRUE", "$$ = true;"],
                        ["FALSE", "$$ = false;"]]
    Root: [["JSONValue", "return $$ = $1;"]]
    JSONValue: [["JSONNullLiteral", "$$ = $1;"],
                ["JSONBooleanLiteral", "$$ = $1;"],
                ["JSONString", "$$ = $1;"],
                ["JSONNumber", "$$ = $1;"],
                ["JSONObject", "$$ = $1;"],
                ["JSONArray", "$$ = $1;"]]
    JSONObject: [["{ }", "$$ = {};"],
                ["{ JSONMemberList }", "$$ = $2;"],
                ["JSONMemberList", "$$ = $1;"]]
                # JSONMember: [["JSONString : JSONValue", "$$ = [$1, $3];"]]
    JSONMember: [["JSONString : JSONValue", "$$ = [$1, $3];"]]
    
    # [ "JSONMemberList , JSONMember", "$$ = $1; $1[$3[0]] = $3[1];" ]],
    JSONMemberList: [["JSONMember", "$$ = {}; $$[$1[0]] = $1[1];"],
                    ["JSONMember , JSONMemberList", "$$ = $3; $3[$1[0]] = $1[3];"],
                    ["JSONMember TERMINATOR JSONMemberList", "$$ = $3; $3[$1[0]] = $1[3];"]]
    JSONArray: [["[ ]", "$$ = [];"],
                ["[ JSONElementList ]", "$$ = $2;"],
                ["JSONElementList", "$$ = $1"]]
    
    # [ "JSONElementList , JSONValue", "$$ = $1; $1.push($3);" ]]
    JSONElementList: [["JSONValue", "$$ = [$1];"],
                      ["JSONValue , JSONElementList", "$$ = $3; $3.push($1);"]]
    ###

options =
  type: "slr"
  moduleType: "commonjs"
  moduleName: "jsonparse"

generator = new Generator(grammar, options)

exports.generator = generator
exports.generate = generator.generate
exports.main = main = (args) ->
  generatedCode = generator.generate()
  # console.log generatedCode
  # fs.writeFile "parser.js", code
###
exports.main = main = (args) ->
  fs = require("fs")
  console.log grammar.bnf
  code = new Generator(grammar, options).generate()
  fs.writeFile "parser.js", code

exports.main require("sys").args  if require.main is module
###
