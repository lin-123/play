# server.coffee
thrift = require 'thrift'
util = require 'util'
demoService = require './gen-nodejs/demo'

# server = thrift.createServer demoService, 
#   demoFunc: (arg1)->
#     util.log 'call demoFunc: arg1 =', arg1
#     # callback null, 'hello'
# ,{}

# server.listen 9016, ->
#   util.log 'server listen on 9016'

# server.coffee
# thrift = require('thrift')
demo = require('./gen-nodejs/demo')

server = thrift.createServer demo,
  demoFunc: (arg1)->
    util.log 'arg1', arg1
, {}

port = process.env.PORT or 9061
server.listen process.env.PORT or port, () ->
  console.log 'server listening on', port
