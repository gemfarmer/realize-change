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
  # run 'process.env.NODE_ENV = "development"'
  # run 'coffee', '--output models/lib --watch --compile models/src'
  # run 'stylus', '-o public/css/lib -w public/css/src'
  run 'banshee', 'public/app.js:lib/app.min.js'
  # run 'banshee', 'public/javascripts/lib/main.js:public/javascripts/lib/main.min.js'
  # run 'banshee', 'public/stylesheets/style.css:public/stylesheets/style.min.css'
  # run 'banshee', 'lib/app.js:lib/app.min.js'
  # run 'banshee', 'public/javascripts/lib/main.js:public/javascripts/lib/main.min.js'
  # run 'banshee', 'public/stylesheets/style.css:public/stylesheets/style.min.css'
  run 'supervisor', 'server'
