
Cirru Candy Box
------

Demo: http://repo.cirru.org/candy-box

Candy box shows each value in current scope,
and makes REPL simple and interesting.

![](http://cirru.qiniudn.com/cirru-candy-box.png)

Supported commands:

```cirru
-- basic math
set a 1
set b 2
set c $ + a b 4
set d $ - c a b

-- scopes
set a $ map (b 1)
cd a
..
set b $ list 1 2 3
cd b
```

Keyboard events:

* Enter - fun command
* Up - history previous
* Down - history next

### Issues

* `list` command is still buggy
* `function` command not implemented