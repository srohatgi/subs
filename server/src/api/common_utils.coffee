exports.wrapper = (payload,err_code=error_codes.SUCCESS)->
	JSON.stringify 
		error: err_code 
		payload: payload

exports.set_header = (res)-> res.header 'Content-Type', 'application/json'

exports.error_codes = error_codes = 
	SUCCESS: 0
	NOT_FOUND: 100 