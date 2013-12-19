# in Terminal cake dev to run

fs = require 'fs'
{print} = require 'sys'
{log, error} = console; print = log
{spawn, exec} = require 'child_process'

run = (name, command, cb) ->
  cb = cb ? () ->
  proc = spawn(name, command.split(' '))
  proc.stdout.on('data', (buffer) -> print buffer if buffer = buffer.toString().trim())
  proc.stderr.on('data', (buffer) -> error buffer if buffer = buffer.toString().trim())
  proc.on 'exit', (status) ->
    process.exit(1) if status isnt 0
    cb()

task 'dev', 'Setup my dev system', () ->
  run 'coffee', '--output lib --watch --compile src'
  run 'coffee', '--output public/js/lib --watch --compile public/js/src'

  # client-side scripts
  run 'banshee', 'public/js/lib/answers.js:public/js/lib/answers.min.js'
  run 'banshee', 'public/js/lib/main.js:public/js/lib/main.min.js'
  run 'banshee', 'public/js/lib/rank.js:public/js/lib/rank.min.js'
  run 'banshee', 'public/js/lib/results.js:public/js/lib/results.min.js'
  run 'banshee', 'public/js/lib/seeanswers.js:public/js/lib/seeanswers.min.js'
  run 'banshee', 'public/js/lib/settings.js:public/js/lib/settings.min.js'
  run 'banshee', 'public/js/lib/socialshare.js:public/js/lib/socialshare.min.js'

  run 'banshee', 'public/css/answers.css:public/css/answers.min.css'
  run 'banshee', 'public/css/change.css:public/css/change.min.css'
  run 'banshee', 'public/css/index.css:public/css/index.min.css'
  run 'banshee', 'public/css/main.css:public/css/main.min.css'
  run 'banshee', 'public/css/mission.css:public/css/mission.min.css'
  run 'banshee', 'public/css/results.css:public/css/results.min.css'
  run 'banshee', 'public/css/seeanswers.css:public/css/seeanswers.min.css'
  run 'banshee', 'public/css/socialshare.css:public/css/socialshare.min.css'


  run 'supervisor', 'server'
