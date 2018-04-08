thrift 源码阅读
对nodejs net类的改造

1. thrift node_modules 程序入口 
    ./lib/thrift/index.js

    通过网络传输实现交互，
        thrift.createServer service, hanlder, [options]
        可以在server端代码启动的位置分发请求


2. server 端
    将服务启动在指定 hosts:port 地址上。

```
test = require('./gen-nodejs/Test')
handler = require './server/thriftServer'
```

#server = thrift.createServer test, handler, {[options]}
```
  #entry thrfit node_modules 通过index.js 分发请求 ./lib/thrift/index.js
  exports.createServer = server.createServer 
    exports.createServer = function(processor, handler, options)
      processor = processor.Processor;
      createMultiplexServer(new processor(handler), options)
        return net.createServer(serverImpl);


```
    
    <!-- nodejs api net.createServer-->
    var net = require('net');
    var server = net.createServer(function(c) { // 'connection' 监听器
      console.log('服务器已连接');
      c.on('end', function() {
        console.log('服务器已断开');
      });
      c.write('hello\r\n');
      c.pipe(c);
    });
    server.listen(8124, function() { // 'listening' 监听器
      console.log('服务器已绑定');
    });

3. client 端
    向指定 hosts:port 发送请求，并等待结果返回。
```
thrift = require 'thrift'
test = require('../gen-nodejs/Test')
```

#connection = thrift.createConnection 'localhost', 9016, {transport: thrift['TBufferedTransport']}
```
#entry thrfit node_modules 通过index.js 分发请求 ./lib/thrift/index.js
exports.createConnection = connection.createConnection;
    # 其中host= 'localhost', port=9016
    exports.createConnection = function(host, port, options)
        var stream = net.createConnection(port, host);
        var connection = new Connection(stream, options);
            # 为connection 添加消息监听 和 一些事件处理
            var Connection = exports.Connection = function(stream, options)
        return connection;
```

```
# 解析 thrfit['TBufferedTransport']
# entry thrift node_modules in transport.js 
var TBufferedTransport = exports.TBufferedTransport = function(buffer, callback) 
```

#client = thrift.createClient test, connection
```
# entry thrift node_modules index.js 
    exports.createClient = connection.createClient;
        exports.createClient = function(cls, connection) {
            cls = cls.Client;
            client = new cls(new connection.transport(undefined, function(buf) {
                connection.write(buf);
              }), connection.protocol);

            return client
```

#thrift 调用流程
#开始
client.sayHello('kakaka')
 TestClient.prototype.sayHello = function(username, callback) {
    TestClient.prototype.send_sayHello = function(username)
        #output = protocol(...)       
        var output = new this.pClass(this.output)
        output.writeMessageBegin('sayHello', Thrift.MessageType.CALL, this.seqid());
            
            <!-- 初始化 -->
            TBinaryProtocol.prototype.writeMessageBegin = function(name, type, seqid) {
                this.writeI32(VERSION_1 | type);
                this.writeString(name);
                this.writeI32(seqid);
                    this.trans.write(binary.writeI32(new Buffer(4), i32));
                        write: function(buf, encoding) 
                            this.outBuffers.push(buf);

        var args = new Test_sayHello_args();
        args.write(output);

            <!-- 向outBuffers写数据 -->
            output.writeStructBegin('Test_sayHello_args');
            output.writeFieldBegin('username', Thrift.Type.STRING, 1);
            output.writeString(this.username);
            output.writeFieldEnd();

        output.writeMessageEnd();
        return this.output.flush();
            TCompactProtocol.prototype.flush = function() {
            return this.trans.flush();
                <!-- flush 过程： 写buffer -》 向server 发送buffer -》 清空buffer -->
                flush: function() 
                    <!-- 关于onFlush 见 thrift.createClient 中
                    client = new cls(new connection.transport(undefined, function(buf) {
                        connection.write(buf);
                      }), connection.protocol); -->
                    this.onFlush(msg);

    <!-- server端接收到消息 -->
    <!-- transport.receiver(function(transportWithData) 
        初始化TBufferedTransport(), 并返回TBufferedTransport
     -->
    stream.on('data', transport.receiver(function(transportWithData)
      // server端接收到数据， 
      // 传给transport.receiver处理， 
      // transport.receiver处理后  callback数据
      
      var input = new protocol(transportWithData);
      var output = new protocol(new transport(undefined, function(buf) {
        <!-- 向client返回请求结果 -->
        stream.write(buf);
      
      // 调用server的processor 即向对应方法发送请求
      <!-- processor = Test.processor -->
      processor.process(input, output);
        var r = input.readMessageBegin();
        <!--取得调用的函数名 
            this.process_sayHello.call this, r.rseqid, input, output -->
        return this['process_' + r.fname].call(this, r.rseqid, input, output);
          TestProcessor.prototype.process_sayHello = function(seqid, input, output) {
            var args = new Test_sayHello_args();
            <!-- 取得参数列表 -->
            args.read(input);

            <!-- 调用此方法 -->
            Q.fcall(this._handler.sayHello, args.username)
                <!-- 整理数据， 发送给客户端 -->
                var result = new Test_sayHello_result({success: result});
                output.writeMessageBegin("sayHello", Thrift.MessageType.REPLY, seqid);
                result.write(output);
                output.writeMessageEnd();
                output.flush();

    <!-- client 端接受 server 返回的消息 connection.js-->
    this.connection.addListener("data", self.transport.receiver(function(transport_with_data) {
        <!-- self = this -->
        var message = new self.protocol(transport_with_data);
            client['recv_' + header.fname](message, header.mtype, dummy_seqid);
                TestClient.prototype.recv_sayHello = function(input,mtype,rseqid) {
                  var result = new Test_sayHello_result();
                  result.read(input);
                  input.readMessageEnd();
                  callback(null) 
#调用结束


Test.js
exports.createServer = server.createServer 
    exports.createServer = function(processor, handler, options)
      processor = processor.Processor;
      createMultiplexServer(new processor(handler), options)
        return net.createServer(serverImpl);

createMultiplexServer(new processor(handler), options)
    TestProcessor = exports.Processor = function(handler) {

