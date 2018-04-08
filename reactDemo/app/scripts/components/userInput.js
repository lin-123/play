(function(){
  'use strict'
  let strings = require('../utils/strings')
  var UserInput = React.createClass({
    getInitialState: function(){
      return {content: ''}
    },
    handleKeyDown: function(e){
      // var content = this.refs['ref_content'].value
      if(e.keyCode === 13 && this.refs['ref_content'].value !==''){
        let content = this.refs['ref_content'].value;
        this.props.updateList('addItem', {content: content, status: strings.status.active})
        this.refs['ref_content'].value = '';
      }
    },
    selectAll: function(){
      this.props.updateList('selectAll')
    },
    render: function(){
      return (
        <div className="header">
          <label onClick={this.selectAll}>select all</label>
          <input type="text" placeholder="Whate needs to be done?" ref='ref_content' onKeyDown={this.handleKeyDown}></input>
        </div>
      )
    }
  })
  exports.UserInput = UserInput
}).call(this)
