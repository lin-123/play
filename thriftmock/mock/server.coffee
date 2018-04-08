# server.coffee
net = require 'net'
trans = require('./transport').Transport

exports.createServer = (service, handler)->
  service = new service.Processor(handler)

  server = net.createServer (stream)->
    _trans = new trans (buf)-> stream.write buf

    stream.on 'error', (err)->
      console.log 'error occur', err
    
    stream.on 'data', _trans.receiver (transWithData)->
      try
        request = transWithData
        response = _trans
        while request.readCursor < request.writeCursor  
          service.process request, response
          # request.commitPosition()

      catch e
        transWithData.rollbackPosition()
        console.error new Error e
      
    stream.on 'end', ->
      console.log 'client end', JSON.stringify(arguments)