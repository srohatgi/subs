{log} = require '../appconfig'
mongoose = require 'mongoose'

mongoose.connect('mongodb://localhost/mydb')
db = mongoose.connection
db.on 'error', log.error.bind console, 'connection error'
db.once 'open', -> log.info "connected to mongodb!!"

exports.mongoose = mongoose

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