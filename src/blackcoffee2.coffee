#!/usr/bin/env node

Fs = require 'fs'
Path = require 'path'
lib = Path.join Path.dirname(Fs.realpathSync(__filename)), '../lib/coffee-script'
Coffee = require "#{lib}/coffee-script"
Nodes = require "#{lib}/nodes"
SourceMap = require "#{lib}/sourcemap"
Macro = require "#{lib}/macro"

args = process.argv.slice 2

i = 0
while i<args.length
	arg = args[i++]
	continue if arg[0]!='-'
	args.splice --i, 1
	break if arg=='--'
	if arg=='-o'
		output = args[i]
		args.splice i, 1
	else if arg=='-m'
		map = args[i]
		args.splice i, 1
	else
		printWarn "invalid option '#{arg}'"
		process.exit 1

asts = []
for file in args
	cs = Fs.readFileSync(file).toString()
	asts.push Coffee.nodes cs

ast = new Nodes.Block(asts)
ast = Macro.expand(ast, Coffee.nodes)
fragments = ast.compileToFragments()
js = (fragment.code for fragment in fragments).join('')

if output
	Fs.writeFileSync output, js, null, "wx"
else
	process.stdout.write js

if map
    sourceMap = new SourceMap fragments
    sourceMap = sourceMap.generate {inline: true}
    Fs.writeFileSync map, sourceMap, null, "wx"

