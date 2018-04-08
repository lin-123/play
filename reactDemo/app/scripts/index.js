(function(){
  'use strict'
  let ListWraper = require('./components/listWraper.js').ListWraper;
  window.app = app || {}

  app.modle = ReactDOM.render(
    ListWraper({name: 'listNames'}),
    document.getElementById('app')
  )

}).call(this)