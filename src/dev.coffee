{spawn} = require('child_process')
kexec = require('kexec')

make = spawn('make', [], { stdio: ['ignore',1,2] })

make.on 'exit', (code)->
	if code != 0
  	process.exit code
  	return

	process.stderr.write "make passed!\n"
	
	kexec("#{process.execPath} lib/app.js")

