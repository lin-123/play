# 面试题复盘

- 没什么说的，无论你做了多少年前端，还是基础最重要
- [ECMAScript5.1-ch](http://yanhaijing.com/es5/#about)
- [ECMAScript6](http://www.ecma-international.org/ecma-262/6.0/)

## [原型对象， 就是prototype对象](./prototype.md)

## 闭包

> 指的是有权访问另一个函数作用域中的变量的函数。 <br/> 通俗点： 就是A函数内嵌套了一个B函数，并且B函数访问了A函数内的变量。

- 涉及到的知识点： 作用域链。如果对这个理解的比较透彻就没问题了
- 缺点： 多度使用闭包会导致内存占用过多， 所以只在必要[非用不可]的时候才选择用闭包。

## [递归](./recusive.md)

## 函数

> 所谓编程，就是将一组需求分解成一组函数与数据结构的技能

### `this`

> 是一个对象。 是一个指向函数执行时调用他的那个对象

> 函数有四种调用方式，`方法调用模式`、 `函数调用模式`、 `构造器调用模式`、 `apply调用模式`，this 就来自于这四种调用方式

1. 方法调用模式
    - 当一个函数被当做一个对象的属性时，函数就称作方法。
    - 当函数执行时， this 就指向这个对象。在函数内部可以访问、操作这个对象的属性
    ```javascript
    const obj = {
      name: 'kaka',
      say() {
        console.log(this.name)
      }
    }
    obj.say() // 'kaka'
    ```
    - 但是，这个方法的执行必须要通过 obj.[method] 这种方式调用
2. 函数调用模式
    - 就是最常规的方式，定义一个函数，然后执行这个函数。这个时候 this 是指向全局对象。
      ```javascript
      function hi() {
        console.log(this) // window
      }
      hi()
      ```
    - *注：* this指向全局。据`Javascript语言精粹`说，是一个语言上的错误。倘若语言设计正确，那么当内部函数被调用的时候this应该指向外部函数的this，而非全局。
      ```javascript
      const obj = {
        name: 'kaka',
        say() {
          function hi () {
            // hi window
            console.log('hi', this.name, this)
          }
          // my name is kaka
          console.log('my name is: ', this.name)
          hi()
        }
      }
      obj.say()
      ```

3. 构造器调用模式
    - 用`new function()`的方式调用。这种方式会创建一个对象，并将函数的 this 指向这个对象，同时创建一个 constructor 指向构造函数，一个 prototype 对象。
      ```javascript
      function Man(name){
        this.name = name
      }
      Man.prototype.say = function (){
        console.log(this.name)
      }
      const kaka = new Man('kaka')
      console.log(kaka.say()) // kaka
      ```

4. apply，call，bind 调用模式。 此处以 apply 举例
    - 通过 functionName.apply 的方式调用，允许我们定义函数 this 的值。
      ```javascript
      const obj = {
        name: 'kaka'
      }
      function say(msg) {
        console.log(this.name, msg)
      }
      say.apply(obj, [', welcome'])
      ```

## 高阶函数

### 附录
- [javascript高阶函数介绍](https://www.imys.net/20160530/javascript-advanced-functions.html)
