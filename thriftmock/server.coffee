# server.coffee
net = require 'net'
service = require './serviceHandler'
mock = require './mock'

server = mock.createServer service, 
  sayHello: (username)->
    console.log "hello #{username}"

server.listen 8124, ->
  console.log 'server listening on 8124'