# test.test.coffee
describe.only 'test all unkown', ->
  describe 'fs', ->
    fs = require 'fs'
    path = require 'path'
    pathToUser = path.join(__dirname, '../fileData/users.json')
    
    user = 
      id:1
      username: 'kakaka'
      age:22

    users = {}
    for i in [0..2]
      user.id = i
      users[user.id] = user
      
    it 'writeFile', (done)->
      fs.writeFile pathToUser, JSON.stringify(users), (err, result)->
        throw err if err 
        console.log result
        done()

    xit 'appendFile', (done)->
      fs.appendFile pathToUser, JSON.stringify(user), (err, result)->
        throw err if err
        console.log result
        done()

    it 'readFile', (done)->
      fs.readFile pathToUser, 'utf8', (err, data)->
        throw err if err
        console.log typeof data
        users = JSON.parse data;

        console.log users[0], users[1]

        done()
