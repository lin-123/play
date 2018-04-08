(function(){
  'use strict'
  var strings = require('../utils/strings')

  var listModel = {
    list: [],
    getList: function(name){
      let tmpList = localStorage[name]
      // 获取的tmpList 不是undefined, 不是非数组类型e
      return (tmpList)&&(JSON.parse(tmpList) instanceof Array)&&(this.list = JSON.parse(tmpList))|| [];
    },
    setList: function(name){
      localStorage[name] = JSON.stringify(this.list);
      return true
    },
    removeList: function(name){
      delete(localStorage[name])
    },
    addItem: function(name, item){
      if(checkDuplicate(this.list, item)){return alert('已有此list')}
      this.list.push(item);
    },
    removeItem: function(name, index){
      return this.list.splice(index, 1);
    },
    updateItem: function(name, index, value){
      if(checkDuplicate(this.list, value)){return alert('已有此list')}
      this.list[index] = value
    },
    selectAll: function(name){
      let list = this.getList(name)

      // 当有active状态的list时， 则全选； 否则， 全不选
      let haveAcitveList = list.some(function(value){return value.status === strings.status.active})? 1:0
      let result = this.getList(name).map(function(value){
        value.status = strings.status[haveAcitveList? 'completed': 'active'] // 位运算
        return value
      })
      this.list = result
    },
    storeFactory: function(method, args){
      console.log('call storeFactory, ', JSON.stringify(arguments))

      if(method!=='getList')
        this.list = this.getList(args[0])

      this[method].apply(this, args);

      if(method=='addItem' || method == 'removeItem'|| method == 'updateItem'|| method == 'selectAll'){
        this.setList(args[0])
      }
      return this.list
    },
  }

  function checkDuplicate(list, item){
    // 每个todo名是否重复
    return list.some(function(value){
      return (typeof(value) == 'string')&&(value == item)
    })
  }

  module.exports = listModel
}).call(this)