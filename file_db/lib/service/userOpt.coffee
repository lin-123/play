# userOpt.coffee
# Users = require '../model/User'

fs = require 'fs'
path = '../../fileData/users.json'

users = []
module.exports = 
  list: (cb)->
    fs.readFile path, 'utf8', (err, users)->
      cb err, users

  add: (User, cb)->
    Users.push User
    cb null, Users.length


  #  定期 将读出的数据 写入数据库  
  store: (Users, cb)->
    fs = require 'fs'
    fs.wirteFile '../../fileData/users.json', JSON.stringify(Users), (err, msg)->
      cb err, msg

