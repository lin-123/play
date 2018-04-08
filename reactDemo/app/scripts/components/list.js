(function(){
  'use strict'
  let ListItem = require('./listItem')
  var List = React.createClass({
    // getInitialState: function(){
    //   return {list_xx: 'asdf'}
    // },
    render: function(){
      let props = this.props

      return (
        <div className="list">
          <ul>
          {
            this.props.list.map(function(value, index){
              // let id = 'todo_list_'+index
              if(value.status & props.filter)
                return ListItem({value:value, id:index, updateList:props.updateList})
            })
          }
          </ul>
        </div>
      )
    }
  })
  exports.List = List
}).call(this)
