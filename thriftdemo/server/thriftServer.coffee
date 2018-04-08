ttypes = require '../gen-nodejs/test_types'

module.exports = 
  sayHello: (username)->
    # console.log "Hello #{username}", arguments
    console.log "Hello #{username}" if username.indexof '0000'

  add:(num1, num2, callback)->
    console.log "call add with args: #{JSON.stringify arguments}"
    resNum = num1+num2
    # callback(arg1: err, arg2: return value)
    # 其中 arg1 为错误处理， 当arg1 不为null 时， arg2自动置为undefined
    # 当arg1 = null, arg2 必须为test.thrift 文件中定义的返回类型， 否则为0 （初始值）
    callback null, resNum
    
  sendMessage: (message)->
    console.log message.datetime
    console.log "#{message.user}: #{message.content}"

  methodWithCallback: (count, callback)->
    console.log "methodWithCallback : count=#{count}"
    switch count
      when 1 then msg = 1 
      when 2 then msg = true
      when 3 then msg = 'string'
      else 
        msg = new ttypes.ErrorMessage
          type: 1
          message: 'Error'    
    callback msg

  throwError: (errorOccure, callback)->
    console.log 'call throwError', arguments
    if not errorOccure
      return callback null, 'work well...'

    err = new ttypes.ErrorMessage
      type: 1
      message: 'Error'
    callback err



