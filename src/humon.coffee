{parser}         = require './parser'
{Lexer} = require "./humon_lexer.coffee"

# console.log parser
# input = ' "aba", 4, {"a": 6}'
# input = '
# abc: 
# a: 555
# '
# z.lexer = 

class ObjectProxy


class parser.yy.ObjectProxy 
  constructor: (args) ->
    console.log 'hi!', args
    @[args.key] = args.val

parser.lexer =
  lex: ->
    [tag, @yytext, @yylineno] = @tokens[@pos++] or ['']
    tag
  setInput: (@tokens) ->
    @pos = 0
  upcomingInput: ->
    ""


doit = (code) ->
  tokens = lex code
  console.log "##### input code: #####"
  console.log code
  console.log "\n\n"
  console.log "##### input tokens: #####"
  console.log tokens 
  console.log "\n\n"
  console.log "##### parsing: #####"
  parser.parse tokens
  # @otherTokens = []
  # console.log parser.parse(@tokens.slice 0, @tokens.length)

lex = (code) ->
  lexer = (new Lexer())
  lexer.tokenize code

parseTokens = (tokens) ->
  parser.parse tokens

exports.lex = lex
exports.parseTokens = parseTokens
exports.parse = doit
