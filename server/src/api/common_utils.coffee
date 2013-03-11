exports.wrapper = (payload,err_code)->
	JSON.stringify 
		error: err_code 
		payload: payload 