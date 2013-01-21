{parser}         = require '../lib/parser'
{Lexer} = require "./humon_lexer.coffee"
{recurser} = require "./json2humon"

# console.log parser
# input = ' "aba", 4, {"a": 6}'
# input = '
# abc: 
# a: 555
# '
# z.lexer = 

d = (args...) ->
  if $debug?
    console.log args
  args


parser.lexer =
  lex: ->
    [tag, @yytext, @yylineno] = @tokens[@pos++] or ['']
    tag
  setInput: (@tokens) ->
    @pos = 0
  upcomingInput: ->
    ""


parse = (code) ->
  tokens = lex code
  d "##### input code: #####"
  d code
  d "\n\n"
  d "##### input tokens: #####"
  d tokens 
  d "\n\n"
  d "##### parsing: #####"
  parser.parse tokens
  # @otherTokens = []
  # console.log parser.parse(@tokens.slice 0, @tokens.length)

lex = (code) ->
  lexer = (new Lexer())
  lexer.tokenize code

parseTokens = (tokens) ->
  parser.parse tokens

if exports?
  exports.lex = lex
  exports.parseTokens = parseTokens
  exports.parse = parse
  exports.d = d
  exports.json2humon = recurser.json2humon

if window?
  window.humon = {}
  window.humon.lex = lex
  window.humon.parseTokens = parseTokens
  window.humon.parse = parse
  window.humon.d = d
  window.humon.json2humon = recurser.json2humon

