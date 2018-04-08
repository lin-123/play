# client.coffee
net = require 'net'
service = require './serviceHandler'
mock = require './mock'

connection = mock.createConnection 'localhost', 8124

client = mock.createClient service, connection


->
#1. 可以发送请求
  client.sayHello 'kakaka'

#2. 可以收到 callback
  client.sayHello 'kakaka', ->
    console.log arguments

#3. 同时发多条消息 # 压力测试 10w/s
# 通过将发送的消息转化成buffer处理
  client.sayHello 'kakaka9', ->
    console.log arguments
  client.sayHello 'kakaka0'


#4. 用buffer 发送消息， 避免因请求量过大而产生乱码
# 压力测试 5w*10*1000/s 但会间隔性出现数据乱码
#
# 乱码原因：
#   a. 在transport.receiver 中 数据写入速度 小于 数据读取速度

#
# 5. 解决乱码   
#  读取错误时需要重读消息， commitPosition  rollbackPosition

setInterval ->
  for i in [0..50000]
    client.sayHello 'kakaka1',->
      console.log arguments
    client.sayHello 'kakaka2',->
      console.log arguments
    client.sayHello 'kakaka3',->
      console.log arguments
    client.sayHello 'kakaka4',->
      console.log arguments
    client.sayHello 'kakaka5',->
      console.log arguments
    client.sayHello 'kakaka6',->
      console.log arguments
    client.sayHello 'kakaka7'
    client.sayHello 'kakaka8'
    client.sayHello 'kakaka9'
    client.sayHello 'kakaka0'
,1
