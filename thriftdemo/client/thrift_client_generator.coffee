# thrift_client_generator.coffee
thrift = require 'thrift'
test = require('../gen-nodejs/Test')
ttypes = require('../gen-nodejs/test_types')

client = null
generatorClient = -> #(callback)->
  if client 
    return client
    # return callback null, client
  connection = thrift.createConnection 'localhost', 9016, {transport: thrift['TBufferedTransport']}

  connection.on 'error', (err)->
    console.log 'err', err 
    # callback err

  # connection.once 'connect', ->
  #   console.log 'connect ... '
  #   client = thrift.createClient test, connection
  #   callback null,client

  client = thrift.createClient test, connection

exports.getClient = generatorClient


