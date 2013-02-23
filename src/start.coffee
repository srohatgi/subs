{spawn} = require('child_process')

start_fn = (args)->
	node = spawn(process.execPath, args, {stdio: [0,1,2]})
	node.on 'exit', (code)->
		process.stderr.write "Exiting node with code: #{code}\n"
		process.exit code

if process.argv.length <= 2
	make = spawn('make', [], { stdio: ['ignore',1,2] })

	make.on 'exit', (code)->
  	if code != 0
    	process.exit code

  	process.stderr.write "Yahoo! make passed!\n"
  	start_fn [ 'lib/app.js' ]
else
	start_fn [ 'lib/app.js', process.argv[2] ]
	