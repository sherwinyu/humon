#!/usr/bin/env node
lex = require './humon_lexer.coffee'
# lex = require './lexer.coffee'
# io = require 'util/io'
  
fsUtil = require 'fs'
filePath = "in.coffee"


fsUtil.readFile filePath, (err,data) =>
  @source = data.toString()
  doit @source

@lexer = (new lex.Lexer())
doit = (str) =>
  console.log "#### sorce #####"
  console.log @source
  console.log "#### output #####"
  console.log @lexer.tokenize str
  console.log "#### sorce #####"
  console.log @source
