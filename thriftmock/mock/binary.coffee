_ = require 'lodash'

module.exports = 
  toByte: (value)-> @intToBuf value, 1

  toI16: (value)-> @intToBuf value, 2
  
  toI32: (value)-> @intToBuf value, 4

  byteToInt: (buf, offset)-> @bufToInt buf, 1, offset

  i16ToInt: (buf, offset)-> @bufToInt buf, 2, offset

  i32ToInt: (buf, offset)-> @bufToInt buf, 4, offset

  intToBuf: (value, size)->
    buf = new Buffer size

    while size > 0
      buf[size-1] = value & 0xff
      value >>= 8 
      size--
    buf

  bufToInt: (buf, size, offset)->
    value = 0
    
    while size > 0
      value += buf[offset]
      value <<= 8 if size > 1
      offset++
      size--

    value


