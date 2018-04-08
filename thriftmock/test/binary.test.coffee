sinon = require 'sinon'
should = require 'should'

binary = require '../mock/binary'

describe 'binary', ->
  describe 'toByte', ->
    it '', ->
      binary.toByte(1).should.eql Buffer [0x01]
      
      binary.toByte(3).should.eql Buffer [0x03]

      binary.toByte(-1).should.eql Buffer [0xff]

  describe 'intToBuf', ->
    it.only '', ->
      console.log binary.intToBuf 19170, 4
      console.log binary.intToBuf 723819, 4
      console.log binary.intToBuf(16777217,4)

      binary.intToBuf(1,1).should.eql Buffer [0x01]
      
      binary.intToBuf(2,2).should.eql Buffer [0x00, 0x02]

  describe 'bufToInt', ->
    it '', ->
      console.log binary.bufToInt Buffer([1, 8, 0x73, 0x61]), 4, 0
      console.log binary.bufToInt Buffer([0,0x80, 1, 0]), 4, 0
      

      binary.bufToInt(Buffer([0x01]), 1, 0).should.eql 1

      binary.bufToInt(Buffer([0x00, 0x01]), 1, 0).should.eql 0

      binary.bufToInt(Buffer([0x00, 0x01]), 2, 0).should.eql 1

  xdescribe 'test', ->
    it 'lodash', ->
      _ = require 'lodash'

      # buf = new Buffer 2
      buf = [10,20]
      console.log buf
      _(buf).map (value, index)->
        value++

      console.log buf

