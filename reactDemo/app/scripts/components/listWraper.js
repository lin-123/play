  (function(){
  'use strict'
  let listFactoryMixin = require('./mixins')

  let TodoList = require('./todoList').TodoList
  var Wraper = React.createClass({
    mixins: [listFactoryMixin],
    getInitialState: function(){
      return {list: []}
    },
    handleKeyDown: function(e){
      switch(true){
        case e.keyCode !== 13: break;
        case !this.refs['ref_list_name'].value: break;
        default: {
          let newName = this.refs['ref_list_name'].value
          this.listFactory('addItem', newName);
          this.refs['ref_list_name'].value=''
          let list = this.listFactory('getList', this.props.name)
        }
      }
    },
    render:function(){
      let listFactory = this.listFactory
      return (
        <div>
          <input className="add-list-name" placeholder="new list name..." ref='ref_list_name' onKeyDown={this.handleKeyDown}></input>
          {
            this.state.list.map(function(value, index){
              return TodoList({name:value, id:index, updateList: listFactory})
            })
          }
        </div>
      )
    }
  })

  exports.ListWraper = React.createFactory(Wraper);
}).call(this)