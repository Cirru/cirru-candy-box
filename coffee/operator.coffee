
read = (scope, exp, stack) ->
  console.log 'read', exp
  if typeof exp is 'string'
    guess = Number exp
    if isNaN guess
      scope[exp]
    else
      guess
  else if Array.isArray exp
    func = exp[0]
    if methods[func]?
      methods[func] scope, exp[1..], stack

methods =
  get: (scope, args, stack) ->
    read scope, args[0], stack

  set: (scope, args, stack) ->
    key = args[0]
    value = read scope, args[1], stack
    scope[key] = value

  '+': (scope, args, stack) ->
    args.map (x) ->
      read scope, x, stack
    .reduce (x, y) ->
      x + y

  '-': (scope, args, stack) ->
    args.map (x) ->
      read scope, x, stack
    .reduce (x, y) ->
      x - y

exports.run = (scope, code, stack) ->
  read scope, code, stack