{parser}         = require './parser'
{Lexer} = require "./humon_lexer.coffee"

# console.log parser
# input = ' "aba", 4, {"a": 6}'
# input = '
# abc: 
# a: 555
# '
# z.lexer = 

@d = (args...) ->
  if $debug
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


doit = (code) ->
  tokens = lex code
  @d "##### input code: #####"
  @d code
  @d "\n\n"
  @d "##### input tokens: #####"
  @d tokens 
  @d "\n\n"
  @d "##### parsing: #####"
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
exports.d = @d
