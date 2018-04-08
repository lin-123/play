# client.coffee
thrift = require 'thrift'
util = require 'util'
demoService = require './gen-nodejs/demo'

# connection = thrift.createConnection 'localhost', 9016, {transport: thrift['TBufferedTransport']}
# connection.on 'error', (err)->
#   util.log "client error:", err


# client = thrift.createClient demoService, connection

# console.log client



connection = thrift.createConnection 'localhost', 9061, {transport: thrift['TBufferedTransport']}

connection.on 'error', (err)->
  console.log 'err', err 
  callback err

# connection.once 'connect', ->
#   console.log 'connect ... '
#   client = thrift.createClient test, connection
#   callback null,client

client = thrift.createClient demoService, connection

client.demoFunc 1