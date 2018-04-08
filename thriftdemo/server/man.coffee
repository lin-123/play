class man
  constructor:(@name, @age)->
    @saytotal = 0
  
  say: (message)->
    @saytotal++
    console.log "name: #{@name}, #{@age} years old. #{message}"

  gone: ->
    console.log "baybay"

# man = new man('kakaka', 1000)
# console.log man.say('dddd'), '==='
exports.man = man
