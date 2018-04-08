# 组合buffer， 
# 发送消息： 需要net 连接， 通过连接 write(msg)
# 
# next read
# 
binary = require './binary'
resource = require './resource'

class Transport 
  constructor: (@onFlush)->
    @defualtReadBufferSize = 1024
    @inBuf = new Buffer @defualtReadBufferSize

    @outBuffers = []
    @outCount = 0
    @msg = ''
    @readCursor = 0
    @writeCursor = 0

  receiver: (callback)->
    reader = new Transport()
    (data)=>
      # 每次收到消息都写入@inBuf
      if data.length + reader.writeCursor > reader.inBuf.length
        buf = new Buffer(data.length + reader.writeCursor)
        reader.inBuf.copy(buf, 0, 0, reader.writeCursor)
        reader.inBuf = buf

      data.copy(reader.inBuf, reader.writeCursor, 0);
      reader.writeCursor += data.length;
      
      callback reader

  # 重置buffer
  commitPosition: ->
    unreadSize = @writeCursor - @readCursor


    buffSize = if unreadSize * 2 > @defualtReadBufferSize then unreadSize*2 else @defualtReadBufferSize
    buf = new Buffer buffSize
    if unreadSize <= 0
      return
    
    @inBuf.copy buf, 0, @readCursor, @writeCursor
    @readCursor = 0
    @writeCursor = unreadSize

    @inBuf = buf

  # 当readCursor > writeCursor 时， 从头重新读数据
  rollbackPosition: ->
    @readCursor = 0

  readFieldStart: ->
    messageStart = @readI32()
    if messageStart isnt resource.Type.START
      throw new Error "Error: bad message head: messageStart = #{messageStart}"

  readFieldStop: ->
    messageStop = @readByte()
    if messageStop isnt resource.Type.STOP
      throw new Error "Error: bad message end: messgeStop = #{messageStop}"
      return
    
    @commitPosition()

  readHead: ->
    # type, methodNameLength methodName, reqid
    messageType = @readByte()
    methodName = @readString()
    reqid = @readI32 @inBuf
    
    head = 
      type: messageType
      method: methodName
      reqid: reqid

  readArg: (argId)->
    # id, type, value
    id = @readByte()
    if id isnt argId
      throw "Error: bad argId, argId = #{id}"
    
    type = @readByte()
    switch type
      when resource.Type.I32 then value = @readI32()
      when resource.Type.STRING then value = @readString()
      else 
        throw "Error: bad argument type, type = #{type}"

  ensureAvailable: (len)->
    if @readCursor + len > @writeCursor
      throw new Error "ensureAvailable error: 读取信息超出限制"

  readI32: ()->
    @ensureAvailable 4
    i32 = binary.i32ToInt @inBuf, @readCursor
    @readCursor += 4
    i32

  readByte: ()->
    @ensureAvailable 1
    byte = binary.byteToInt @inBuf, @readCursor
    @readCursor++
    byte

  readString: ()->
    _len = @readByte()
    if _len is 0
      return null

    @ensureAvailable _len
    str = @inBuf.toString 'utf8', @readCursor, @readCursor + _len
    @readCursor += _len

    str

  writeFieldStart: ->
    @writeI32 resource.Type.START

  writeFieldStop: ->
    @writeByte resource.Type.STOP

  writeHead: (messageType, methodName, reqid)->
    @writeByte messageType    
    @writeString methodName
    @writeI32 reqid

  writeArg: (argId, type, arg)->
    @writeByte argId
    @writeByte type

    # 参数类型只有 i32, string
    if type is resource.Type.STRING
      return @writeString arg

    @writeI32 arg

  writeByte: (value)->
    buf = binary.toByte value
    @writeBuf buf

  writeI32: (value)->
    buf = binary.toI32 value
    @writeBuf buf

  writeString: (value)->
    unless value
      value = ''
    @writeByte value.length
    
    @writeBuf new Buffer value

  writeBuf: (buf)->
    @outBuffers.push buf
    @outCount += buf.length

  write: (buf)->
    @msg = "#{buf}#" 
    return 

  flush: ()-> 
    if @msg
      # console.log 'flush', @msg
      @onFlush @msg
      @msg = null
      return

    msg = new Buffer(@outCount)
    pos = 0
    for buf in @outBuffers
      buf.copy msg, pos, 0
      pos += buf.length
    
    @onFlush msg
    @outBuffers = []
    @outCount = 0

  @

exports.Transport = Transport