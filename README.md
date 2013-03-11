BlackCoffee
===========

BlackCoffee is CoffeeScript with a few simple but powerful tweaks:

* The **`meta` keyword** allows compile time code execution.

```coffeescript
debugStuff() if meta config.debugging

if meta !!config.project.match /-mobile$/
    enableTouchEvents()

# compile time declared css function that generates css file
# included in separate file
meta css 'someTarget',
    'width': '100%'
```

+ **Non-returning functions** using `!->` or `!=>`

```coffeescript
setTimeout (!-> doSomething 1), 20

# when used with a html generation library such as KoffeeCup
DIV !-> UL !->
    LI !->
        @innerText = 'some list item'
```

+ **Upscoping**, which is mainly useful on the outer scope
  (enabling exposing of variables over the outer scope).
  Combine with uglifyjs to allow minification of exposed API
  functions.

```coffeescript
do -> ^variable = 12
console.log variable # will be 12
```


+ Simpler `blackcoffee` compiler that allows compiling multiple
  files. `meta` code is executed in the same context, enabling
  inclusion of common compile time code (eg config definition).
  Literate coffeescript is enabled automatically when the second
  line of any input file only contains `=` characters.

Read up on CoffeeScript and its magic at http://coffeescript.org.

