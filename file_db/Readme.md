#文档 数据存储
```
#model user 
user = [
    obj1=
        a:a
        b:b,
    obj2=
        a:a
        b:b,
    ...
]
```

###定义数据类型
   ````
    user.create()
    user.push(user)
    向文档追加数据

    user.find()
    查找user

    user.update()
    1. user.find()
    2. user.a = ** or user.b = **

    user.delete()
    1. user.find()
    2. user.pop()
    3. 删除文档中 一条数据
   ``` 