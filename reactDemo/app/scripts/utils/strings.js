(function(){
  'use strict'
  module.exports = {
    status: {
      // 二进制位运算 两种状态： 01, 10
      // filter = 1 [active], 2[completed], 3[active+completed]
      active: 1,
      completed: 2,
      all: 3
    },
    listNames: ''
  }

}).call(this)
