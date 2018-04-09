function Car() {
  this.name = 'car'
}
Car.prototype.sayName = function() {
  console.log('name', this.name)
}

function Benz() {
  Car.call(this)
  this.brand = 'benz'
}
Benz.prototype = Car.prototype
Benz.prototype.constructor = Benz
Benz.prototype.sayBrand = function() {
  console.log('brand', this.brand)
}

const benz_A453 = new Benz()
benz_A453.sayName()

// const obj = {
//   name: 'kaka',
//   say() {
//     function hi () {
//       console.log('hi', this.name, this) // undefined
//     }
//     console.log('my name is: ', this.name)
//     hi()
//   }
// }
// obj.say()



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

