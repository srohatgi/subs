{spawn} = require('child_process')

make = spawn('make', [], { stdio: ['ignore',1,2] })

make.on 'exit', (code)->
	if code != 0
  	process.exit code
  	return

	process.stderr.write "Yahoo! make passed!\n"
	
	node = spawn(process.execPath, [ 'lib/app.js' ], {stdio: [0,1,2]})

	process.on 'exit', (signal)->
		node.kill 'SIGTERM'

	node.on 'exit', (code)->
		process.stderr.write "Exiting node with code: #{code}\n"