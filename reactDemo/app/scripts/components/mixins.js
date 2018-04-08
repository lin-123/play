(function(){
  'use strict'
  let store = require('../model/store')
  module.exports = {
    listFactory: function(){
      let arg = arguments
      let method = arg[0]
      arg[0] = this.props.name
      this.setState({list: store.storeFactory(method, arg)});
    },
    componentWillMount: function(){
      // update list state
      this.listFactory('getList')
    },
  }
}).call(this)

