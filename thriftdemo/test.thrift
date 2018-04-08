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
  void sayHello(1: string username)

  void sendMessage(1: MessageInfo messageInfo)

  i32 add(1: i32 num1, 2: i32 num2)

  void methodWithCallback(1: i32 count) throws(1: ErrorMessage errInfo)

  string throwError(1: bool errorOccure) throws(1: ErrorMessage errInfo)
}

