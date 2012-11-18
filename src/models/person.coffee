class Person
  constructor: (@name, @groups = [], @fullname = @name) ->
    console.log "New Person #{@name}"


module.exports = Person
