function testThis() {
  var inner = 1
  console.log(this, this.inner)

  var innerF = function ff () {
    var inner = 2
    console.log(this, this.inner)
  }
  innerF()
}
testThis()

// // 高阶函数
// function comb(f1, f2){
//   return function(x) {
//     f2(f1(x))
//   }
// }

// function add(x) {
//   return function(y) {
//     return x+y
//   }
// }
// function del(x) {
//   return (y) => x - y
// }

// comb(add(1), del(2))(3)

