

var InputArea = React.createClass({
  getInitialState: function(){
    return {msg: 'this is a state...', clicked: false}
  },
  // state 通过 this.setState({key: value}) 设置
  handleChange: function(e){
    // this.state.msg = JSON.stringify(e);
    this.setState({msg: e.target.value + ' asdadfs'})
  },
  clickP: function(){
    console.log('p clicked', arguments, this.state.clicked)
    this.setState({clicked: !this.state.clicked})
    // window.refs = this.refs
    // this.refs.ref_input.getDOMNode().focus();
    this.props.handleInput(this.state.clicked)
  },
  render: function(){
    return (
      <div>
        <p ref='ref_p'>this is ref demo</p>
        <input ref='ref_input' type='text' onChange={this.handleChange}/>
        <p onClick={this.clickP}>click me: {this.state.msg}, click statue: {this.state.clicked}</p>
        <p>{this.props.msg}</p>
      </div>
    );
  }
});

// OuterTag 组件名首字母大写
// 数据需要层层传递， 想函数传参一样
// render return 一个html代码块， return的代码块不能是fragement【需要有一个标签包裹在外面】
var OuterTag = React.createClass({
  getInitialState: function(){
    return {msg: 'this is outerTag msg'}
  },
  // 反向数据传递
  getChildeInput: function(value){
    console.log('getChildeInput, ', value)
    this.setState({msg: value.toString()})
    // this.state.msg = value
  },
  render: function(){
    var that = this;
    return (
      <div>
        <InputArea ref='asdf' msg={this.state.msg} handleInput={this.getChildeInput}/>
        <p>outer tag:  {this.state.msg}</p>
      </div>
    );
  }
});

React.render(
  <OuterTag/>,
  document.getElementById('example')
);
