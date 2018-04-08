(function(){
  'use strict'
  let strings = require('../utils/strings')
  let deleteTag = require('./deleteTag')
  var ListItem = React.createClass({
    statusChange: function(e){
      // 改变这个liteItem状态
      let value = this.props.value
      value.status = strings.status.all - value.status
      this.props.updateList('updateItem', this.props.id, value)
    },
    render: function(){
      let item = this.props.value
      let liClass = item.status === strings.status.active? 'item-active':'item-completed'
      let checked = item.status==strings.status.completed
      // onClickCapture 捕获非事件冒泡而产生的事件
      return (
        <li className={liClass} ref='ref_item' onClickCapture={this.statusChange}>
          <input type="checkBox" checked={checked}></input>
          {item.content}
          {deleteTag({updateList: this.props.updateList, id: this.props.id}) }
        </li>
        )
    }
  })

  module.exports = React.createFactory(ListItem)
}).call(this)
