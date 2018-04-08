(function(){
  'use strict'
  let deleteTag = React.createClass({
    removeItem: function(){
      this.props.updateList('removeItem', this.props.id)
    },
    render: function(){
      return (
        <span className='delete-item' onClickCapture={this.removeItem}>delete</span>
        )
    }
  })
  module.exports = React.createFactory(deleteTag)
}).call(this)