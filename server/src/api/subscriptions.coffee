{log} = require '../appconfig'
{set_header,wrapper,error_codes} = require './common_utils'

data = 
	[ 
		{ id: "s1", name: "Netflix",  type: "Movie Streaming" },
  	{ id: "s2", name: "LinkedIn", type: "Career Network" }
	]

module.exports = 
	get: (req,res)->
		set_header res
		res.end wrapper data, error_codes.SUCCESS

	add: (req,res)->
		set_header res
		data.push req.body
		res.end wrapper {}, error_codes.SUCCESS	
