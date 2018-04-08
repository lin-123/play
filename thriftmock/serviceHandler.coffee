# serviceHandler.coffee
resource = require('./mock').resource

Client = exports.Client = (@output)-> 
  @responseQueue = {}
  @reqid = -1

Client.prototype.newReqid = -> ++@reqid

mockCB = (err, result)->

Client.prototype.sayHello = (username, callback)->
  if typeof callback isnt 'function'
    callback = mockCB
  @responseQueue[@newReqid()] = callback

  @send_sayHello(username)

Client.prototype.send_sayHello = (username)->
  @output.writeFieldStart()
  @output.writeHead resource.MessageType.CALL, 'sayHello', @reqid
  @output.writeArg 0, resource.Type.STRING, username
  @output.writeFieldStop()

  @output.flush()

Client.prototype.recv_sayHello = (reqid, err, message)->
  callback = @responseQueue[reqid]
  delete @responseQueue[reqid]

  callback err, message

class Processor 
  constructor: (@handler)->

  process: (input, output)->
    input.readFieldStart()
    head = input.readHead()
    if head.type isnt resource.MessageType.CALL 
      throw "Error: server receive bad MessageType, MessageType = #{head.type}"

     @["process_#{head.method}"].call this, input, head.reqid, output

  process_sayHello: (input, reqid, output)->
    # 接收消息， 交由handler处理
    username = input.readArg(0)
    input.readFieldStop()
    @handler.sayHello username

    output.writeFieldStart()
    output.writeHead resource.MessageType.REPLY, 'sayHello', reqid
    output.writeArg 0, resource.Type.STRING, null
    output.writeArg 1, resource.Type.STRING, username
    output.writeFieldStop()
    
    output.flush()

  @

exports.Processor = Processor