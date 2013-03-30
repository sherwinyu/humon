{exec} = require 'child_process'

build = (callback)->
  removeJS -> 
    compile ->
      makeAndCleanParser ->
        callback() if callback

compile = (callback) ->
  exec 'mkdir -p lib', (err, stdout, stderr) ->
    throw new Error(err) if err
    exec "coffee --compile --output lib/ src/", (err, stdout, stderr) ->
      throw new Error(err) if err
      callback() if callback
      
removeJS = (callback) ->
  exec 'rm -fr lib/', (err, stdout, stderr) ->
    throw new Error(err) if err
    callback() if callback

makeParser = (callback) ->
  {generator} = require('./src/humon_ast.coffee')
  fs = require("fs")
  generatedCode = generator.generate()
  fs.writeFileSync 'lib/parser.js', generatedCode


makeAndCleanParser = (callback) ->
  makeParser()
  cleanParserFile callback

cleanParserFile = (callback) ->
  fs = require('fs')
  source = fs.readFileSync('./lib/parser.js')
  lines = source.toString().split("\n")
  lines.splice(-16, 15)
  code = lines.join "\n"
  fs.writeFileSync 'lib/parser.js', code
  callback() if callback

browserify = (callback = console.log) ->
  findExecutable 'browserify', ->
    exec "browserify src/humon.coffee -o ~/projects/sysys/app/assets/javascripts/vendor/humon.js", (err, stdout) ->

task 'build', 'Build lib from src', -> build()
task 'test', 'Test project', -> test()
task 'makeAndCleanParser', 'Invoke jison to write the parser and clean it', -> makeAndCleanParser()
task 'makeParser', 'Invoke jison to write the parser', -> makeParser()
task 'cleanParserFile', 'remove exports.main from parser.js', -> cleanParserFile()
task 'clean', 'Clean lib', -> removeJS()
task 'browserify', 'browserify and compress to one file', -> build browserify

task 'publish', 'Publish project to npm', -> publish()
task 'dev-install', 'Install developer dependencies', -> dev_install()

###
test = (callback = console.log) ->
  checkDependencies ->
    build ->
      exec "vows --spec test/*", (err, stdout) ->
        callback(stdout)

checkDependencies = (callback) ->
  findExecutable 'coffee', ->
    findExecutable 'vows', (err, stdout) ->
      (callback or console.log) (stdout)
      

publish = (callback = console.log) ->
  build ->
    findExecutable 'npm', ->
      exec 'npm publish', (err, stdout) ->
        callback(stdout)

dev_install = (callback = console.log) ->
  build ->
    findExecutable 'npm', ->
      exec 'npm link .', (err, stdout) ->
        callback(stdout)
###

findExecutable = (executable, callback) ->
  exec "test `which #{executable}` || echo 'Missing #{executable}'", (err, stdout, stderr) ->
    throw new Error(err) if err
    callback() if callback
