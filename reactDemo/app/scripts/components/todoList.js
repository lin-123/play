 (function(){
  'use strict'
  let strings = require('../utils/strings')

  let UserInput = require('./userInput.js').UserInput
  let List = require('./list.js').List
  let Footer = require('./footer').Footer
  let deleteTag = require('./deleteTag')

  let listFactoryMixin = require('./mixins')

  var TodoList = React.createClass({
    mixins: [listFactoryMixin],
    getInitialState: function(){
      return {selectAll:false, filter: strings.status.all, list: []}
    },
    statusSwitch: function(status){
      // {key: value}
      this.setState({filter: strings.status[status]})
      console.log('update state:', arguments);
    },
    deleteTodo: function(method, id){
      this.props.updateList(method, id)
      this.listFactory('removeList')
    },
    render:function(){
      let listName = this.props.name;
      return (
        <div className='todoList'>
          <h1>
            list {listName}
            {deleteTag({updateList: this.deleteTodo, id: this.props.id}) }
          </h1>
          <div className="todo">
            <UserInput updateList={this.listFactory}/>
            <List filter={this.state.filter} list={this.state.list} updateList={this.listFactory}/>
            <Footer statusSwitch={this.statusSwitch}/>
          </div>
        </div>
      )
    }
  })
  exports.TodoList = React.createFactory(TodoList)
}).call(this)