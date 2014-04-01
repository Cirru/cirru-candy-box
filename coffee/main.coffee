
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
    command: 'set a 1'
    cacheCommand: ''
    history: []
    cursor: 0
  computed:
    location: ->
      @stack.join ' > '
  methods:
    confirm: ->
      code = @command
      @history.unshift code
      @cursor = 0
      ast = (parse code)[0]
      run @theScope, ast, @stack
      @$set 'theScope', @theScope
      @command = ''
    prevCommand: (event) ->
      event.preventDefault()
      if @cursor is 0
        @cacheCommand = @command
      if (@cursor + 1) <= @history.length
        @cursor += 1
        @command = @history[@cursor - 1]
    nextCommand: (event) ->
      event.preventDefault()
      if @cursor > 0
        @cursor -= 1
        if @cursor > 0
          @command = @history[@cursor - 1]
        else
          @command = @cacheCommand
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