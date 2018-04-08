# thrift demo

**源代码总会给你答案**

## Thrift 脚本可定义的数据类型包括以下几种类型：


- 基本类型：

    ```
    bool：布尔值，true 或 false，对应 Java 的 boolean
    byte：8 位有符号整数，对应 Java 的 byte
    i16：16 位有符号整数，对应 Java 的 short
    i32：32 位有符号整数，对应 Java 的 int
    i64：64 位有符号整数，对应 Java 的 long
    double：64 位浮点数，对应 Java 的 double
    string：未知编码文本或二进制字符串，对应 Java 的 String
    ```

- 结构体类型：
    ```
    struct：定义公共的对象，类似于 C 语言中的结构体定义，在 Java 中是一个 JavaBean
    ```

- 容器类型：
    ```
    list：对应 Java 的 ArrayList
    set：对应 Java 的 HashSet
    map：对应 Java 的 HashMap
    ```

- 异常类型：
    ```
    exception：对应 Java 的 Exception
    ```

- 服务类型：
    ```
    service：对应服务的类
    ```

## thriftfile 书写方式

```coffee
struct MessageInfo{
  1: string user
  2: string datetime
  3: string content
}

# 抛出异常的 数据类型
exception ErrorMessage{
  1: i32 type
  2: string message
}

service Test {
  # 无返回值
  void sendMessage(1: MessageInfo messageInfo)

  # 可以返回int 类型结果
  i32 add(1: i32 num1, 2: i32 num2)

  # 可以返回string 类型数据，若发生异常可以抛出异常
  string throwError(1: bool errorOccure) throws(1: ErrorMessage errInfo)
}
```

## 注意事项

1. 调用thrift 方法时 所有参数必须与 thriftfile 中对应方法的参数类型相同
``client = thrift.createClient test, connection``
如:
    ```coffee
    # 自定义类型必须从thrift_types 中取
    messageInfo = new ttypes.MesssageInfo
        user: 'kakaka'
        datetime: new Date().toString()
        content: 'message'

    client.sendMessage messageInfo
    ```

2. 当被调用函数有返回值时，可通过回调函数（callback err, result）获得返回值， thrift 返回的参数类型也需要与thriftfile 中定义的相同
    - client 端
        ```coffee
        client.add 1, 2, (err, result)->
            # result = 1+2
        ```

    - server 端, callback参数固定为 err, resultValue
        ```coffee
        add = (num1, num2, cb)->
            cb null, num1+num2
        ```

3. 当被调用函数可以捕获异常时， server 端可以在callback 中返回错误消息

    - server端
        ```coffee
        throwError = (flag, cb)->
            if flag
                err = new ttypes.ErrorMessage
                type: 1
                message: 'error'
                return cb err
            cb null, 'work well'
        ```

## 附

```
client 调用 thrift 的 server 端时，thrift 内部是通过网络调用 server，需要等待网络返回消息，所以客户端调用 thriftserver 时，函数结果不会立即返回，此时返回值状态为`{state: pending, result}`
故利用js 异步回调方式返回数据即 `callback(err, result)`，当调用出现问题将出错信息通过error 返回；
  调用没有错误时， 将结果放入result 返回

当调用函数返回值类型为 void : callback err
否则                     : callback err, result
  所以当调用 add 函数时， 一下这种方式为正确方式
  client.add 1, 2, (err, result)->

thrift 中回调为 callback(err, result) 是因为 thrift 在生成js 文件时设置了callback的格式
```