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

find_data = (id)->
	for d in data
		return d if d.id == id 
	return null

module.exports = 
	get: (req,res)->
		set_header res

		log.info "id = #{req.params.id}"
		d = find_data req.params.id
		return res.end wrapper d, 0 if d

		res.end wrapper { error: 'unknown account' }, error_codes.NOT_FOUND

	put: (req,res)->
		set_header res

		log.info "id = #{req.params.id} body = #{JSON.stringify req.body}"
		d = find_data req.params.id
		return res.end wrapper { error: 'unknown account' }, error_codes.NOT_FOUND if not d

		d[prop] = req.body[prop] for prop of req.body
		res.end wrapper {}, error_codes.SUCCESS

