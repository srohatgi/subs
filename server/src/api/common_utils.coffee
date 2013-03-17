{log} = require '../appconfig'

exports.wrapper = (payload={},err_code=error_codes.SUCCESS,message=error_codes["#{err_code}_message"])->
  log.info "message: #{message} error: #{err_code}"
  JSON.stringify 
    error: err_code 
    message: message
    payload: payload

exports.error_codes = error_codes = 
  SUCCESS: "200"
  '200_message': "ok"
  NOT_FOUND: "404"
  '404_message': "resource not found"