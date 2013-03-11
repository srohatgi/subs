{log} = require '../appconfig'
{wrapper,error_codes,set_header} = require './common_utils'

data = [
 { 
 	id: "1" 
 	name: 'sumeet rohatgi'
 },
 {
 	id: "2"
 	name: 'nidhi rohatgi'
 }
]

module.exports = 
	get: (req,res)->
		set_header res

		log.info "id = #{req.params.id}"
		id = req.params.id
		for d in data
			log.info "d = #{JSON.stringify d}"
			if d.id == id
				res.end wrapper d, 0
				return

		res.end wrapper { error: 'unknown account' }, error_codes.NOT_FOUND