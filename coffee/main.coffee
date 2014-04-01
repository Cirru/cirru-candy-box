
Vue = require 'vue'
parse = require('cirru-parser').parseShort
{run} = require './operator'

box = new Vue
  el: '#app'
  data:
    stack: []
    theScope:
      a: 1
      b: 'string'
    command: ''
    history: []
    cursor: 0
  computed:
    location: ->
      @stack.join ' > '
  methods:
    confirm: ->
      code = @command
      ast = (parse code)[0]
      run @theScope, ast, @stack
      @$set 'theScope', @theScope
      @command = ''
    prevCommand: (event) ->
      event.preventDefault()
    nextCommand: (event) ->
      event.preventDefault()
    foundType: (value) ->
      type = typeof value
      "type-#{type}"
    escapeType: (value) ->
      type = typeof value
      switch type
        when 'number' then value
        when 'string' then "\"#{value}\""
        when 'object' then '[Object]'
        when 'function' then '[Function]'