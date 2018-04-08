# server.coffee
thrift = require('thrift')
test = require('./gen-nodejs/Test')

handler = require './server/thriftServer'

# 将业务逻辑处理转移至下层， 且无需写参数列表
server = thrift.createServer test,
  sayHello: handler.sayHello
  add: handler.add
  sendMessage: handler.sendMessage
  methodWithCallback: handler.methodWithCallback
  throwError: handler.throwError

, {}

port = process.env.PORT or 9016
server.listen process.env.PORT or port, () ->
  console.log 'server listening on', port
  callback?()
