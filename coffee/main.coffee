
Vue = require 'vue'
parse = require('cirru-parser').parseShort
{run} = require './operator'

box = new Vue
  el: '#app'
  data:
    stack: []
    theScope:
      nothing: 'empty'
      s:
        zero: 0
    command: 'cd s'
    cacheCommand: ''
    history: []
    cursor: 0
  computed:
    currentScope: ->
      dest = @theScope
      for name in @stack
        dest = dest[name]
      dest
  methods:
    confirm: ->
      code = @command
      @history.unshift code
      @cursor = 0
      ast = (parse code)[0]
      run @currentScope, ast, @stack
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
      if Array.isArray value
        return 'type-list'
      type = typeof value
      switch type
        when 'number' then 'type-number'
        when 'string' then 'type-string'
        when 'object' then 'type-map'
        when 'function' then 'type-function'
    escapeType: (value) ->
      if Array.isArray value
        return '[List]'
      type = typeof value
      switch type
        when 'number' then value
        when 'string' then "\"#{value}\""
        when 'object' then '[Map]'
        when 'function' then '[Function]'