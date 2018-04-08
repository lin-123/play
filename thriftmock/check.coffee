# check.coffee
Animal = (@name)->

Animal.prototype.eat = ->
  console.log @.name, 'can eat...'

cat = new Animal('cat')
cat.eat()
