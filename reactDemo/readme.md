reactjs todo list demo
》》》quest： 

```  
  todo list
  create model to handle data


    // app = {props: Object, context: Object, refs: Object, updater: Object, state: Objec}
    // 
    // 通过改变app.setState({stateName: value}) 更新数据
    //
    // 用react.render 加载组件
    // ？？？ react.createFactory
    // mixin 用法
```

》》》done
#整理使其符合mvc框架
#避免listName重复
#使用mixin
#mixin 用法, 避免写重复的代码
`http://simblestudios.com/blog/development/react-mixins-by-example.html`

#3.反向数据传递， 通过回调函数实现
    1. 数据传回来后如何更新dom树， 通过改变state的值更新dom树
    2. react是单向数据传输， props只中的变量是只读变量。 不能通过this.props.parameXX = value 来赋值

#2.交互， 通过click 改变状态
#1.react从上到下传递参数
    子组件通过 this.props 获得数据

#组件名首字符【OuterTag】用大写
```
var OuterTag = React.createClass({
  render: function(){
    return (
      <div>
        <InputArea />
      </div>
    );
  }
});
```


#准备
react的jsx代码离线转化工具
 npm install -g react-tools

jsx,babel 语法高亮配置：  https://segmentfault.com/a/1190000003698071