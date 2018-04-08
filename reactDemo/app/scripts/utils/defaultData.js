(function(){
  module.exports = strings = {
    status: {
      all: -1,
      active: 0 ,
      completed: 1
    },
    list: [
      {status: 0, content: 'list1'},
      {status: 1, content: 'list2'},
      {status: 0, content: 'list3'}
    ]
  }

  localStorage.todo = JSON.stringify(strings.list);
}).call(this)
