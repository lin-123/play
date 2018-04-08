# connection.coffee
net = require 'net'
trans = require './transport'
resource = require './resource'


Connection = exports.Connection = (@connection)->
  self = @
  @client = null
  @trans = new trans.Transport (buf)=> @connection.write buf

  @connection.on 'error', (err)->
    console.log 'connection error:', err

  @connection.on 'data', self.trans.receiver (transWithData)->
    try
      message = transWithData
      while message.readCursor < message.writeCursor  
        message.readFieldStart()
        head = message.readHead()
        if head.type isnt resource.MessageType.REPLY
          throw "Error: client receive bad message head, type = #{head.type}"

        method = head.method
        self.client["recv_#{method}"] head.reqid, message.readArg(0), message.readArg(1)
        message.readFieldStop()

    catch e
      console.log JSON.stringify e
      transWithData.rollbackPosition()    
    
  # return Connection class
  @ 

exports.createConnection = (host, port)->
  stream = net.createConnection port, host
  connection = new Connection stream

  connection

exports.createClient = (service, connection)->
  client = new service.Client connection.trans

  connection.client = client

  client
