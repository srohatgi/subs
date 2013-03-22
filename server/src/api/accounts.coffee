{log} = require '../appconfig'
{wrapper,error_codes,mongoose} = require './common_utils'

accountSchema = mongoose.Schema
  first_name: String 
  last_name: String 
  sex: String

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
    log.info "user = #{JSON.stringify req.user}"
    return res.end wrapper null, error_codes.NOT_FOUND, 'unknown account' if not req.user 
    res.end wrapper req.user 

  put: (req,res)->
    log.info "id = #{req.params.id} body = #{JSON.stringify req.body}"
    return res.end wrapper null, error_codes.NOT_FOUND, "need to login first" if not req.user

    d[prop] = req.body[prop] for prop of req.body
    res.end wrapper()

  delete: (req,res)->
    log.info "logging out #{JSON.stringify req.user}"
    req.session.destroy() if req.session
    res.end wrapper()