{parser}         = require '../lib/parser'
{Lexer} = require "./humon_lexer.coffee"
{recurser} = require "./json2humon"

###
# This file is the single point of entry for other libraries.
# It combines the lexer ('humon_lexer.coffee')
# ###

d = (args...) ->
  if $debug?
    console.log args
  args

# An version of the 'lexer' object that JISON requires, needs to implement the Lexical scanner api:
# needs to implement `lex` and `setInput`
# we're pre-lexing everything (using our own lexer.tokenize) and simply feeding in a stream of tokens for the parser's lexer
# see `parser`: everything is lexed first and then fed in as tokens to `parse` which calls `parser.parse`
parser.lexer =

  # the jison-generated parser calls this everytime it needs a token. 
  # Since our token stream is preparsed, we just return the next token from the array
  lex: ->
    [tag, @yytext, @yylineno] = @tokens[@pos++] or ['']
    tag

  # The jison-generated parser calls `lexer.setInput(code)` once at the beginning of parsing. 
  # We are 'bypassing' this by seting an instance variable (@tokens) and the state (@pos).
  setInput: (@tokens) ->
    @pos = 0

  upcomingInput: ->
    ""


# `parse` is the primary interaction point. 
# `code` is a string representing a HUMON object
# We pre-lex it into a token stream, and then pass the token stream into our jison-generated parser
# which ahs been configured to read a token stream.
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

# invokes lexer.tokenize on raw code (a string representing a HUMON object) to generate tokens
# see src/humon_lexer.coffee for more details
lex = (code) ->
  lexer = (new Lexer())
  lexer.tokenize code

# invokes the jison-generated parser to parse a series of tokens into an AST / json structure to return
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

