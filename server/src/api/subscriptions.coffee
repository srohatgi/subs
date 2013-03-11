{log} = require '../appconfig'
{wrapper} = require './common_utils'

data = 
	[ 
		{ id: "s1", name: "Netflix",  type: "Movie Streaming" },
  	{ id: "s2", name: "LinkedIn", type: "Career Network" }
	]

module.exports = 
	get: (req,res)->
		res.header 'Content-Type', 'application/json'
		res.end wrapper data, 0

	add: (req,res)->
		data.push req.body
		res.end wrapper {}, 0 	
