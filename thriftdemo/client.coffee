ttypes = require('./gen-nodejs/test_types')
client = require('./client/thrift_client_generator').getClient()

# console.log client
# client.add 1, 0, -> console.log arguments
# client.add 1, 1, -> console.log arguments
# client.add 1, 2, -> console.log arguments
# client.add 1, 3, -> console.log arguments
# client.add 1, 4, -> console.log arguments
# client.add 1, 5, -> console.log arguments
# client.add 1, 6, -> console.log arguments
# client.add 1, 7, -> console.log arguments
# client.add 1, 8, -> console.log arguments
# client.add 1, 9, -> console.log arguments

for i in [0..50000]
  client.sayHello 'kakaka'+i,->
    console.log arguments


# setInterval ->
#   for i in [0..50]
#     client.sayHello 'kakaka'+i,->
#       console.log arguments

# ,1000

func = ->
# 1. 普通无返回值函数
  console.log 'client.sayHello: username = kakaka'
  client.sayHello('kakaka')

# 2. 参数中有复杂数据类型
  # client 输入参数必须是严格类型， 否则无法通过thrift
  message = new ttypes.MessageInfo
    user: 'kakaka'
    datetime: new Date().toString()
  message.content = "send message"
  console.log 'client.sendMessage: message =', message.content
  client.sendMessage message

# 3. 带有返回值的函数， 函数不会立即返回， 当state=pending 时说明正在等待函数返回，
  # 此时可用js 特有的回调方式 调用此函数，然后在callback中取得结果
  client.add 1, 2, (err, result)->
    console.log "client.add: 1+2=#{result}", arguments

  # 另一种方式， 不推荐
  #  当state=fulfilled 时说明函数正常返回数值
  addReuslt = client.add(1,2)
  setTimeout ->
    console.log 'client.add', addReuslt
  ,1000

  range_3 = ->
    # addReuslt1 = client.add(1,3)
    # flag = true
    # while flag
    #   if addReuslt1.state is 'fulfilled'
    #     flag = false
    #     console.log "client.add return: #{addReuslt1}"


# 4. 无返回值， 捕获异常
  # 回调函数返回值也必须是固定类型， 否则thrift 不能接受
  # 如下实例中 当methodWithCallback 第一个参数为
  # 1：期望返回int类型  实际返回{ '0': null, '1': undefined }
  # 2：期望返回bool类型  实际返回{ '0': null, '1': undefined }
  # 3：期望返回string类型  实际返回{ '0': null, '1': undefined }
  # 4：期望返回struct类型  实际返回{ '0':
                                #  { [ErrorMessage: this is a struct type]
                                #    name: 'ErrorMessage',
                                #    type: 0,
                                #    message: 'this is a struct type' },
                                # '1': undefined }

  client.methodWithCallback 1, (res)->
    console.log "methodWithCallback callback: #{res}" , arguments

  client.methodWithCallback 2, (res)->
    console.log "methodWithCallback callback: #{res}" , arguments

  client.methodWithCallback 3, (res)->
    console.log "methodWithCallback callback: #{res}" , arguments

  client.methodWithCallback 4, (res)->
    console.log "methodWithCallback callback: #{res}" , arguments

# 5. 可以抛出异常 并且有返回值 的函数
  throwErrStr = client.throwError true, ->
    console.log 'throwError callback: ', arguments

  throwErrStr = client.throwError false, ->
    console.log 'throwError callback: ', arguments

# func()

# tips
range_tips = ->
  objEmpty = (obj)->
    # 一个关于coffee 与 javescript 在 for(item in obj) 上的区别的解释
      # obj = {a:1, b:2}
      # javaScript :
      # for(var item in obj){
      #   item = a, b
      #   obj[item] = 1, 2
      # }
      #
      # coffee-script:
      # for key, value of obj
      #   key = a, b
      #   value = 1, 2
    for item of obj
      return false

    return true

  console.log "{} is empty should be true: #{objEmpty({})}"

  console.log "{a:1} is empty should be false: #{objEmpty({a:1})}"

# range_tips()


