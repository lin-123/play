(function(){
  'use strict'
  var Footer = React.createClass({
    getInitialState: function(){
      return {choiced: 'all'}
    },
    handleFilter: function(e){
      let choiced = e.target.innerText.toLowerCase()
      this.props.statusSwitch(choiced)
      this.setState({choiced: choiced})
    },
    render:function(){
      return (
        <div className="footer">
          <span className='footer-left'>0 items left</span>
          <span onClick={this.handleFilter} className={this.state.choiced == 'all'?'active':''}>All</span>
          <span onClick={this.handleFilter} className={this.state.choiced == 'active'?'active':''}>Active</span>
          <span onClick={this.handleFilter} className={this.state.choiced == 'completed'?'active':''}>Completed</span>
        </div>
      )
    }
  })
  exports.Footer = Footer
}).call(this)
