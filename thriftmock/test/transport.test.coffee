sinon = require 'sinon'
should = require 'should'

resource = require '../mock/resource'
transport = require '../mock/transport'

describe 'transport', ->  
  _msg = 
    method: 'sayHello'
    reqid: 1
    args:
      username:'kakaka'
  
  onFlush = sinon.spy()
  trans = {}
  beforeEach ->
    trans = new transport.Transport onFlush

  describe 'readMessage', ->
    describe 'readFieldStart', ->
      it 'normal', ->
        startBuf = new Buffer [0x80, 0x01, 0x00, 0x00]
        trans.inBuf = startBuf
        trans.writeCursor = startBuf.length

        # 无返回值， 若验证出错会throw error
        trans.readFieldStart() 
      it 'error', ->
        startBuf = new Buffer [0x80, 0x01, 0x00, 0x01]
        trans.inBuf = startBuf
        trans.writeCursor = startBuf.length
        try
          trans.readFieldStart()
        catch e
          e.should.ok()
          e.should.eql "Error: bad message head: messageStart = -2147418111"

    describe 'readFieldStop', ->
      it 'normal', ->
        stopBuf = new Buffer [0]
        trans.inBuf = stopBuf
        trans.writeCursor = stopBuf.length

        # 无返回值， 若验证出错会throw error
        trans.readFieldStop() 
        
    describe 'readHead', ->
      _returnMsg = 
        type: resource.MessageType.CALL
        method: 'sayHello'
        reqid: 1

      _outBuffers = [
          new Buffer [resource.MessageType.CALL]
          new Buffer [_msg.method.length]
          new Buffer _msg.method
          new Buffer [0, 0, 0, _msg.reqid]
        ]
      
      pos = 0
      _inBuf = new Buffer 100
      for buf in _outBuffers
        buf.copy _inBuf, pos, 0
        pos += buf.length
     
      it 'normal', ->
        trans.inBuf = _inBuf
        trans.writeCursor = _inBuf.length
        trans.readHead().should.eql _returnMsg

    describe 'readArg', ->
      # 0, string, 'kakaka'
      _args = _msg.args

      _outBuffers = [
        new Buffer [0]
        new Buffer [resource.Type.STRING]
        new Buffer [_args.username.length]
        new Buffer _args.username
      ]

      pos = 0
      _inBuf = new Buffer 100
      for buf in _outBuffers
        buf.copy _inBuf, pos, 0
        pos += buf.length
    
      it 'normal', ->        
        trans.inBuf = _inBuf
        trans.writeCursor = _inBuf.length
        trans.readArg(0).should.eql _args.username


    describe 'readString', ->
      it 'normal', ->
        len = new Buffer [2]
        str = new Buffer 'aa'
        buf = new Buffer 3

        len.copy buf, 0, 0
        str.copy buf, 1, 0        

        trans.inBuf = buf 
        trans.writeCursor = buf.length
        trans.readString().should.eql 'aa'

    describe 'readI32', ->
      it 'normal', ->
        buf = new Buffer [0, 0, 0, 1]
        trans.inBuf = buf 
        trans.writeCursor = buf.length
        trans.readI32().should.eql 1
        trans.readCursor.should.eql 4

      it 'error', ->
        buf = new Buffer [0, 0, 0, 1]
        trans.inBuf = buf 
        trans.writeCursor = 0
        # console.log trans.readI32()
        # trans.readI32().should.eql new Error "readI32 -> ensureAvailable error: 读取信息超出限制"

  describe 'writeMessage', ->
    describe 'writeFieldStart', ->
      it 'normal', ->
        _outBuffers = [new Buffer [0x80, 0x01, 0x00, 0x00]]
        
        trans.writeFieldStart()
        trans.outBuffers.should.eql _outBuffers
        trans.outCount.should.eql _outBuffers[0].length

    describe 'writeFieldStop', ->
      it 'normal', ->
        _outBuffers = [new Buffer [resource.Type.STOP]]
        
        trans.writeFieldStop()
        trans.outBuffers.should.eql _outBuffers
        trans.outCount.should.eql _outBuffers.length

    describe 'writeHead', ->
      it 'normal', ->
        _outBuffers = [
          new Buffer [resource.MessageType.CALL]
          new Buffer [_msg.method.length]
          new Buffer _msg.method
          new Buffer [0, 0, 0, _msg.reqid]
        ]

        trans.writeHead resource.MessageType.CALL, _msg.method, _msg.reqid
        trans.outBuffers.should.eql _outBuffers

    describe 'writeArg', ->
      _args = _msg.args
      it 'normal', ->
        _outBuffers = [
          new Buffer [0]
          new Buffer [resource.Type.STRING]
          new Buffer [_args.username.length]
          new Buffer _args.username
        ]
        argId=0        
        trans.writeArg argId, resource.Type.STRING, _args.username
        trans.outBuffers.should.eql _outBuffers

  describe 'writeBuf', ->
    # trans = new transport.Transport onFlush
    it 'normal', ->
      buf = new Buffer [0x01]

      trans.writeBuf buf
      trans.outCount.should.eql 1
      trans.outBuffers.should.eql [buf]

  describe 'flush', ->
    # trans = new transport.Transport onFlush
    it 'normal, flush Buffer', ->
      buf = new Buffer [0x01]
      trans.writeBuf buf
      trans.outCount.should.eql 1
      trans.outBuffers.should.eql [buf]
      
      process.nextTick ->            
        trans.flush()
        trans.onFlush.called.should.be.ok()
        trans.outBuffers.should.eql []
        trans.outCount.should.eql 0


    it 'normal, flush string', ->
      trans.write JSON.stringify _msg
      trans.msg.should.eql "#{JSON.stringify(_msg)}#"
      
      process.nextTick ->            
        trans.flush()
        trans.onFlush.called.should.be.ok()
        trans.msg.should.not.ok()


