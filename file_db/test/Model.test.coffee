should = require 'should'
userOpt = require '../lib/service/userOpt'  

describe "userOpt", ->
  describe "#userOpt.list", ->
    it "should have model[User]", (done)->
      userOpt.list (err, list)->
        console.log err, '---------', list;
        done()

  describe "#userOpt.add", ->
    it "userOpt length should increase 1", ->
      user = 
        username: 'hlj'
        age: 22
      userOpt.add user, (err, length)->
        console.log err, '-----', length
